package com.salesianos.triana.ArtApi.controller;

import com.salesianos.triana.ArtApi.dto.Usuario.*;
import com.salesianos.triana.ArtApi.exception.NotFoundException;
import com.salesianos.triana.ArtApi.exception.LoginBanedException;
import com.salesianos.triana.ArtApi.exception.ThatPublicationIsAlreadyInYourFavouritePublicationException;
import com.salesianos.triana.ArtApi.exception.ThatPublicationIsntInYourFavouriteListException;
import com.salesianos.triana.ArtApi.exception.YouCanNotBanYourself;
import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.repository.UsuarioRepository;
import com.salesianos.triana.ArtApi.security.jwt.JwtProvider;
import com.salesianos.triana.ArtApi.security.jwt.JwtUserResponse;
import com.salesianos.triana.ArtApi.security.jwt.refresh.RefreshToken;
import com.salesianos.triana.ArtApi.security.jwt.refresh.RefreshTokenException;
import com.salesianos.triana.ArtApi.security.jwt.refresh.RefreshTokenRequest;
import com.salesianos.triana.ArtApi.security.jwt.refresh.RefreshTokenService;
import com.salesianos.triana.ArtApi.service.UsuarioService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@Tag(name = "User", description = "El controlador de user tiene diferentes métodos para obtener información variada" +
        " sobre los usuarios, tanto como métodos para el registro y login")
public class UserController {

    private final UsuarioService userService;
    private final AuthenticationManager authManager;
    private final JwtProvider jwtProvider;
    private final UsuarioRepository usuarioRepository;
    private final RefreshTokenService refreshTokenService;


    @Operation(summary = "Obtains a list of users with pageable")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "All users have been found.", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Usuario.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                        "content": [
                                            {
                                                "uuid": "c62db400-22e3-4e92-94db-1447f5688f2c",
                                                "nombre": "admin",
                                                "username": "admin",
                                                "createdAt": "2024-05-31",
                                                "pais": "Croacia",
                                                "favoritos": []
                                            },
                                            {
                                                "uuid": "04d0595e-45d5-4f63-8b53-1d79e9d84a5d",
                                                "nombre": "User 1",
                                                "username": "user1",
                                                "createdAt": "2024-05-31",
                                                "pais": "Inglaterra",
                                                "favoritos": []
                                            },
                                            {
                                                "uuid": "e010f144-b376-4dbb-933d-b3ec8332ed0d",
                                                "nombre": "User 2",
                                                "username": "user2",
                                                "createdAt": "2024-05-31",
                                                "pais": "Inglaterra",
                                                "favoritos": []
                                            },
                                            {
                                                "uuid": "5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2",
                                                "nombre": "User 3",
                                                "username": "user3",
                                                "createdAt": "2024-05-31",
                                                "pais": "Inglaterra",
                                                "favoritos": []
                                            }
                                        ],
                                        "pageable": {
                                            "pageNumber": 0,
                                            "pageSize": 20,
                                            "sort": {
                                                "empty": true,
                                                "sorted": false,
                                                "unsorted": true
                                            },
                                            "offset": 0,
                                            "paged": true,
                                            "unpaged": false
                                        },
                                        "last": true,
                                        "totalPages": 1,
                                        "totalElements": 4,
                                        "first": true,
                                        "size": 20,
                                        "number": 0,
                                        "sort": {
                                            "empty": true,
                                            "sorted": false,
                                            "unsorted": true
                                        },
                                        "numberOfElements": 4,
                                        "empty": false
                                    }""")})}),
            @ApiResponse(responseCode = "404", description = "Not found any category", content = @Content),
    })
    @GetMapping("/admin/users/paged")
    public ResponseEntity<Page<UsuarioDetailDTO>> findAllPageable(@PageableDefault(page = 0, size = 20) Pageable page) {
        Page<Usuario> pagedResult = userService.searchPage(page);
        if (pagedResult.isEmpty()) {
            throw new NotFoundException("User");
        }
        return ResponseEntity.ok(pagedResult.map(UsuarioDetailDTO::of));
    }


    @Operation(summary = "Register user")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201 Created", description = "Register was succesful", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = JwtUserResponse.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                        "uuid": "c62db400-22e3-4e92-94db-1447f5688f2c",
                                        "nombre": "admin",
                                        "username": "admin",
                                        "email": "admin@admin.com",
                                        "createdAt": "2024-05-31",
                                        "pais": "Croacia",
                                        "favoritos": []
                                    }
                                    """) }) }),
            @ApiResponse(responseCode = "400 Bad Request", description = "Register was not succesful", content = @Content),
    })
    @PostMapping("/auth/register")
    public ResponseEntity<JwtUserResponse> createUser(@Valid @RequestBody RegisterUser registerUser) {
        Usuario usuario = userService.createUser(registerUser,"ROLE_USER");
        Authentication authentication = authManager.authenticate(new UsernamePasswordAuthenticationToken(registerUser.username(),registerUser.password()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String token = jwtProvider.generateToken(authentication);
        return ResponseEntity.status(HttpStatus.CREATED).body(JwtUserResponse.of(usuario, token));
    }


    @Operation(summary = "Login user")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201 Created", description = "Login was succesful", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = JwtUserResponse.class)), examples = {
                            @ExampleObject(value = """
                                                                        {
                                                                            "id": "ba00362c-f808-4dfd-8d0c-386d6c1757a9",
                                                                            "username": "alvaro",
                                                                            "email": "user@gmail.com",
                                                                            "nombre": "Alvaro Polonio",
                                                                            "createdAt": "22/11/2023 10:27:44",
                                                                            "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJiYTAwMzYyYy1mODA4LTRkZmQtOGQwYy0zODZkNmMxNzU3YTkiLCJpYXQiOjE3MDA2NDUyNjQsImV4cCI6MTcwMDczMTY2NH0.2a62n6XejYfeInr-00ywKVfm5me6armBPHA7ehLMwyelHvnLUWRLGmLv6CUN6nZd8QvKMlueIRQEezAqmftcPw"
                                                                        }
                                                                        """) }) }),
            @ApiResponse(responseCode = "400 Bad Request", description = "Login was not succesful", content = @Content),
    })
    @PostMapping("/auth/login")
    public ResponseEntity<JwtUserResponse> login(@RequestBody LoginUser loginUser) {

       Usuario findUser = usuarioRepository.findFirstByUsername(loginUser.username()).get();

       if(!findUser.isEnabled()){
           throw new LoginBanedException();
       }

        Authentication authentication = authManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginUser.username(),
                        loginUser.password()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String token = jwtProvider.generateToken(authentication);

        Usuario user = (Usuario) authentication.getPrincipal();

        refreshTokenService.deleteByUser(user);

        RefreshToken refreshToken = refreshTokenService.createRefreshToken(user.getUuid());


        return ResponseEntity.status(HttpStatus.CREATED)
                .body(JwtUserResponse.ofLogin(user, token, refreshToken.getToken()));

    }

    @Operation(summary = "Method to get the details of the authenticated user")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The user list charged successfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Usuario.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                        "uuid": "c62db400-22e3-4e92-94db-1447f5688f2c",
                                        "nombre": "admin",
                                        "username": "admin",
                                        "email": "admin@admin.com",
                                        "createdAt": "2024-05-31",
                                        "pais": "Croacia",
                                        "favoritos": []
                                    }
                                    """) }) }),
            @ApiResponse(responseCode = "404", description = "Not found any user", content = @Content)
    })
    @GetMapping("/user/detail")
    public UsuarioDetailDTO getUserDetails(@AuthenticationPrincipal Usuario user){
        return UsuarioDetailDTO.of(userService.getDetails(user));
    }

    @Operation(summary = "Method to get a user detail by uuid")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The user charged successfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Usuario.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                        "nombre": "User 1",
                                        "username": "user1",
                                        "createdAt": "2022-02-17",                         
                                        "pais": "Croatia"
                                    }
                                                                        """)})}),
            @ApiResponse(responseCode = "404", description = "Not found any user", content = @Content)
    })
    @GetMapping("/admin/user/{uuid}")
    public ResponseEntity<UsuarioDetailDTO> getUserDetails(@PathVariable UUID uuid) {
        if(userService.findByUuid(uuid).isEmpty()){
            throw new NotFoundException("User");
        }
        return ResponseEntity.status(HttpStatus.OK).body(UsuarioDetailDTO.of(userService.findByUuid(uuid).get()));

    }

    @Operation(summary = "Method to get the All Users details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The user list charged successfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Usuario.class)), examples = {
                            @ExampleObject(value = """
                                    [
                                        {
                                                "uuid": "c62db400-22e3-4e92-94db-1447f5688f2c",
                                                "nombre": "admin",
                                                "username": "admin",
                                                "createdAt": "2024-05-31",
                                                "pais": "Croacia",
                                                "favoritos": []
                                            },
                                            {
                                                "uuid": "04d0595e-45d5-4f63-8b53-1d79e9d84a5d",
                                                "nombre": "User 1",
                                                "username": "user1",
                                                "createdAt": "2024-05-31",
                                                "pais": "Inglaterra",
                                                "favoritos": []
                                            },
                                            {
                                                "uuid": "e010f144-b376-4dbb-933d-b3ec8332ed0d",
                                                "nombre": "User 2",
                                                "username": "user2",
                                                "createdAt": "2024-05-31",
                                                "pais": "Inglaterra",
                                                "favoritos": []
                                            },
                                    ]""")})}),
            @ApiResponse(responseCode = "204", description = "Not found any user", content = @Content)
    })
    @GetMapping("/admin/users")
    public ResponseEntity<List<UsuarioDetailDTO>> getAllUsers() {
        if(userService.findAll().isEmpty()){
            throw new NotFoundException("User");
        }
        return ResponseEntity.ok(userService.findAll().stream().map(UsuarioDetailDTO::of).toList());
    }

    @Operation(summary = "Create a user with admin role")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201 Created", description = "User with admin has been created succesful", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = JwtUserResponse.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                        "id": "fec4ae8a-d6b6-4e11-ab1f-c2ef1956174e",
                                        "username": "newusuario",
                                        "email": "newusuario@gmail.com",
                                        "nombre": "Antonio Perez",
                                        "pais": "Nueva Zelanda",
                                        "role": "ROLE_ADMIN",
                                        "createdAt": "31/05/2024 10:23:57",
                                        "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJmZWM0YWU4YS1kNmI2LTRlMTEtYWIxZi1jMmVmMTk1NjE3NGUiLCJpYXQiOjE3MTcxNDM4MzcsImV4cCI6MTcxNzc0ODYzN30.9-DeZIk_8JTA6z4sf5o3xDbO_v-xZ76Gu6JLnOrZaVRgIQ2TtK-R5jHEhivxLmBzXcMl9GEE6j06gLPW_NorLA"
                                    }
                                    """) }) }),
            @ApiResponse(responseCode = "400 Bad Request", description = "User with admin was not created", content = @Content),
    })
    @PostMapping("/admin/create/admin")
    public ResponseEntity<JwtUserResponse> createAdmin(@Valid @RequestBody RegisterUser newAdmin) {
        Usuario usuario = userService.createUser(newAdmin,"ROLE_ADMIN");

        return ResponseEntity.status(HttpStatus.CREATED).body(new JwtUserResponse(JwtUserResponse.of(usuario)));
    }

    @Operation(summary = "Method to add favorite an publication")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The publication added to favorite successfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Usuario.class)))}),
            @ApiResponse(responseCode = "404", description = "Not found any user or publication with that UUID", content = @Content),
            @ApiResponse(responseCode = "400", description = "That publication is already in your favorite publications", content = @Content)
    })
    @PostMapping("/favorites/add/{publicationId}")
    public ResponseEntity<?> addToFavorites(@AuthenticationPrincipal Usuario user, @PathVariable UUID publicationId) {
        UUID userId = userService.getDetails(user).getUuid();

        if (userService.isThatPublicationInFavorites(userId, publicationId)) {
            throw new ThatPublicationIsAlreadyInYourFavouritePublicationException();
        }
        try {
            userService.addToFavorites(userId, publicationId);
            return ResponseEntity.ok().build();
        } catch (EntityNotFoundException e) {
            throw new NotFoundException("User");
        }
    }

    @Operation(summary = "Edit the user details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The user has been edited succesfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Usuario.class)), examples = {
                            @ExampleObject(value = """
                                            {
                                                "uuid": "c62db400-22e3-4e92-94db-1447f5688f2c",
                                                "nombre": "admin",
                                                "username": "admin",
                                                "createdAt": "2024-05-31",
                                                "email": "admin.editado@gmail.com",
                                                "role": "ROLE_ADMIN",
                                                "pais": "Croacia editadoo",
                                                "favoritos": []
                                            }
                                            """)})}),
            @ApiResponse(responseCode = "404", description = "Not found user with that UUID", content = @Content),
    })
    @PutMapping("/admin/edit/user/{userUuid}")
    public ResponseEntity<?> editUser(@PathVariable UUID userUuid,@RequestBody EditUserDTO usuarioDTO) {

        Optional<Usuario> user = userService.findByUuid(userUuid);

        if(user.isEmpty()){
            throw new NotFoundException("User");
        }else{
            userService.editUser(usuarioDTO, user.get());
            return new ResponseEntity<>(UsuarioDetailDTO.of(user.get()), HttpStatus.OK);
        }
    }

    @Operation(summary = "Method to remove favorite an publication")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "The publication favorite removed successfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Usuario.class)))}),
            @ApiResponse(responseCode = "404", description = "Not found any user or publication with that UUID", content = @Content),
            @ApiResponse(responseCode = "400", description = "That publication isn't in your favorite list", content = @Content)
    })
    @DeleteMapping("/favorites/remove/{publicationId}")
    public ResponseEntity<?> removeFromFavorites(@AuthenticationPrincipal Usuario user, @PathVariable UUID publicationId) {
        UUID userId = userService.getDetails(user).getUuid();

        if (!userService.isThatPublicationInFavorites(userId, publicationId)) {
            throw new ThatPublicationIsntInYourFavouriteListException();
        }

        try {
            userService.removeFromFavorites(userId, publicationId);
            return ResponseEntity.noContent().build();
        } catch (EntityNotFoundException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @Operation(summary = "Ban a user by UUID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "User banned successfully", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = Usuario.class),
                            examples = {
                                    @ExampleObject(value = """
                                            {
                                                "uuid": "04d0595e-45d5-4f63-8b53-1d79e9d84a5d",
                                                "nombre": "User 1",
                                                "username": "user1",
                                                "email": "user1@user.com",
                                                "role": "ROLE_USER",
                                                "isEnabled": false
                                            }""")
                            })}),
            @ApiResponse(responseCode = "403", description = "You cannot ban yourself", content = @Content),
            @ApiResponse(responseCode = "404", description = "User not found with that UUID", content = @Content)
    })
    @PutMapping("/admin/ban/user/{userUuid}")
    public ResponseEntity<?> banUser(@PathVariable UUID userUuid, @AuthenticationPrincipal Usuario userAuthenticated) {

        Optional<Usuario> user = userService.findByUuid(userUuid);

        if(user.isEmpty()){
            throw new NotFoundException("User");
        }else{
            Usuario userResult = user.get();
            if (userResult.getUuid().equals(userAuthenticated.getUuid())) {
                throw new YouCanNotBanYourself();
            }
            userResult.setEnabled(false);
            userService.save(userResult);
            return new ResponseEntity<>(GetUsuarioEnabledDTO.of(userResult), HttpStatus.OK);
        }
    }

    @Operation(summary = "Filter user by username")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "User or users found for the given username", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Usuario.class))),
                    @Content(mediaType = "application/json", examples = {
                            @ExampleObject(
                                    value = """
                                    [
                                        {
                                            "uuid": "123e4567-e89b-12d3-a456-426614174000",
                                            "nombre": "Usuario1",
                                            "username": "user1",
                                            "email": "usuario1@example.com",
                                            "role": "USER",
                                            "createdAt": "2024-06-12",
                                            "isEnabled": true,
                                            "pais": "Spain",
                                            "favoritos": [],
                                            "publications": 3
                                        },
                                        {
                                            "uuid": "123e4567-e89b-12d3-a456-426614174001",
                                            "nombre": "Usuario2",
                                            "username": "user2",
                                            "email": "usuario2@example.com",
                                            "role": "USER",
                                            "createdAt": "2024-06-13",
                                            "isEnabled": true,
                                            "pais": "Spain",
                                            "favoritos": [],
                                            "publications": 5
                                        }
                                    ]
                                    """
                            )
                    })
            }),
            @ApiResponse(responseCode = "404", description = "No users found for the given username", content = @Content)
    })
    @GetMapping("/admin/filter/username/{username}")
    public ResponseEntity<List<UsuarioDetailDTO>> filterUserPerUsername(@PathVariable String username) {
        List<UsuarioDetailDTO> usuariosDTO = userService.findByUsernameContainingIgnoreCase(username)
                .stream()
                .map(UsuarioDetailDTO::of)
                .collect(Collectors.toList());

        if (!usuariosDTO.isEmpty()) {
            return ResponseEntity.ok(usuariosDTO);
        } else {
            throw new NotFoundException("User");
        }
    }

    @PostMapping("/refreshtoken")
    public ResponseEntity<?> refreshToken(@RequestBody RefreshTokenRequest refreshTokenRequest){
        String refreshToken = refreshTokenRequest.getRefreshToken();

        return refreshTokenService.findByToken(refreshToken)
                .map(refreshTokenService::verify)
                .map(RefreshToken::getUsuario)
                .map(user -> {
                    String token = jwtProvider.generateToken(user);
                    refreshTokenService.deleteByUser(user);
                    RefreshToken refreshToken2 = refreshTokenService.createRefreshToken(user.getUuid());
                    return ResponseEntity.status(HttpStatus.CREATED)
                            .body(JwtUserResponse.builder()
                                    .token(token)
                                    .refreshToken(refreshToken2.getToken())
                                    .build()
                            );
                }).orElseThrow(() -> new RefreshTokenException("Refresh token not found"));
    }

}
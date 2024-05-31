package com.salesianos.triana.ArtApi.controller;

import com.salesianos.triana.ArtApi.dto.Categoria.GetCategoriaDTO;
import com.salesianos.triana.ArtApi.dto.Usuario.RegisterUser;
import com.salesianos.triana.ArtApi.dto.Usuario.UsuarioDetailDTO;
import com.salesianos.triana.ArtApi.model.Categoria;
import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.dto.Usuario.LoginUser;
import com.salesianos.triana.ArtApi.repository.UsuarioRepository;
import com.salesianos.triana.ArtApi.security.jwt.JwtProvider;
import com.salesianos.triana.ArtApi.security.jwt.JwtUserResponse;
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
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@Tag(name = "User", description = "El controlador de user tiene diferentes métodos para obtener información variada" +
        " sobre los usuarios, tanto como métodos para el registro y login")
public class UserController {

    private final UsuarioService userService;
    private final AuthenticationManager authManager;
    private final JwtProvider jwtProvider;
    private final UsuarioRepository usuarioRepository;


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
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(pagedResult.map(UsuarioDetailDTO::of));
    }


    @Operation(summary = "Register user")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201 Created", description = "Register was succesful", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = JwtUserResponse.class)), examples = {
                            @ExampleObject(value = """
                                                                        {
                                                                            "id": "ba00362c-f808-4dfd-8d0c-386d6c1757a9",
                                                                            "username": "alexluque",
                                                                            "email": "user@gmail.com",
                                                                            "nombre": "Alexander Luque",
                                                                            "createdAt": "22/11/2023 10:27:44",
                                                                            "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJiYTAwMzYyYy1mODA4LTRkZmQtOGQwYy0zODZkNmMxNzU3YTkiLCJpYXQiOjE3MDA2NDUyNjQsImV4cCI6MTcwMDczMTY2NH0.2a62n6XejYfeInr-00ywKVfm5me6armBPHA7ehLMwyelHvnLUWRLGmLv6CUN6nZd8QvKMlueIRQEezAqmftcPw"
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
           return ResponseEntity.status(403).build(); //Devolver excepcion personalizada
       }

        Authentication authentication = authManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginUser.username(),
                        loginUser.password()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String token = jwtProvider.generateToken(authentication);

        Usuario user = (Usuario) authentication.getPrincipal();

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(JwtUserResponse.ofLogin(user, token));

    }

    @Operation(summary = "Method to get the details of the authenticated user")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The user list charged successfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Usuario.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                        "id": "04d0595e-45d5-4f63-8b53-1d79e9d84a5d",
                                        "username": "user1",
                                        "nombre": "User 1",
                                        "saldo": 20.0
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
            return ResponseEntity.notFound().build();
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
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(userService.findAll().stream().map(UsuarioDetailDTO::of).toList());
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
            return ResponseEntity.badRequest().body("That publication is already in your favorite publications");
        }
        try {
            userService.addToFavorites(userId, publicationId);
            return ResponseEntity.ok().build();
        } catch (EntityNotFoundException e) {
            return ResponseEntity.notFound().build();
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
            return ResponseEntity.badRequest().body("That publication isn't in your favorite list");
        }

        try {
            userService.removeFromFavorites(userId, publicationId);
            return ResponseEntity.noContent().build();
        } catch (EntityNotFoundException e) {
            return ResponseEntity.notFound().build();
        }
    }



}
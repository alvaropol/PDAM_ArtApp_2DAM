package com.salesianos.triana.ArtApi.controller;

import com.salesianos.triana.ArtApi.dto.Comentario.CreateComentarioDTO;
import com.salesianos.triana.ArtApi.dto.Comentario.GetComentarioDTO;
import com.salesianos.triana.ArtApi.dto.Comentario.GetComentarioPagedDTO;
import com.salesianos.triana.ArtApi.dto.Comentario.GetComentarioPostResponse;
import com.salesianos.triana.ArtApi.exception.NotFoundException;
import com.salesianos.triana.ArtApi.model.Comentario;
import com.salesianos.triana.ArtApi.model.Publicacion;
import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.service.ComentarioService;
import com.salesianos.triana.ArtApi.service.PublicacionService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@Tag(name = "Comentario", description = "El controlador de comentario tiene diferentes métodos para crear" +
        "diferentes comentarios en las diferentes publicaciones.")
public class ComentarioController {

    private final ComentarioService service;
    private final PublicacionService publicacionService;


    @Operation(summary = "Method to add a comment in a publication")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "The comment added to publication successfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Comentario.class)))}),
            @ApiResponse(responseCode = "404", description = "Not found any user or publication with that UUID", content = @Content),
            @ApiResponse(responseCode = "400", description = "The comment is empty", content = @Content)
    })
    @PostMapping("/comment/add/publication/{publicationId}")
    public ResponseEntity<GetComentarioPostResponse> addCommentToPublication(@Valid @RequestBody CreateComentarioDTO dto, @AuthenticationPrincipal Usuario user, @PathVariable UUID publicationId) {

        Optional<Publicacion> publicacionOptional = publicacionService.findByUuidOptional(publicationId);

        if(publicacionOptional.isEmpty())
            throw new NotFoundException("Comment");

        Comentario comentario= service.createComment(dto,publicacionOptional.get(),user);
        return new ResponseEntity<>(GetComentarioPostResponse.of(comentario), HttpStatus.CREATED);
    }

    @Operation(summary = "Obtains a list of comments with pageable")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "All comments have been found.", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Comentario.class)), examples = {
                            @ExampleObject(value = """
                                    [
                                        {
                                            "uuidComment": "7e63d4d2-b8dd-475e-8b8b-0f7d117a4e6c",
                                            "usuario": "user1",
                                             "comment": "La peor obra que he visto en ArtApp!!",
                                            "publication": {
                                                                uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                                "titulo": "Las Meninas",
                                                                 "image": "https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg",
                                                                  "cantidadValoraciones": 2,
                                                                   "valoracionMedia": 3.0
                                                            },

                                        },
                                        {
                                            "uuidComment": "7e63d4d2-b8dd-475e-8b8b-0f7d117a4e6c",
                                            "usuario": "user2",
                                             "comment": "No me gustan mucho los simbolos que se utilizan en la obra.",
                                            "publication": {
                                                                uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                                "titulo": "Las Meninas",
                                                                 "image": "https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg",
                                                                  "cantidadValoraciones": 2,
                                                                   "valoracionMedia": 3.0
                                                            },

                                        },
                                        {
                                            "uuidComment": "7e63d4d2-b8dd-475e-8b8b-0f7d117a4e6c",
                                            "usuario": "user3",
                                            "comment": "Me parece una buena obra, pero muy compleja",
                                            "publication": {
                                                                uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                                "titulo": "Las Meninas",
                                                                 "image": "https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg",
                                                                  "cantidadValoraciones": 2,
                                                                   "valoracionMedia": 3.0
                                                            },

                                        }

                                    ]
                                    """)})}),
            @ApiResponse(responseCode = "404", description = "Not found any comment", content = @Content),
    })
    @GetMapping("/admin/comments/paged")
    public ResponseEntity<Page<GetComentarioPagedDTO>> findAllPageable(@PageableDefault(page = 0, size = 20) Pageable page) {
        Page<Comentario> pagedResult = service.searchPage(page);
        if (pagedResult.isEmpty()) {
            throw new NotFoundException("Comment");
        }
        return ResponseEntity.ok(pagedResult.map(GetComentarioPagedDTO::of));
    }

    @Operation(summary = "Method to remove an comment")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "The comment of that publication has been removed  successfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Comentario.class)))}),
            @ApiResponse(responseCode = "404", description = "Not found any comment with that UUID", content = @Content)
    })
    @DeleteMapping("/admin/comment/remove/{commentUuid}")
    public ResponseEntity<?> removeComment(@PathVariable UUID commentUuid){
        Optional<Comentario> comment = service.findByUuidOptional(commentUuid);
        if(comment .isEmpty()){
            throw new NotFoundException("Comment");
        }else{
            service.deleteComment(comment.get());
            return ResponseEntity.noContent().build();
        }
    }

    @Operation(summary = "Find comments by username filter")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Comments found for the given username", content = {
                    @io.swagger.v3.oas.annotations.media.Content(mediaType = "application/json", examples = {
                            @io.swagger.v3.oas.annotations.media.ExampleObject(
                                    value = """
                                    [
                                        {
                                            "usuario": "user1",
                                            "comment": "Beautiful publication."
                                        },
                                        {
                                            "usuario": "user2",
                                            "comment": "I dont like it, sorry."
                                        }
                                    ]
                                    """
                            )
                    })
            }),
            @ApiResponse(responseCode = "404", description = "No comments found for the given username", content = @io.swagger.v3.oas.annotations.media.Content)
    })
    @GetMapping("/comment/filter/{username}")
    public ResponseEntity<List<GetComentarioDTO>> findByUsername(@PathVariable String username) {
        List<GetComentarioDTO> comentarios = service.findByUsernameContainingIgnoreCase(username);
        if (!comentarios.isEmpty()) {
            return ResponseEntity.ok(comentarios);
        } else {
            throw new NotFoundException("Comment");
        }
    }

}

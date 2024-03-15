package com.salesianos.triana.ArtApi.controller;

import com.salesianos.triana.ArtApi.dto.Comentario.CreateComentarioDTO;
import com.salesianos.triana.ArtApi.dto.Comentario.GetComentarioPostResponse;
import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicacionDTO;
import com.salesianos.triana.ArtApi.model.Comentario;
import com.salesianos.triana.ArtApi.model.Publicacion;
import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.service.ComentarioService;
import com.salesianos.triana.ArtApi.service.PublicacionService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

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
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Usuario.class)))}),
            @ApiResponse(responseCode = "404", description = "Not found any user or publication with that UUID", content = @Content),
            @ApiResponse(responseCode = "400", description = "The comment is empty", content = @Content)
    })
    @PostMapping("/comment/add/publication/{publicationId}")
    public ResponseEntity<GetComentarioPostResponse> addCommentToPublication(@Valid @RequestBody CreateComentarioDTO dto, @AuthenticationPrincipal Usuario user, @PathVariable UUID publicationId) {

        Optional<Publicacion> publicacionOptional = publicacionService.findByUuidOptional(publicationId);

        if(publicacionOptional.isEmpty())
            return ResponseEntity.notFound().build();
        if(dto.comment().isEmpty()){
            return ResponseEntity.badRequest().build();
        }

        Comentario comentario= service.createComment(dto,publicacionOptional.get(),user);
        return new ResponseEntity<>(GetComentarioPostResponse.of(comentario), HttpStatus.CREATED);
    }
}

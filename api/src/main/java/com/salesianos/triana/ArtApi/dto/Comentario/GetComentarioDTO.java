package com.salesianos.triana.ArtApi.dto.Comentario;

import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicacionDTO;
import com.salesianos.triana.ArtApi.model.Comentario;
import com.salesianos.triana.ArtApi.model.Publicacion;

import java.util.List;

public record GetComentarioDTO(
        String usuario,
        String comment
) {
    public static GetComentarioDTO of(Comentario c){

        return new GetComentarioDTO(
                c.getUsuario().getUsername(),
                c.getComment()
        );
    }
}

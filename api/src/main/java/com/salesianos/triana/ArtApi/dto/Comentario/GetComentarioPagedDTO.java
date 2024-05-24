package com.salesianos.triana.ArtApi.dto.Comentario;

import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicationDTOForCategory;
import com.salesianos.triana.ArtApi.model.Comentario;

public record GetComentarioPagedDTO(
        String uuidComment,
        String usuario,
        String comment,
        GetPublicationDTOForCategory publication
) {
    public static GetComentarioPagedDTO of(Comentario c){

        return new GetComentarioPagedDTO(
                c.getUuid().toString(),
                c.getUsuario().getUsername(),
                c.getComment(),
                GetPublicationDTOForCategory.of(c.getPublicacion())
        );
    }
}

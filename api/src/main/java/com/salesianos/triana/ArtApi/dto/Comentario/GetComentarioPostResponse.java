package com.salesianos.triana.ArtApi.dto.Comentario;

import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicationDTOForCategory;
import com.salesianos.triana.ArtApi.model.Comentario;

public record GetComentarioPostResponse(
        String usuario,

        String comment,

        GetPublicationDTOForCategory publication
) {

    public static GetComentarioPostResponse of(Comentario c){

        return new GetComentarioPostResponse(
                c.getUsuario().getUsername(),
                c.getComment(),
                GetPublicationDTOForCategory.of(c.getPublicacion())
        );
    }


}

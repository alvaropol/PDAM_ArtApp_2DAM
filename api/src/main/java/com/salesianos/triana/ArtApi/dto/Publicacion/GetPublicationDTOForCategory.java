package com.salesianos.triana.ArtApi.dto.Publicacion;

import com.salesianos.triana.ArtApi.dto.Comentario.GetComentarioDTO;
import com.salesianos.triana.ArtApi.model.Categoria;
import com.salesianos.triana.ArtApi.model.Publicacion;

import java.util.Collections;

public record GetPublicationDTOForCategory(
        String uuid,
        String titulo,
        String image,
        int cantidadValoraciones,
        double valoracionMedia
) {
    public static GetPublicationDTOForCategory of(Publicacion p){

        return new GetPublicationDTOForCategory (
                p.getUuid().toString(),
                p.getTitulo(),
                p.getImage(),
                p.getValoraciones().size(),
                p.getValoracionMedia()
        );
    }
}

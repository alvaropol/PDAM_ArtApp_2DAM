package com.salesianos.triana.ArtApi.dto.Categoria;

import com.salesianos.triana.ArtApi.dto.Comentario.GetComentarioDTO;
import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicacionDTO;
import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicationDTOForCategory;
import com.salesianos.triana.ArtApi.model.Categoria;
import com.salesianos.triana.ArtApi.model.Publicacion;

import java.util.Collections;
import java.util.List;

public record GetCategoriaDTO(
        String uuid,
        Long numero,
        String nombre,
        String image,
        List<GetPublicationDTOForCategory> publicaciones

) {
    public static GetCategoriaDTO of(Categoria c){

        return new GetCategoriaDTO (
                c.getUuid().toString(),
                c.getNumero(),
                c.getNombre(),
                c.getImage(),
                c.getPublicaciones() == null ? Collections.emptyList() : c.getPublicaciones().stream().map(GetPublicationDTOForCategory::of).toList()
        );
    }
}

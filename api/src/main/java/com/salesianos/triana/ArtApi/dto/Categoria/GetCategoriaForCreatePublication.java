package com.salesianos.triana.ArtApi.dto.Categoria;

import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicationDTOForCategory;
import com.salesianos.triana.ArtApi.model.Categoria;

import java.util.Collections;

public record GetCategoriaForCreatePublication(
        String nombre,
        Long numero
) {

    public static GetCategoriaForCreatePublication of(Categoria c){
        return new GetCategoriaForCreatePublication (
                c.getNombre(),
                c.getNumero()
        );
    }
}

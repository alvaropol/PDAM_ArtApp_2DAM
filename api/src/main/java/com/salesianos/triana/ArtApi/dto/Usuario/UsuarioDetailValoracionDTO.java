package com.salesianos.triana.ArtApi.dto.Usuario;

import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicationDTOForCategory;
import com.salesianos.triana.ArtApi.model.Usuario;

import java.util.Collections;

public record UsuarioDetailValoracionDTO(
        String uuid,
        String nombre,
        String username

) {

    public static UsuarioDetailValoracionDTO of(Usuario u){
        return new UsuarioDetailValoracionDTO(
                u.getUuid().toString(),
                u.getNombre(),
                u.getUsername()
        );
    }

}

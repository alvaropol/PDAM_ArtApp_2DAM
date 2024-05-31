package com.salesianos.triana.ArtApi.dto.Usuario;


import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicationDTOForCategory;
import com.salesianos.triana.ArtApi.model.Usuario;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

public record UsuarioDetailDTO(
        @NotNull UUID uuid,
        @NotEmpty String nombre,
        @NotEmpty String username,
        @NotEmpty String email,
        @NotNull LocalDate createdAt,
        String pais,
        List<GetPublicationDTOForCategory> favoritos) {

    public static UsuarioDetailDTO of(Usuario u){
        return new UsuarioDetailDTO(
                u.getUuid(),
                u.getNombre(),
                u.getUsername(),
                u.getEmail(),
                u.getCreatedAt().toLocalDate(),
                u.getPais(),
                u.getFavoritos() == null ? Collections.emptyList(): u.getFavoritos().stream().map(GetPublicationDTOForCategory::of).toList()
        );
    }
}
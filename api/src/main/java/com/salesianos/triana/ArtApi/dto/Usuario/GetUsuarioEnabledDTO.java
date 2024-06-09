package com.salesianos.triana.ArtApi.dto.Usuario;

import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicationDTOForCategory;
import com.salesianos.triana.ArtApi.model.Usuario;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

import java.util.Collections;
import java.util.UUID;

public record GetUsuarioEnabledDTO(
        @NotNull UUID uuid,
        @NotEmpty String nombre,
        @NotEmpty String username,
        @NotEmpty String email,
        @NotEmpty String role,
        @NotNull boolean isEnabled
) {

    public static GetUsuarioEnabledDTO of(Usuario u){
        return new GetUsuarioEnabledDTO(
                u.getUuid(),
                u.getNombre(),
                u.getUsername(),
                u.getEmail(),
                u.getRole(),
                u.isEnabled()
        );
    }
}

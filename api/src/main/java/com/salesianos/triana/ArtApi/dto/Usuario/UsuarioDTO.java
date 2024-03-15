package com.salesianos.triana.ArtApi.dto.Usuario;


import com.salesianos.triana.ArtApi.model.Usuario;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;
import java.util.UUID;

public record UsuarioDTO(@NotNull UUID id, @NotNull LocalDate createdAt, @NotEmpty String email,
                             @NotEmpty String nombre, @NotEmpty String username, String pais) {

    public static UsuarioDTO of(Usuario u){
        return new UsuarioDTO(u.getUuid()   ,
                u.getCreatedAt().toLocalDate(),
                u.getEmail(),
                u.getNombre(),
                u.getUsername(),
                u.getPais());
    }
}
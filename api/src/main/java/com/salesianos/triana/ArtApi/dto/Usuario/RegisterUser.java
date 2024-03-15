package com.salesianos.triana.ArtApi.dto.Usuario;

import com.salesianos.triana.ArtApi.validation.annotation.FieldsValueMatch;
import com.salesianos.triana.ArtApi.validation.annotation.UniqueUsername;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@FieldsValueMatch(
        field = "password", fieldMatch = "verifyPassword",
        message = "{registerUser.password.nomatch}"
)
public record RegisterUser(
        @NotBlank(message = "{registerUser.username.notblank}")
        @UniqueUsername
        String username,

        @NotBlank(message = "{registerUser.password.notblank}")
        @Size(min = 6, message = "{registerUser.password.size}")
        String password,

        @NotBlank(message = "{registerUser.verifyPassword.notblank}")
        String verifyPassword,

        @NotBlank(message = "{registerUser.email.notblank}")
        @Email(message = "{registerUser.email.email}")
        String email,

        @NotBlank(message = "{registerUser.nombre.notblank}")
        String nombre,

        @NotBlank(message = "{registerUser.pais.notblank}")
        String pais
) {
}
package com.salesianos.triana.ArtApi.dto.Categoria;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record CreateCategoryDTO(

        @NotBlank(message = "El título de categoría es obligatorio")
        @Size(min = 3, max = 31, message = "El título debe tener entre 3 y 31 caracteres")
        String nombre,

        String image
) {

}

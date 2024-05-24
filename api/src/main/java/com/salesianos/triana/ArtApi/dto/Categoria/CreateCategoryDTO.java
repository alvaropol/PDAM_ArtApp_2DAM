package com.salesianos.triana.ArtApi.dto.Categoria;

import jakarta.validation.constraints.NotBlank;

public record CreateCategoryDTO(

        @NotBlank(message = "El titulo de categoría es obligatorio")
        String nombre,

        String image
) {

}

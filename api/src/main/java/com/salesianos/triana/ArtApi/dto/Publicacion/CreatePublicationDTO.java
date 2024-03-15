package com.salesianos.triana.ArtApi.dto.Publicacion;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record CreatePublicationDTO(

        @NotBlank(message = "El título es obligatorio")
        @Size(min = 3, max = 31, message = "El título debe tener entre 3 y 31 caracteres")
        String titulo,

        @NotBlank(message = "La descripcion es obligatoria")
        String descripcion,

        @NotBlank(message = "El tamanyo de las dimensiones es obligatorio")
        String tamanyoDimensiones,

        @NotBlank(message = "La direccion de la obra es obligatoria")
        String direccionObra,

        @NotBlank(message = "El nombre del museo es obligatorio")
        String nombreMuseo,

        @NotBlank(message = "La latitud es obligatoria")
        @Pattern(regexp = "-?\\d+(\\.\\d+)?", message = "La latitud debe tener un formato válido")
        String lat,

        @NotBlank(message = "La longitud es obligatoria")
        @Pattern(regexp = "-?\\d+(\\.\\d+)?", message = "La longitud debe tener un formato válido")
        String lon,

        String image,

        @NotNull(message = "El número de categoría es obligatorio")
        Long numeroCategoria
) {}

package com.salesianos.triana.ArtApi.dto.Comentario;

import jakarta.validation.constraints.NotEmpty;

public record CreateComentarioDTO(

        @NotEmpty
        String comment
) {

}

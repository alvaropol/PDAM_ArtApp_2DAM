package com.salesianos.triana.ArtApi.dto.Publicacion;

import com.salesianos.triana.ArtApi.dto.Comentario.GetComentarioDTO;
import com.salesianos.triana.ArtApi.model.Categoria;
import com.salesianos.triana.ArtApi.model.Publicacion;

import java.util.Collections;
import java.util.List;
import java.util.UUID;

public record GetPublicacionDTO(
        String uuid,
        String artista,
        String titulo,
        String descripcion,
        String tamanyoDimensiones,
        String direccionObra,
        String nombreMuseo,
        String lat,
        String lon,
        double valoracionMedia,
        String image,
        String categoria,

        int cantidadValoraciones,

        List<GetComentarioDTO> comentarios

) {
    public static GetPublicacionDTO of(Publicacion p){

        return new GetPublicacionDTO (
                p.getUuid().toString(),
                p.getUsuario().getNombre(),
                p.getTitulo(),
                p.getDescripcion(),
                p.getTamanyoDimensiones(),
                p.getDireccionObra(),
                p.getNombreMuseo(),
                p.getLat(),
                p.getLon(),
                p.getValoracionMedia(),
                p.getImage(),
                p.getCategoria() == null || p.getCategoria().getNumero() == null ? "Sin categoria" : p.getCategoria().getNombre(),
                p.getValoraciones().size(),
                p.getComentarios() == null ? Collections.emptyList() : p.getComentarios().stream().map(GetComentarioDTO::of).toList()
        );
    }
}

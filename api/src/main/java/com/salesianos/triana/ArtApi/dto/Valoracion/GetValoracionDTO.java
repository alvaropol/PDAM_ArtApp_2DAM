package com.salesianos.triana.ArtApi.dto.Valoracion;

import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicationDTOForCategory;
import com.salesianos.triana.ArtApi.dto.Usuario.UsuarioDetailValoracionDTO;
import com.salesianos.triana.ArtApi.model.Valoracion;



public record GetValoracionDTO(

        GetPublicationDTOForCategory publication,
        UsuarioDetailValoracionDTO user,

        int rating) {

    public static GetValoracionDTO of(Valoracion v){
        return new GetValoracionDTO(
                GetPublicationDTOForCategory.of(v.getPublicacion()),
                UsuarioDetailValoracionDTO.of(v.getUsuario()),
                v.getPuntuacion()
        );
    }


}

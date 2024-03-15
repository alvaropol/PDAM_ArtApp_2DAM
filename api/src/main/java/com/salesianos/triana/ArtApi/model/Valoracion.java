package com.salesianos.triana.ArtApi.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@IdClass(ValoracionPK.class)
public class Valoracion {

    @Id
    @ManyToOne
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;

    @Id
    @ManyToOne
    @JoinColumn(name = "publicacion_id")
    private Publicacion publicacion;

    private int puntuacion;

    public ValoracionPK getId() {
        return new ValoracionPK(usuario,publicacion);
    }

    public void setId(ValoracionPK valoracionPK) {
        this.usuario = valoracionPK.getUsuario();
        this.publicacion = valoracionPK.getPublicacion();
    }
}

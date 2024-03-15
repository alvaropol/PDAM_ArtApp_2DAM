package com.salesianos.triana.ArtApi.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.UuidGenerator;

import java.util.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Publicacion {

    @Id
    @GeneratedValue(generator = "UUID")
    @UuidGenerator
    @Column(columnDefinition = "uuid")
    private UUID uuid;

    private String titulo;
    private String descripcion;
    private String tamanyoDimensiones;
    private String direccionObra;
    private String nombreMuseo;
    private String lat;
    private String lon;
    private double valoracionMedia;
    private String image;

    @ManyToOne
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "categoria_id")
    private Categoria categoria;

    @OneToMany(mappedBy = "publicacion", cascade = CascadeType.REMOVE, orphanRemoval = true)
    private List<Comentario> comentarios = new ArrayList<>();

    @OneToMany(mappedBy = "publicacion", cascade = CascadeType.REMOVE, orphanRemoval = true)
    private Set<Valoracion> valoraciones = new HashSet<>();
}

package com.salesianos.triana.ArtApi.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.NaturalId;
import org.hibernate.annotations.UuidGenerator;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Categoria {

    @Id
    @GeneratedValue(generator = "UUID")
    @UuidGenerator
    @Column(columnDefinition = "uuid")
    private UUID uuid;

    @NaturalId
    private Long numero;

    private String nombre;

    private String image;

    @OneToMany(mappedBy = "categoria")
    private List<Publicacion> publicaciones = new ArrayList<>();

}

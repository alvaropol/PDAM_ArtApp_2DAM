package com.salesianos.triana.ArtApi.repository;

import com.salesianos.triana.ArtApi.model.Publicacion;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface PublicacionRepository extends JpaRepository<Publicacion, UUID> {

    @Query("""
            select p from Publicacion p
            """)
    Page<Publicacion> searchPage(Pageable pageable);

    @Query("SELECT p FROM Publicacion p WHERE p.usuario.uuid = :usuarioUuid")
    List<Publicacion> findAllPublicationsByUuidUser(@Param("usuarioUuid") UUID usuarioUuid);

    @Query("SELECT p FROM Publicacion p WHERE LOWER(p.categoria.nombre) LIKE LOWER(CONCAT('%', :nombreCategoria, '%'))")
    List<Publicacion> findByCategoriaNombre(@Param("nombreCategoria") String nombreCategoria);
}


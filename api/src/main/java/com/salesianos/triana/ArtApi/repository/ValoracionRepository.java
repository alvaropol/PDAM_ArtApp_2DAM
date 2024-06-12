package com.salesianos.triana.ArtApi.repository;

import com.salesianos.triana.ArtApi.model.Publicacion;
import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.model.Valoracion;
import com.salesianos.triana.ArtApi.model.ValoracionPK;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ValoracionRepository extends JpaRepository<Valoracion, ValoracionPK> {
    Optional<Valoracion> findByUsuarioAndPublicacion(Usuario usuario, Publicacion publicacion);

    @Query("SELECT v.publicacion FROM Valoracion v WHERE v.usuario = :usuario")
    List<Publicacion> findPublicacionesValoradasPorUsuario(Usuario usuario);

    @Query("""
            select v from Valoracion v
            """)
    Page<Valoracion> searchPage(Pageable pageable);

    List<Valoracion> findByPuntuacion(int puntuacion);

}
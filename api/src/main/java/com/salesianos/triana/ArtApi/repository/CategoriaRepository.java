package com.salesianos.triana.ArtApi.repository;

import com.salesianos.triana.ArtApi.model.Categoria;
import com.salesianos.triana.ArtApi.model.Publicacion;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface CategoriaRepository extends JpaRepository<Categoria, UUID> {

    @Query("""
            select c from Categoria c
            """)
    Page<Categoria> searchPage(Pageable pageable);

    Optional<Categoria> findByNumero(Long numero);

    @Query("SELECT COALESCE(MAX(c.numero), 0) FROM Categoria c")
    Long findMaxNumero();
}
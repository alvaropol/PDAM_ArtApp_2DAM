package com.salesianos.triana.ArtApi.repository;

import com.salesianos.triana.ArtApi.model.Comentario;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface ComentarioRepository extends JpaRepository<Comentario, UUID> {

    @Query("""
            select c from Comentario c
            """)
    Page<Comentario> searchPage(Pageable pageable);

    @Query("SELECT c FROM Comentario c WHERE LOWER(c.usuario.username) LIKE LOWER(concat('%', :username, '%'))")
    List<Comentario> findByUsernameIgnoreCaseContaining(@Param("username") String username);
}
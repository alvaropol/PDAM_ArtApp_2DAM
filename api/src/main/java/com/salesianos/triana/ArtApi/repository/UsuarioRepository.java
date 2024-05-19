package com.salesianos.triana.ArtApi.repository;

import com.salesianos.triana.ArtApi.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, UUID> {

    Optional<Usuario> findFirstByUsername(String username);
    boolean existsByUsernameIgnoreCase(String username);

    @Query("SELECT u FROM Usuario u LEFT JOIN FETCH u.publicaciones WHERE u.uuid = :uuid")
    Optional<Usuario> findByUuidWithPublicaciones(@Param("uuid") UUID uuid);
}
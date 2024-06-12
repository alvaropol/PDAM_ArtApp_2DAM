package com.salesianos.triana.ArtApi.repository;

import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.model.Valoracion;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, UUID> {

    Optional<Usuario> findFirstByUsername(String username);

    boolean existsByUsernameIgnoreCase(String username);

    @Query("SELECT u FROM Usuario u LEFT JOIN FETCH u.publicaciones WHERE u.uuid = :uuid")
    Optional<Usuario> findByUuidWithPublicaciones(@Param("uuid") UUID uuid);

    @Query("""
            select u from Usuario u
            """)
    Page<Usuario> searchPage(Pageable pageable);

    @Query("SELECT u FROM Usuario u WHERE LOWER(u.username) LIKE LOWER(concat('%', :username, '%'))")
    List<Usuario> findByUsernameIgnoreCaseContaining(@Param("username") String username);
}
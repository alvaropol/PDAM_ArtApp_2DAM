package com.salesianos.triana.ArtApi.repository;

import com.salesianos.triana.ArtApi.model.Comentario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface ComentarioRepository extends JpaRepository<Comentario, UUID> {
}
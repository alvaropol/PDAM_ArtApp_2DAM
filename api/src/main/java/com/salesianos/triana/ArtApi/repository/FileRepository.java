package com.salesianos.triana.ArtApi.repository;


import com.salesianos.triana.ArtApi.model.File;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface FileRepository extends JpaRepository<File, UUID> {
}

package com.salesianos.triana.ArtApi.service.File;

import com.salesianos.triana.ArtApi.dto.File.FileResponse;
import com.salesianos.triana.ArtApi.model.File;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface FileService {

    File store(MultipartFile file) throws IOException;

    Optional<File> getFile (UUID id) throws FileNotFoundException;

    List<FileResponse> getAllFiles();
}
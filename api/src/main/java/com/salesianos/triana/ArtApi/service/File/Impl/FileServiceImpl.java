package com.salesianos.triana.ArtApi.service.File.Impl;

import com.salesianos.triana.ArtApi.dto.File.FileResponse;
import com.salesianos.triana.ArtApi.model.File;
import com.salesianos.triana.ArtApi.repository.FileRepository;
import com.salesianos.triana.ArtApi.service.File.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class FileServiceImpl implements FileService {

    @Autowired
    private FileRepository fileRepository;
    @Override
    public File store(MultipartFile file) throws IOException {
        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        File File = com.salesianos.triana.ArtApi.model.File.builder()
                .name(fileName)
                .type(file.getContentType())
                .data(file.getBytes())
                .build();
        return fileRepository.save(File);
    }

    @Override
    public Optional<File> getFile(UUID id) throws FileNotFoundException {
        Optional<File> file = fileRepository.findById(id);
        if(file.isPresent()){
            return file;
        }
        throw new FileNotFoundException();
    }

    @Override
    public List<FileResponse> getAllFiles() {
        List<FileResponse> files = fileRepository.findAll().stream().map(dbFile -> {
            String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("/files/")
                    .path(dbFile.getUuid().toString())
                    .toUriString();
            return FileResponse.builder()
                    .name(dbFile.getName())
                    .url(fileDownloadUri)
                    .type(dbFile.getType())
                    .size(dbFile.getData().length).build();

        }).collect(Collectors.toList());
        return files;
    }
}
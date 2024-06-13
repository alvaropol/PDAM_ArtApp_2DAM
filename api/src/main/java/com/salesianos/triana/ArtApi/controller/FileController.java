package com.salesianos.triana.ArtApi.controller;

import com.salesianos.triana.ArtApi.dto.File.FileResponse;
import com.salesianos.triana.ArtApi.dto.File.MessageFileResponse;
import com.salesianos.triana.ArtApi.model.File;
import com.salesianos.triana.ArtApi.service.File.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class FileController {

    @Autowired
    private FileService fileService;

    @PostMapping("/files/upload")
    public ResponseEntity<MessageFileResponse> uploadFile(@RequestParam("file") MultipartFile file) throws IOException {
        fileService.store(file);
        return ResponseEntity.status(HttpStatus.OK).body(new MessageFileResponse("File upload succesfully"));
    }

    @GetMapping("/files/{id}")
    public ResponseEntity<byte[]> getFile(@PathVariable UUID id) throws FileNotFoundException {
        File fileEntity = fileService.getFile(id).get();
        return ResponseEntity.status(HttpStatus.OK)
                .header(HttpHeaders.CONTENT_TYPE, fileEntity.getType())
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileEntity.getName()+"\"")
                .body(fileEntity.getData());
    }

    @GetMapping("/files")
    public ResponseEntity<List<FileResponse>> getListFiles(){
        List<FileResponse> files = fileService.getAllFiles();
        return ResponseEntity.status(HttpStatus.OK).body(files);
    }

}
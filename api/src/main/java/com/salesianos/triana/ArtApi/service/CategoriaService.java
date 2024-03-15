package com.salesianos.triana.ArtApi.service;

import com.salesianos.triana.ArtApi.model.Categoria;
import com.salesianos.triana.ArtApi.repository.CategoriaRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CategoriaService {

    private final CategoriaRepository repository;

    public List<Categoria> findAll(){
        if(repository.findAll().isEmpty())
            throw new EntityNotFoundException("There are no categories");

        return repository.findAll();
    }

    public Page<Categoria> searchPage(Pageable pageable) {
        Page<Categoria> pagedResult = repository.searchPage(pageable);

        if (pagedResult.isEmpty())
            throw new EntityNotFoundException("There are no categories in that page.");

        return pagedResult;
    }

    public Categoria findByUuid(UUID uuid){
        Optional<Categoria> category = repository.findById(uuid);
        return category.orElse(null);
    }

}

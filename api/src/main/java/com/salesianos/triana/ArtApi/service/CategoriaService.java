package com.salesianos.triana.ArtApi.service;

import com.salesianos.triana.ArtApi.dto.Categoria.CreateCategoryDTO;
import com.salesianos.triana.ArtApi.model.Categoria;
import com.salesianos.triana.ArtApi.repository.CategoriaRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Collections;
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

    public Optional<Categoria> findByUuidOptional(UUID uuid){
        return repository.findById(uuid);
    }

    public Categoria createCategory(CreateCategoryDTO categoryDTO) {

        Categoria newCategory = new Categoria();

        newCategory.setNombre(categoryDTO.nombre());
        if(!categoryDTO.image().isEmpty()){
            newCategory.setImage(categoryDTO.image());
        }
        newCategory.setNumero((long) (repository.findAll().size() + 1));
        newCategory.setPublicaciones(Collections.emptyList());

        return repository.save(newCategory);
    }




    public Categoria editCategory(UUID categoriaUuid, CreateCategoryDTO categoryDTO) {

        Categoria editado = findByUuid(categoriaUuid);

        editado.setNombre(categoryDTO.nombre());

        if(!categoryDTO.image().isEmpty()){
            editado.setImage(categoryDTO.image());
        }

        return repository.save(editado);
    }


    public void deleteCategory(Categoria c){
        repository.delete(c);
    }

}

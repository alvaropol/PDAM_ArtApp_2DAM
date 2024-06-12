package com.salesianos.triana.ArtApi.service;

import com.salesianos.triana.ArtApi.dto.Categoria.CreateCategoryDTO;
import com.salesianos.triana.ArtApi.dto.Categoria.GetCategoriaDTO;
import com.salesianos.triana.ArtApi.model.Categoria;
import com.salesianos.triana.ArtApi.model.Publicacion;
import com.salesianos.triana.ArtApi.repository.CategoriaRepository;
import com.salesianos.triana.ArtApi.repository.PublicacionRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CategoriaService {

    private final CategoriaRepository repository;
    private final PublicacionRepository publicacionRepository;

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

        String image = categoryDTO.image();
        if (image != null && !image.isEmpty()) {
            newCategory.setImage(image);
        }

        Long maxNumero = repository.findMaxNumero();
        if (maxNumero == null) {
            maxNumero = 0L;
        }
        newCategory.setNumero(maxNumero + 1);
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


    public void deleteCategory(Categoria c) {

        for (Publicacion p : c.getPublicaciones()) {
            p.setCategoria(null);
            publicacionRepository.save(p);
        }

        repository.delete(c);
    }

    public Optional<GetCategoriaDTO> findCategoriaByNumero(Long numero) {
        return repository.findByNumero(numero).map(GetCategoriaDTO::of);
    }

}

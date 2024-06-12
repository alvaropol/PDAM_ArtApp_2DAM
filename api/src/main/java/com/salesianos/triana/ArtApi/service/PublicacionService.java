package com.salesianos.triana.ArtApi.service;

import com.salesianos.triana.ArtApi.dto.Publicacion.CreatePublicationDTO;
import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicacionDTO;
import com.salesianos.triana.ArtApi.exception.NotFoundException;
import com.salesianos.triana.ArtApi.model.Categoria;
import com.salesianos.triana.ArtApi.model.Publicacion;
import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.repository.CategoriaRepository;
import com.salesianos.triana.ArtApi.repository.PublicacionRepository;
import com.salesianos.triana.ArtApi.repository.UsuarioRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PublicacionService {

    private final PublicacionRepository repository;
    private final UsuarioRepository userRepository;
    private final CategoriaRepository categoriaRepository;

   public List<Publicacion> findAll() {
       if(repository.findAll().isEmpty())
           throw new EntityNotFoundException("There are no publications");

       return repository.findAll();
   }

   public List<Publicacion> findAllByUsuario(Usuario usuario){

       Optional<Usuario> optionalUser = userRepository.findById(usuario.getUuid());
       if(optionalUser.isPresent()){
           return repository.findAllPublicationsByUuidUser(usuario.getUuid());
       }else{
           throw new EntityNotFoundException("Usuario");
       }
   }

    public Publicacion createPublicacion(CreatePublicationDTO publicacionDTO, Usuario user) {

        Usuario usuario = userRepository.findById(user.getUuid())
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado con uuid: " + user.getUuid()));

        Categoria categoria = categoriaRepository.findByNumero(publicacionDTO.numeroCategoria()).orElse(null);

        Publicacion publicacion = new Publicacion();

        publicacion.setTitulo(publicacionDTO.titulo());
        publicacion.setDescripcion(publicacionDTO.descripcion());
        publicacion.setTamanyoDimensiones(publicacionDTO.tamanyoDimensiones());
        publicacion.setDireccionObra(publicacionDTO.direccionObra());
        publicacion.setNombreMuseo(publicacionDTO.nombreMuseo());
        publicacion.setLat(publicacionDTO.lat());
        publicacion.setLon(publicacionDTO.lon());
        publicacion.setValoracionMedia(0.0);
        publicacion.setImage(publicacionDTO.image());
        publicacion.setUsuario(usuario);
        publicacion.setCategoria(categoria);
        publicacion.setValoraciones(new HashSet<>());
        publicacion.setComentarios(new ArrayList<>());

        return repository.save(publicacion);
    }

    public Publicacion editPublication(UUID publicationUuid,CreatePublicationDTO publicacionDTO, Usuario user) {

        Usuario usuario = userRepository.findById(user.getUuid())
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado con uuid: " + user.getUuid()));

        Categoria categoria = categoriaRepository.findByNumero(publicacionDTO.numeroCategoria()).orElse(null);

        Publicacion editado = repository.findById(publicationUuid).get();

        editado.setTitulo(publicacionDTO.titulo());
        editado.setDescripcion(publicacionDTO.descripcion());
        editado.setTamanyoDimensiones(publicacionDTO.tamanyoDimensiones());
        editado.setDireccionObra(publicacionDTO.direccionObra());
        editado.setNombreMuseo(publicacionDTO.nombreMuseo());
        editado.setLat(publicacionDTO.lat());
        editado.setLon(publicacionDTO.lon());
        editado.setImage(publicacionDTO.image());
        editado.setUsuario(usuario);
        editado.setCategoria(categoria);

        return repository.save(editado);
    }

    public Publicacion editPublicationWithAdminRole(UUID publicationUuid, CreatePublicationDTO publicacionDTO) {
        Categoria categoria = categoriaRepository.findByNumero(publicacionDTO.numeroCategoria()).orElse(null);
        Publicacion editado = repository.findById(publicationUuid).get();

        editado.setTitulo(publicacionDTO.titulo());
        editado.setDescripcion(publicacionDTO.descripcion());
        editado.setTamanyoDimensiones(publicacionDTO.tamanyoDimensiones());
        editado.setDireccionObra(publicacionDTO.direccionObra());
        editado.setNombreMuseo(publicacionDTO.nombreMuseo());
        editado.setLat(publicacionDTO.lat());
        editado.setLon(publicacionDTO.lon());
        editado.setImage(publicacionDTO.image());
        editado.setCategoria(categoria);
        return repository.save(editado);
    }


    public Page<Publicacion> searchPage(Pageable pageable) {
        Page<Publicacion> pagedResult = repository.searchPage(pageable);

        if (pagedResult.isEmpty())
            throw new EntityNotFoundException("There are no publications in that page.");

        return pagedResult;
    }


    public Publicacion findByUuid(UUID uuid){
       Optional<Publicacion> publication = repository.findById(uuid);
        return publication.orElse(null);
    }

    public void deletePublication(Publicacion p){
        repository.delete(p);
    }

    public Optional<Publicacion> findByUuidOptional(UUID uuid){
        return repository.findById(uuid);
    }

    public List<GetPublicacionDTO> findByCategoriaNombre(String nombreCategoria) {
        List<Publicacion> publicaciones = repository.findByCategoriaNombre(nombreCategoria);
        return publicaciones.stream().map(GetPublicacionDTO::of).collect(Collectors.toList());
    }

}

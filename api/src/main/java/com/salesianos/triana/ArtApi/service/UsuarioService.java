package com.salesianos.triana.ArtApi.service;

import com.salesianos.triana.ArtApi.dto.Usuario.EditUserDTO;
import com.salesianos.triana.ArtApi.dto.Usuario.RegisterUser;
import com.salesianos.triana.ArtApi.exception.NotFoundException;
import com.salesianos.triana.ArtApi.model.Publicacion;
import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.repository.PublicacionRepository;
import com.salesianos.triana.ArtApi.repository.UsuarioRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UsuarioService {

    private final PasswordEncoder passwordEncoder;
    private final UsuarioRepository usuarioRepository;
    private final PublicacionRepository publicacionRepository;

    public Optional<Usuario> findByUuid(UUID id){
        return usuarioRepository.findById(id);
    }

    public Usuario getDetails(Usuario user){
        return usuarioRepository.findById(user.getUuid()).orElseThrow(() -> new NotFoundException("User"));
    }

    public List<Usuario> findAll() {return usuarioRepository.findAll();}

    public boolean userExists(String username) {
        return usuarioRepository.existsByUsernameIgnoreCase(username);
    }

    public Page<Usuario> searchPage(Pageable pageable) {
        Page<Usuario> pagedResult = usuarioRepository.searchPage(pageable);

        if (pagedResult.isEmpty())
            throw new EntityNotFoundException("There are no users in that page.");

        return pagedResult;
    }


    public Usuario createUser(RegisterUser newUser, String role) {

        Usuario user = new Usuario();
        user.setUsername(newUser.username());
        user.setPassword(passwordEncoder.encode(newUser.password()));
        user.setEmail(newUser.email());
        user.setNombre(newUser.nombre());
        user.setPais(newUser.pais());
        user.setFavoritos(Collections.emptyList());
        user.setRole(role);

        return usuarioRepository.save(user);
    }

    public Usuario save(Usuario user){
        return usuarioRepository.save(user);
    }

    public Usuario editUser(EditUserDTO usuarioDTO, Usuario user) {

        Usuario usuario = usuarioRepository.findById(user.getUuid())
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado con uuid: " + user.getUuid()));

        String nombre = usuarioDTO.nombre();
        String pais= usuarioDTO.pais();
        String email = usuarioDTO.email();

        if(nombre!= null && !nombre.isEmpty()){
            usuario.setNombre(nombre);
        }

        if(pais!= null && !pais.isEmpty()){
            usuario.setPais(pais);
        }

        if(email != null && !email .isEmpty()){
            usuario.setEmail(email );
        }

        return usuarioRepository.save(usuario);
    }

    public void addToFavorites(UUID userId, UUID publicationId) {
        Usuario user = usuarioRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        if(publicacionRepository.findById(publicationId).isEmpty()) {
            throw new EntityNotFoundException("Publication not found");
        }
        Publicacion publication = publicacionRepository.findById(publicationId).get();

        List<Publicacion> favorites = user.getFavoritos();

        favorites.add(publication);

        user.setFavoritos(favorites);

        usuarioRepository.save(user);
    }

    public void removeFromFavorites(UUID userId, UUID publicationId) {
        Usuario user = usuarioRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        List<Publicacion> favorites = user.getFavoritos();

        favorites.removeIf(publicacion -> publicacion.getUuid().equals(publicationId));
        user.setFavoritos(favorites);

        usuarioRepository.save(user);
    }

    public boolean isThatPublicationInFavorites(UUID userId, UUID publicationId) {
        Optional<Usuario> optionalUser = usuarioRepository.findById(userId);
        if (optionalUser.isPresent()) {
            Usuario user = optionalUser.get();
            List<Publicacion> favorites = user.getFavoritos();
            for (Publicacion publication : favorites) {
                if (publication.getUuid().equals(publicationId)) {
                    return true;
                }
            }
        }
        return false;
    }

    @Transactional
    public Optional<Usuario> findByUuidWithPublicaciones(UUID uuid) {
        return usuarioRepository.findByUuidWithPublicaciones(uuid);
    }

    public Optional<Usuario> findByUsername(String username) {
        return usuarioRepository.findFirstByUsername(username);
    }

    public List<Usuario> findByUsernameContainingIgnoreCase(String username) {
        return usuarioRepository.findByUsernameIgnoreCaseContaining(username);
    }

}
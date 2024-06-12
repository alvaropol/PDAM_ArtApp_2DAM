package com.salesianos.triana.ArtApi.service;

import com.salesianos.triana.ArtApi.dto.Comentario.CreateComentarioDTO;
import com.salesianos.triana.ArtApi.dto.Comentario.GetComentarioDTO;
import com.salesianos.triana.ArtApi.model.Comentario;
import com.salesianos.triana.ArtApi.model.Publicacion;
import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.repository.ComentarioRepository;
import com.salesianos.triana.ArtApi.repository.UsuarioRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;


@Service
@RequiredArgsConstructor
public class ComentarioService {

    private final ComentarioRepository repository;
    private final UsuarioRepository usuarioRepository;


    public Comentario createComment(CreateComentarioDTO dto, Publicacion publicacion, Usuario usuario){
        Usuario user = usuarioRepository.findById(usuario.getUuid())
                .orElseThrow(() -> new EntityNotFoundException("Usuario no encontrado con uuid: " + usuario.getUuid()));

        Comentario comment = new Comentario();

        comment.setComment(dto.comment());
        comment.setPublicacion(publicacion);
        comment.setUsuario(user);

        return repository.save(comment);
    }

    public Page<Comentario> searchPage(Pageable pageable) {
        Page<Comentario> pagedResult = repository.searchPage(pageable);

        if (pagedResult.isEmpty())
            throw new EntityNotFoundException("There are no comments in that page.");

        return pagedResult;
    }

    public Optional<Comentario> findByUuidOptional(UUID uuid){
        return repository.findById(uuid);
    }

    public void deleteComment(Comentario c){
        repository.delete(c);
    }

    public List<GetComentarioDTO> findByUsernameContainingIgnoreCase(String username) {
        return repository.findByUsernameIgnoreCaseContaining(username)
                .stream()
                .map(GetComentarioDTO::of)
                .collect(Collectors.toList());
    }
}

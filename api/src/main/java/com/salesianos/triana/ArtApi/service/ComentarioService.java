package com.salesianos.triana.ArtApi.service;

import com.salesianos.triana.ArtApi.dto.Comentario.CreateComentarioDTO;
import com.salesianos.triana.ArtApi.model.Comentario;
import com.salesianos.triana.ArtApi.model.Publicacion;
import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.repository.ComentarioRepository;
import com.salesianos.triana.ArtApi.repository.UsuarioRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


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
}

package com.salesianos.triana.ArtApi.service;

import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicationDTOForCategory;
import com.salesianos.triana.ArtApi.dto.Valoracion.GetValoracionDTO;
import com.salesianos.triana.ArtApi.model.Publicacion;
import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.model.Valoracion;
import com.salesianos.triana.ArtApi.model.ValoracionPK;
import com.salesianos.triana.ArtApi.repository.PublicacionRepository;
import com.salesianos.triana.ArtApi.repository.ValoracionRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ValoracionService {

    private final ValoracionRepository valoracionRepository;
    private final PublicacionRepository publicacionRepository;
    private final UsuarioService usuarioService;

    public Valoracion saveOrUpdate(Valoracion valoracion) {
        return valoracionRepository.save(valoracion);
    }

    public Optional<Valoracion> findById(ValoracionPK valoracionId){
        return valoracionRepository.findById(valoracionId);
    }

    public Page<Valoracion> searchPage(Pageable pageable) {
        Page<Valoracion> pagedResult = valoracionRepository.searchPage(pageable);

        if (pagedResult.isEmpty())
            throw new EntityNotFoundException("There are no ratings in that page.");

        return pagedResult;
    }


    @Transactional
    public Valoracion createOrUpdateValoracion(UUID userUuid, Publicacion publicacion, int puntuacion) {

        Usuario usuario = usuarioService.findByUuid(userUuid).get();

        Optional<Valoracion> existingValoracion = valoracionRepository.findByUsuarioAndPublicacion(usuario, publicacion);

        if (existingValoracion.isPresent()) {
            Valoracion valoracion = existingValoracion.get();
            valoracion.setPuntuacion(puntuacion);
            return saveOrUpdateAndRecalculateMedia(valoracion);
        } else {
            Valoracion nuevaValoracion = new Valoracion();
            nuevaValoracion.setUsuario(usuario);
            nuevaValoracion.setPublicacion(publicacion);
            nuevaValoracion.setPuntuacion(puntuacion);

            return saveOrUpdateAndRecalculateMedia(nuevaValoracion);
        }
    }

    private Valoracion saveOrUpdateAndRecalculateMedia(Valoracion valoracion) {
        Valoracion savedValoracion = saveOrUpdate(valoracion);
        Publicacion publicacion = savedValoracion.getPublicacion();

        publicacion.getValoraciones().add(valoracion);

        Set<Valoracion> valoraciones = publicacion.getValoraciones();
        double media = valoraciones.stream().mapToInt(Valoracion::getPuntuacion).average().orElse(0.0);

        publicacion.setValoracionMedia(media);
        publicacionRepository.save(publicacion);

        return savedValoracion;
    }

    public void deleteValoracion(Valoracion valoracion) {
        Publicacion publicacion = valoracion.getPublicacion();

        valoracionRepository.delete(valoracion);

        publicacion.getValoraciones().remove(valoracion);

        recalculateMedia(publicacion);

        publicacionRepository.save(publicacion);

    }

    private void recalculateMedia(Publicacion publicacion) {
        Set<Valoracion> valoraciones = publicacion.getValoraciones();
        double media = valoraciones.stream().mapToInt(Valoracion::getPuntuacion).average().orElse(0.0);
        publicacion.setValoracionMedia(media);
    }

    public Optional<Valoracion> findByUsuarioAndPublicacion(UUID usuarioUuid, Publicacion publicacion){
        Optional<Usuario> userOptional= usuarioService.findByUuid(usuarioUuid);
        if(userOptional.isPresent()){
            Usuario user = userOptional.get();
            return valoracionRepository.findByUsuarioAndPublicacion(user,publicacion);
        }

        return Optional.empty();
    }

    public List<GetPublicationDTOForCategory> findPublicacionesValoradasPorUsuario(UUID usuarioUuid) {

        return valoracionRepository.findPublicacionesValoradasPorUsuario(usuarioService.findByUuid(usuarioUuid).get())
                .stream()
                .map(GetPublicationDTOForCategory::of)
                .toList();
    }

    public List<GetValoracionDTO> findByRating(int rating) {
        return valoracionRepository.findByPuntuacion(rating)
                .stream()
                .map(GetValoracionDTO::of)
                .collect(Collectors.toList());
    }

}
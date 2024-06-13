package com.salesianos.triana.ArtApi.security.jwt.refresh;

import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.repository.UsuarioRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class RefreshTokenService {

    private final RefreshTokenRepository refreshTokenRepository;
    private final UsuarioRepository userRepository;

    @Value("${jwt.refresh.duration}")
    private int durationInMinutes;

    public Optional<RefreshToken> findByToken(String token){
        return refreshTokenRepository.findByToken(token);
    }

    @Transactional
    public int deleteByUser(Usuario user){
        return refreshTokenRepository.deleteByUsuario(user);
    }

    @Transactional
    public RefreshToken createRefreshToken(UUID userId) {
        Optional<Usuario> userOptional = userRepository.findById(userId);
        if (userOptional.isPresent()) {
            Usuario user = userOptional.get();
            RefreshToken refreshToken = new RefreshToken();
            refreshToken.setUsuario(user);
            refreshToken.setToken(UUID.randomUUID().toString());
            refreshToken.setExpiryDate(Instant.now().plusSeconds(durationInMinutes * 60));
            return refreshTokenRepository.save(refreshToken);
        } else {
            throw new EntityNotFoundException("User not found with ID: " + userId);
        }
    }

    public RefreshToken verify(RefreshToken refreshToken){
        if (refreshToken.getExpiryDate().compareTo(Instant.now()) < 0){
            refreshTokenRepository.delete(refreshToken);
            throw new RefreshTokenException("Expired refresh token:"+ refreshToken.getToken() + "Please, login again");
        }
        return refreshToken;
    }

}
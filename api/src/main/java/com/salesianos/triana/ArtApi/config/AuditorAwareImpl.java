package com.salesianos.triana.ArtApi.config;

import com.salesianos.triana.ArtApi.model.Usuario;
import org.springframework.data.domain.AuditorAware;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Optional;


public class AuditorAwareImpl implements AuditorAware<String> {
    @Override
    public Optional<String> getCurrentAuditor() {
        Authentication authentication =
                SecurityContextHolder.getContext().getAuthentication();

        return Optional.ofNullable(authentication)
                .map(auth -> (Usuario) auth.getPrincipal())
                .map(Usuario::getUuid)
                .map(java.util.UUID::toString);
    }
}
package com.salesianos.triana.ArtApi.security.jwt.refresh;

import com.salesianos.triana.ArtApi.security.errorhandling.JwtTokenException;

public class RefreshTokenException extends JwtTokenException {
    public RefreshTokenException(String msg) {
        super((msg));
    }
}

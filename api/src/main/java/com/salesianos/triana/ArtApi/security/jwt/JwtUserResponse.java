package com.salesianos.triana.ArtApi.security.jwt;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.salesianos.triana.ArtApi.dto.Usuario.UserResponse;
import com.salesianos.triana.ArtApi.model.Usuario;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class JwtUserResponse extends UserResponse {

    private String token;
    private String refreshToken;

    public JwtUserResponse(UserResponse userResponse) {
        id = userResponse.getId();
        username = userResponse.getUsername();
        nombre = userResponse.getNombre();
        email = userResponse.getEmail();
        pais = userResponse.getPais();
        createdAt = userResponse.getCreatedAt();
        role = userResponse.getRole();
    }

    public static JwtUserResponse of (Usuario user, String token) {
        JwtUserResponse result = new JwtUserResponse(UserResponse.of(user));
        result.setToken(token);
        return result;

    }

    public static JwtUserResponse ofLogin (Usuario user, String token, String refreshToken) {
        JwtUserResponse result = new JwtUserResponse(UserResponse.ofLogin(user));
        result.setToken(token);
        result.setRefreshToken(refreshToken);
        return result;

    }

}
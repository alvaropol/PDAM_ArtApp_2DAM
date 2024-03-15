package com.salesianos.triana.ArtApi.dto.Usuario;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.salesianos.triana.ArtApi.model.Usuario;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.springframework.security.core.GrantedAuthority;

import java.time.LocalDateTime;
import java.util.Collection;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class UserResponse {

    protected String id;
    protected String username, email, nombre,pais, role;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy HH:mm:ss")
    protected LocalDateTime createdAt;

    public static String getRole(Collection<? extends GrantedAuthority> roleList){
        return roleList.stream().map(GrantedAuthority::getAuthority).toList().get(0);
    }
    public static UserResponse of(Usuario user){

        return UserResponse.builder()
                .id(user.getUuid().toString())
                .username(user.getUsername())
                .email(user.getEmail())
                .nombre(user.getNombre())
                .pais(user.getPais())
                .createdAt(user.getCreatedAt())
                .role(getRole(user.getAuthorities()))
                .build();
    }

    public static UserResponse ofLogin(Usuario user){

        return UserResponse.builder()
                .id(user.getUuid().toString())
                .username(user.getUsername())
                .nombre(user.getNombre())
                .pais(user.getPais())
                .role(getRole(user.getAuthorities()))
                .build();
    }

}
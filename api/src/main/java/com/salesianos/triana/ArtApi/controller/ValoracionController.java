package com.salesianos.triana.ArtApi.controller;

import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicationDTOForCategory;
import com.salesianos.triana.ArtApi.dto.Valoracion.GetValoracionDTO;
import com.salesianos.triana.ArtApi.model.Publicacion;
import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.model.Valoracion;
import com.salesianos.triana.ArtApi.model.ValoracionPK;
import com.salesianos.triana.ArtApi.service.PublicacionService;
import com.salesianos.triana.ArtApi.service.ValoracionService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@Tag(name = "Valoracion", description = "El controlador de valoracion tiene diferentes métodos para obtener información variada" +
        "sobre las valoraciones de los usuarios en las publicaciones")
public class ValoracionController {

    private final ValoracionService valoracionService;
    private final PublicacionService publicacionService;


    @Operation(summary = "Obtains a rating of a publication of the user")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The rating has been found.", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Valoracion.class)), examples = {
                            @ExampleObject(value = """
                                    [
                                        {
                                            "publication": {
                                                                uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                                "titulo": "Las Meninas",
                                                                 "image": "https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg",
                                                                  "cantidadValoraciones": 2,
                                                                   "valoracionMedia": 3.0
                                                            },
                                             "user": {
                                                                 "uuid": "c62db400-22e3-4e92-94db-1447f5688f2c",
                                                                 "nombre": "admin",
                                                                  username": "admin"
                                                     },
                                                     
                                             "rating": 1
                                              
                                        }
                                          
                                    ]
                                    """)})}),
            @ApiResponse(responseCode = "404", description = "Not found any rating", content = @Content),
    })
    @GetMapping("/user/rating/{uuidPublicacion}")
    public ResponseEntity<GetValoracionDTO> getValoracionByUserAndPublication(@AuthenticationPrincipal Usuario usuario,
                                                                     @PathVariable UUID uuidPublicacion) {

        Optional<Publicacion> publicacionOptional = publicacionService.findByUuidOptional(uuidPublicacion);
        if (publicacionOptional.isPresent()) {
            Publicacion publicacion = publicacionOptional.get();
            Optional<Valoracion> valoracion = valoracionService.findByUsuarioAndPublicacion(usuario.getUuid(),publicacion);
            return valoracion.map(value -> ResponseEntity.ok((GetValoracionDTO.of(value)))).orElseGet(() -> ResponseEntity.notFound().build());
        }else{
            return  ResponseEntity.notFound().build();
        }
    }

    @Operation(summary = "Obtains a  list of rating of a publication of the user")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The rating list have been found.", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Valoracion.class)), examples = {
                            @ExampleObject(value = """
                                    [
                                        {
                                            "publication": {
                                                                uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                                "titulo": "Las Meninas",
                                                                 "image": "https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg",
                                                                  "cantidadValoraciones": 2,
                                                                   "valoracionMedia": 3.0
                                                            },
                                             "user": {
                                                                 "uuid": "c62db400-22e3-4e92-94db-1447f5688f2c",
                                                                 "nombre": "admin",
                                                                  username": "admin"
                                                     },
                                                     
                                             "rating": 1
                                              
                                        },
                                        
                                        {
                                            "publication": {
                                                                uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                                "titulo": "Las Meninas",
                                                                 "image": "https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg",
                                                                  "cantidadValoraciones": 2,
                                                                   "valoracionMedia": 3.0
                                                            },
                                             "user": {
                                                                 "uuid": "c62db400-22e3-4e92-94db-1447f5688f2c",
                                                                 "nombre": "admin",
                                                                  username": "admin"
                                                     },
                                                     
                                             "rating": 1
                                              
                                        }
                                          
                                    ]
                                    """)})}),
            @ApiResponse(responseCode = "404", description = "Not found any rating", content = @Content),
    })
    @GetMapping("/user/rating")
    public ResponseEntity<List<GetPublicationDTOForCategory>> getAllValoracionByUser(@AuthenticationPrincipal Usuario usuario) {

        List<GetPublicationDTOForCategory> publicacionesValoradas = valoracionService.findPublicacionesValoradasPorUsuario(usuario.getUuid());

        if(publicacionesValoradas.isEmpty()){
            return ResponseEntity.ok(Collections.emptyList());
        }else{
            return ResponseEntity.ok(publicacionesValoradas);
        }

    }

    @Operation(summary = "Method to rate a publication")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "The rating added to publication successfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Valoracion.class)))}),
            @ApiResponse(responseCode = "404", description = "Not found any publication with that UUID", content = @Content),
            @ApiResponse(responseCode = "400", description = "The rating value must be between 0 and 5 without decimals", content = @Content)
    })
    @PostMapping("/rate/add/publication/{uuidPublicacion}/{puntuacion}")
    public ResponseEntity<?> createOrUpdateValoracion(@AuthenticationPrincipal Usuario usuario,
                                                      @PathVariable UUID uuidPublicacion,
                                                      @PathVariable int puntuacion) {

        Optional<Publicacion> publicacionOptional = publicacionService.findByUuidOptional(uuidPublicacion);
        if (publicacionOptional.isPresent()) {
            Publicacion publicacion = publicacionOptional.get();
            if (puntuacion < 0 || puntuacion > 5) {
                return ResponseEntity.badRequest().build();
            }

            Valoracion valoracion = valoracionService.createOrUpdateValoracion(usuario.getUuid(), publicacion, puntuacion);
            return ResponseEntity.status(HttpStatus.CREATED).build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }


    @Operation(summary = "Method to delete a rating from a publication")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "The rating deleted from publication successfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Valoracion.class)))}),
            @ApiResponse(responseCode = "404", description = "Not found any publication with that UUID", content = @Content)
    })
    @DeleteMapping("/rate/remove/publication/{uuidPublicacion}")
    public ResponseEntity<?> deleteValoracion(@AuthenticationPrincipal Usuario usuario,
                                                 @PathVariable UUID uuidPublicacion) {
        Publicacion publicacion = publicacionService.findByUuid(uuidPublicacion);

        Optional<Valoracion> valoracionOptional = valoracionService.findById(new ValoracionPK(usuario,publicacion));
        if (valoracionOptional.isPresent()) {
            Valoracion valoracion = valoracionOptional.get();
            valoracionService.deleteValoracion(valoracion);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}

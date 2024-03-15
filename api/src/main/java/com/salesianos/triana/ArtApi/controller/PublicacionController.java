package com.salesianos.triana.ArtApi.controller;

import com.salesianos.triana.ArtApi.dto.Publicacion.CreatePublicationDTO;
import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicacionDTO;
import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicationDTOForCategory;
import com.salesianos.triana.ArtApi.model.Publicacion;
import com.salesianos.triana.ArtApi.model.Usuario;
import com.salesianos.triana.ArtApi.service.PublicacionService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.apache.coyote.Response;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@Tag(name = "Publicacion", description = "El controlador de publicación tiene diferentes métodos para obtener información variada" +
        "sobre las publicaciones")
public class PublicacionController {

    private final PublicacionService service;

    @Operation(summary = "Obtains a list of publications with pageable")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "All publications have been found.", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Publicacion.class)), examples = {
                            @ExampleObject(value = """
                                    [
                                         {
                                             "nombre": "Las Meninas",
                                             "descripcion": "Una de las obras maestras de Diego Velázquez",
                                             "tamanyoDimensiones": "3x2 metros",
                                             "direccionObra": "Calle de Ruiz de Alarcón, 23, 28014 Madrid",
                                             "nombreMuseo": "Museo Del Prado",
                                             "lat": "40.413924",
                                             "lon": "-3.692187",
                                             "valoracionMedia": 4.5,
                                             "image": "https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg",
                                             "categoria": "Sin categoria"
                                         },
                                         {
                                             "nombre": "Guernica",
                                             "descripcion": "Obra de Pablo Picasso que representa el bombardeo de Guernica",
                                             "tamanyoDimensiones": "3.5x7.8 metros",
                                             "direccionObra": "Calle de Santa Isabel, 52, 28012 Madrid",
                                             "nombreMuseo": "Museo Nacional Centro de Arte Reina Sofía",
                                             "lat": "40.408886",
                                             "lon": "-3.694365",
                                             "valoracionMedia": 3.8,
                                             "image": "https://static5.museoreinasofia.es/sites/default/files/obras/DE00050.jpg",
                                             "categoria": "Sin categoria"
                                         },
                                         {
                                             "nombre": "La Persistencia de la Memoria",
                                             "descripcion": "Conocido como \\"Los relojes blandos\\" de Salvador Dalí",
                                             "tamanyoDimensiones": "24x33 cm",
                                             "direccionObra": "Abandoibarra Etorb., 2, 48009 Bilbao, Bizkaia",
                                             "nombreMuseo": "Museo Guggenheim Bilbao",
                                             "lat": "43.268409",
                                             "lon": "-2.934054",
                                             "valoracionMedia": 5.0,
                                             "image": "https://media.gq.com.mx/photos/5eb98f9a51cd5e1b340e8d48/master/pass/la-persistencia-de-la-memoria-de-salvador-dali-significado-foto.jpg",
                                             "categoria": "Sin categoria"
                                         }
                                     ]
                                     """)})}),
            @ApiResponse(responseCode = "404", description = "Not found any publication", content = @Content),
    })
    @GetMapping("/publications/paged")
    public ResponseEntity<Page<GetPublicacionDTO>> findAllPageable(@PageableDefault(page = 0, size = 20) Pageable page) {
        Page<Publicacion> pagedResult = service.searchPage(page);
        if (pagedResult.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(pagedResult.map(GetPublicacionDTO::of));
    }

    @Operation(summary = "Obtains a list of publications without pageable")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "All publications have been found.", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Publicacion.class)), examples = {
                            @ExampleObject(value = """
                                    [
                                        {"uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                         "titulo": "Las Meninas",
                                         "descripcion": "Una de las obras maestras de Diego VelÃ¡zquez",
                                         "tamanyoDimensiones": "3x2 metros",
                                         "direccionObra": "Calle de Ruiz de AlarcÃ³n, 23, 28014 Madrid",
                                         "nombreMuseo": "Museo Del Prado",
                                         "lat": "40.413924",
                                         "lon": "-3.692187",
                                         "valoracionMedia": 4.5,
                                          "image": "https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg",
                                          "categoria": "Sin categoria"},


                                        {"uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                         "titulo": "Las Meninas",
                                         "descripcion": "Una de las obras maestras de Diego VelÃ¡zquez",
                                         "tamanyoDimensiones": "3x2 metros",
                                         "direccionObra": "Calle de Ruiz de AlarcÃ³n, 23, 28014 Madrid",
                                         "nombreMuseo": "Museo Del Prado",
                                         "lat": "40.413924",
                                         "lon": "-3.692187",
                                         "valoracionMedia": 4.5,
                                          "image": "https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg",
                                          "categoria": "Sin categoria"}
                                          
                                    ]
                                    """)})}),
            @ApiResponse(responseCode = "404", description = "Not found any publication", content = @Content),
    })
    @GetMapping("/publications")
    public ResponseEntity<List<GetPublicacionDTO>> findAll() {
        List<GetPublicacionDTO> result = service.findAll().stream().map(GetPublicacionDTO::of).toList();

        if (result.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(result);
    }


    @Operation(summary = "Gets a publication from its id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The publication has been found", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Publicacion.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                                                                                            
                                         "uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                         "titulo": "Las Meninas",
                                         "descripcion": "Una de las obras maestras de Diego VelÃ¡zquez",
                                         "tamanyoDimensiones": "3x2 metros",
                                         "direccionObra": "Calle de Ruiz de AlarcÃ³n, 23, 28014 Madrid",
                                         "nombreMuseo": "Museo Del Prado",
                                         "lat": "40.413924",
                                         "lon": "-3.692187",
                                         "valoracionMedia": 4.5,
                                          "image": "https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg",
                                          "categoria": "Sin categoria"
                                      
                                    }
                                                                    """)})}),
            @ApiResponse(responseCode = "404", description = "Not found any publication with that uuid", content = @Content),
    })
    @GetMapping("/publication/{uuid}")
    public ResponseEntity<GetPublicacionDTO> findByUuid(@PathVariable UUID uuid) {
        Publicacion publication = service.findByUuid(uuid);
        if (publication == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(GetPublicacionDTO.of(publication));

    }



    @Operation(summary = "Gets the list of all publication that the user posted")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The publication list has been found (empty or not)", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Publicacion.class)), examples = {
                            @ExampleObject(value = """
                                    [
                                         {
                                             "uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                 "titulo": "Las Meninas",
                                                 "image": "https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg",
                                                 "cantidadValoraciones": 2,
                                                 "valoracionMedia": 3.0
                                         },
                                         {
                                             "uuid": "fdb4326b-0b5e-4f1d-8b47-5eb7e60d1d4a",
                                                 "titulo": "La Ultima Cena",
                                                 "image": "https://i0.wp.com/plumasatomicas.com/wp-content/uploads/2020/04/Ultima-Cena-Jueves-Santo-Cuadro-Da-Vinci.jpg?fit=1200%2C800&ssl=1",
                                                 "cantidadValoraciones": 1,
                                                 "valoracionMedia": 5.0
                                         },
                                         {
                                             "uuid": "96396a87-74bc-4c7f-b233-8e52b997af34",
                                                 "titulo": "La Joven de la Perla",
                                                 "image": "https://media.traveler.es/photos/613766f4d7c7024f9175e397/master/w_1600%2Cc_limit/164783.jpg",
                                                 "cantidadValoraciones": 2,
                                                 "valoracionMedia": 4.5
                                         },
                                         {
                                             "uuid": "e2ed078d-4d91-4f53-b86f-71b923d6f0b2",
                                                 "titulo": "La Gioconda",
                                                 "image": "https://images.theconversation.com/files/430032/original/file-20211103-23-1lapvgt.jpeg?ixlib=rb-1.1.0&rect=19%2C1378%2C6412%2C3201&q=45&auto=format&w=1356&h=668&fit=crop",
                                                 "cantidadValoraciones": 2,
                                                 "valoracionMedia": 4.0
                                         },
                                         {
                                             "uuid": "e127f15a-d642-4b84-8a63-d96290f83e4c",
                                                 "titulo": "La Fuente",
                                                 "image": "https://historia-arte.com/_/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpbSI6WyJcL2FydHdvcmtcL2ltYWdlRmlsZVwvbGEtZnVlbnRlLWR1Y2hhbXAuanBnIiwicmVzaXplLDIwMDAsMjAwMCJdfQ.tGSvnG4V-wz2AgEv1tW68xXVyQ38aYHMIDPRrgo-VaU.jpg",
                                                 "cantidadValoraciones": 1,
                                                 "valoracionMedia": 5.0
                                         }
                                     ]
                                                                    """)})})
    })
    @GetMapping("/publication/user")
    public ResponseEntity<List<GetPublicacionDTO>> findAllByUser(@AuthenticationPrincipal Usuario usuario){
        List<GetPublicacionDTO> result = service.findAllByUsuario(usuario).stream().map(GetPublicacionDTO::of).toList();
        return ResponseEntity.ok(result);
    }

    @Operation(summary = "Create a publication")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "The publication has been created succesfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Publicacion.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                                                                                            
                                         "uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                         "titulo": "Las Meninas",
                                         "descripcion": "Una de las obras maestras de Diego VelÃ¡zquez",
                                         "tamanyoDimensiones": "3x2 metros",
                                         "direccionObra": "Calle de Ruiz de AlarcÃ³n, 23, 28014 Madrid",
                                         "nombreMuseo": "Museo Del Prado",
                                         "lat": "40.413924",
                                         "lon": "-3.692187",
                                         "valoracionMedia": 4.5,
                                          "image": "https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg",
                                          "categoria": "Sin categoria"
                                      
                                    }
                                                                    """)})})
    })
    @PostMapping("/publication/create")
    public ResponseEntity<GetPublicacionDTO> createPublicacion(
            @Valid @RequestBody CreatePublicationDTO publicacionDTO,
            @AuthenticationPrincipal Usuario user) {
        Publicacion publicacion = service.createPublicacion(publicacionDTO, user);
        return new ResponseEntity<>(GetPublicacionDTO.of(publicacion), HttpStatus.CREATED);
    }


    @Operation(summary = "Edit a publication")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The publication has been edited succesfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Publicacion.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                                                                                            
                                         "uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                         "titulo": "Las Meninas editado",
                                         "descripcion": "Una de las obras maestras de Diego VelÃ¡zquez editado",
                                         "tamanyoDimensiones": "3x2 metros editado",
                                         "direccionObra": "Calle de Ruiz de AlarcÃ³n, 23, 28014 Madrid editado",
                                         "nombreMuseo": "Museo Del Prado editado",
                                         "lat": "40.413924",
                                         "lon": "-3.692187",
                                         "valoracionMedia": 4.5,
                                          "image": "https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg",
                                          "categoria": "Arte clasico"
                                      
                                    }
                                                                    """)})}),
            @ApiResponse(responseCode = "404", description = "Not found any publication with that uuid", content = @Content),
    })
    @PutMapping("/publication/edit/{publicacionUuid}")
    public ResponseEntity<GetPublicacionDTO> editPublication(@PathVariable UUID publicacionUuid,
            @Valid @RequestBody CreatePublicationDTO publicacionDTO,
            @AuthenticationPrincipal Usuario user) {
        Optional<Publicacion> optional = service.findByUuidOptional(publicacionUuid);

        if(optional.isEmpty()){
            return ResponseEntity.notFound().build();
        }else{
            Publicacion publicacion = service.editPublication(publicacionUuid,publicacionDTO, user);
            return new ResponseEntity<>(GetPublicacionDTO.of(publicacion), HttpStatus.OK);
        }
    }

    @Operation(summary = "Method to remove an publication")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "The publication favorite removed successfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Publicacion.class)))}),
            @ApiResponse(responseCode = "404", description = "Not found any publication with that UUID", content = @Content)
    })
    @DeleteMapping("/publication/remove/{publicacionUuid}")
    public ResponseEntity<?> removePublication(@PathVariable UUID publicacionUuid, @AuthenticationPrincipal Usuario user){
        Optional<Publicacion> publication = service.findByUuidOptional(publicacionUuid);
        if(publication.isEmpty()){
            return ResponseEntity.notFound().build();
        }else{
            service.deletePublication(publication.get());
            return  ResponseEntity.noContent().build();
        }
    }


}

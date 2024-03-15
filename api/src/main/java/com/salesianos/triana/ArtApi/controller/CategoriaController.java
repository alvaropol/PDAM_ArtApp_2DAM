package com.salesianos.triana.ArtApi.controller;

import com.salesianos.triana.ArtApi.dto.Categoria.GetCategoriaDTO;
import com.salesianos.triana.ArtApi.dto.Categoria.GetCategoriaForCreatePublication;
import com.salesianos.triana.ArtApi.dto.Publicacion.GetPublicacionDTO;
import com.salesianos.triana.ArtApi.model.Categoria;
import com.salesianos.triana.ArtApi.model.Publicacion;
import com.salesianos.triana.ArtApi.service.CategoriaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@Tag(name = "Categoria", description = "El controlador de categoria tiene diferentes métodos para obtener información variada" +
        "sobre las categorias diferentes que existen en la aplicación")
public class CategoriaController {

    private final CategoriaService service;

    @Operation(summary = "Obtains a list of categories with pageable")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "All categories have been found.", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Categoria.class)), examples = {
                            @ExampleObject(value = """
                                    [
                                         {
                                               "uuid": "50a6fcbd-1ef5-40ee-857d-183b15930e90",
                                                "numero": 1,
                                                "nombre": "Arte Clasico",
                                                "image": "imagen1",
                                                 "publicaciones": [
                                                     {
                                                       "uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                        "titulo": "Las Meninas",
                                                        "valoracionMedia": 4.5
                                                     },
                                                     {
                                                             "uuid": "fdb4326b-0b5e-4f1d-8b47-5eb7e60d1d4a",
                                                             "titulo": "La Ãšltima Cena",
                                                             "valoracionMedia": 4.7
                                                     }
                                                 ]
                                         },
                                         {
                                               "uuid": "50a6fcbd-1ef5-40ee-857d-183b15930e90",
                                                "numero": 1,
                                                "nombre": "Arte Clasico",
                                                "image": "imagen1",
                                                 "publicaciones": [
                                                     {
                                                       "uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                        "titulo": "Las Meninas",
                                                        "valoracionMedia": 4.5
                                                     },
                                                     {
                                                             "uuid": "fdb4326b-0b5e-4f1d-8b47-5eb7e60d1d4a",
                                                             "titulo": "La Ãšltima Cena",
                                                             "valoracionMedia": 4.7
                                                     }
                                                 ]
                                         },
                                         {
                                               "uuid": "50a6fcbd-1ef5-40ee-857d-183b15930e90",
                                                "numero": 1,
                                                "nombre": "Arte Clasico",
                                                "image": "imagen1",
                                                 "publicaciones": [
                                                     {
                                                       "uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                        "titulo": "Las Meninas",
                                                        "valoracionMedia": 4.5
                                                     },
                                                     {
                                                             "uuid": "fdb4326b-0b5e-4f1d-8b47-5eb7e60d1d4a",
                                                             "titulo": "La Ãšltima Cena",
                                                             "valoracionMedia": 4.7
                                                     }
                                                 ]
                                         }
                                              
                                     ]
                                     """)})}),
            @ApiResponse(responseCode = "404", description = "Not found any category", content = @Content),
    })
    @GetMapping("/categories/paged")
    public ResponseEntity<Page<GetCategoriaDTO>> findAllPageable(@PageableDefault(page = 0, size = 20) Pageable page) {
        Page<Categoria> pagedResult = service.searchPage(page);
        if (pagedResult.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(pagedResult.map(GetCategoriaDTO::of));
    }


    @Operation(summary = "Obtains a list of categories")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "All categories have been found.", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Categoria.class)), examples = {
                            @ExampleObject(value = """
                                    [
                                         {
                                               "uuid": "50a6fcbd-1ef5-40ee-857d-183b15930e90",
                                                "numero": 1,
                                                "nombre": "Arte Clasico",
                                                "image": "imagen1",
                                                 "publicaciones": [
                                                     {
                                                       "uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                        "titulo": "Las Meninas",
                                                        "valoracionMedia": 4.5
                                                     },
                                                     {
                                                             "uuid": "fdb4326b-0b5e-4f1d-8b47-5eb7e60d1d4a",
                                                             "titulo": "La Ãšltima Cena",
                                                             "valoracionMedia": 4.7
                                                     }
                                                 ]
                                         },
                                         {
                                               "uuid": "50a6fcbd-1ef5-40ee-857d-183b15930e90",
                                                "numero": 1,
                                                "nombre": "Arte Clasico",
                                                "image": "imagen1",
                                                 "publicaciones": [
                                                     {
                                                       "uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                        "titulo": "Las Meninas",
                                                        "valoracionMedia": 4.5
                                                     },
                                                     {
                                                             "uuid": "fdb4326b-0b5e-4f1d-8b47-5eb7e60d1d4a",
                                                             "titulo": "La Ãšltima Cena",
                                                             "valoracionMedia": 4.7
                                                     }
                                                 ]
                                         },
                                         {
                                               "uuid": "50a6fcbd-1ef5-40ee-857d-183b15930e90",
                                                "numero": 1,
                                                "nombre": "Arte Clasico",
                                                "image": "imagen1",
                                                 "publicaciones": [
                                                     {
                                                       "uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                        "titulo": "Las Meninas",
                                                        "valoracionMedia": 4.5
                                                     },
                                                     {
                                                             "uuid": "fdb4326b-0b5e-4f1d-8b47-5eb7e60d1d4a",
                                                             "titulo": "La Ãšltima Cena",
                                                             "valoracionMedia": 4.7
                                                     }
                                                 ]
                                         }
                                              
                                     ]
                                     """)})}),
            @ApiResponse(responseCode = "404", description = "Not found any category", content = @Content),
    })
    @GetMapping("/categories")
    public ResponseEntity<List<GetCategoriaDTO>> findAll(@PageableDefault(page = 0, size = 20) Pageable page) {
        List<GetCategoriaDTO> result = service.findAll().stream().map(GetCategoriaDTO::of).toList();
        if (result.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(result);
    }

    @Operation(summary = "Obtains a list of categories with the name and the number")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "All categories have been found.", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Categoria.class)), examples = {
                            @ExampleObject(value = """
                                     [
                                         {
                                             "nombre": "Arte Clasico",
                                                 "numero": 1
                                         },
                                         {
                                             "nombre": "Arte Contemporaneo",
                                                 "numero": 2
                                         },
                                         {
                                             "nombre": "Arte Moderno",
                                                 "numero": 3
                                         },
                                         {
                                             "nombre": "Arte Renacentista",
                                                 "numero": 4
                                         },
                                         {
                                             "nombre": "Arte Barroco",
                                                 "numero": 5
                                         },
                                         {
                                             "nombre": "Arte Romantico",
                                                 "numero": 6
                                         },
                                         {
                                             "nombre": "Arte Impresionista",
                                                 "numero": 7
                                         },
                                         {
                                             "nombre": "Arte Cubista",
                                                 "numero": 8
                                         },
                                         {
                                             "nombre": "Arte Abstracto",
                                                 "numero": 9
                                         },
                                         {
                                             "nombre": "Arte Surrealista",
                                                 "numero": 10
                                         }
                                     ]
                                     """)})}),
            @ApiResponse(responseCode = "404", description = "Not found any category", content = @Content),
    })
    @GetMapping("/categories/createform")
    public ResponseEntity<List<GetCategoriaForCreatePublication>> findAll() {
        List<GetCategoriaForCreatePublication> result = service.findAll().stream().map(GetCategoriaForCreatePublication::of).toList();
        if (result.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(result);
    }

    @Operation(summary = "Gets a category from its id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The category has been found", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Categoria.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                           "uuid": "50a6fcbd-1ef5-40ee-857d-183b15930e90",
                                           "numero": 1,
                                           "nombre": "Arte Clasico",
                                           "image": "imagen1",
                                               "publicaciones": [
                                                   {
                                                       "uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c664",
                                                        "titulo": "Las Meninas",
                                                        "valoracionMedia": 4.5
                                                   },
                                                   {
                                                             "uuid": "fdb4326b-0b5e-4f1d-8b47-5eb7e60d1d4a",
                                                             "titulo": "La Ãšltima Cena",
                                                             "valoracionMedia": 4.7
                                                   }
                                               ]
                                         }
                                                                    """)})}),
            @ApiResponse(responseCode = "404", description = "Not found any category with that uuid", content = @Content),
    })
    @GetMapping("/category/{uuid}")
    public ResponseEntity<GetCategoriaDTO> findByUuid(@PathVariable UUID uuid) {
        Categoria category = service.findByUuid(uuid);
        if (category == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(GetCategoriaDTO.of(category));

    }


}

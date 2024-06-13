package com.salesianos.triana.ArtApi.controller;

import com.salesianos.triana.ArtApi.dto.Categoria.CreateCategoryDTO;
import com.salesianos.triana.ArtApi.dto.Categoria.GetCategoriaDTO;
import com.salesianos.triana.ArtApi.dto.Categoria.GetCategoriaForCreatePublication;
import com.salesianos.triana.ArtApi.exception.NotFoundException;
import com.salesianos.triana.ArtApi.model.Categoria;
import com.salesianos.triana.ArtApi.service.CategoriaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
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
            throw new NotFoundException("Category");
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
            throw new NotFoundException("Category");

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
            throw new NotFoundException("Category");

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
            throw new NotFoundException("Category");
        }
        return ResponseEntity.ok(GetCategoriaDTO.of(category));

    }

    @Operation(summary = "Create a category")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "The category has been created succesfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Categoria.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                                                                                        
                                         "uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c498",
                                         "numero": 11,
                                         "nombre": "Tipografía antigua",
                                         "image": "https://www.lucushost.com/blog/wp-content/uploads/2019/06/a%C3%B1adir-categor%C3%ADas-en-WordPress.png",
                                         "publicaciones": []
 
                                    }
                                                                    """)})})
    })
    @PostMapping("/admin/category/create")
    public ResponseEntity<GetCategoriaDTO> createCategory(
            @Valid @RequestBody CreateCategoryDTO categoryDTO) {
        Categoria categoria = service.createCategory(categoryDTO);
        return new ResponseEntity<>(GetCategoriaDTO.of(categoria), HttpStatus.CREATED);
    }

    @Operation(summary = "Edit a category")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The category has been edited succesfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Categoria.class)), examples = {
                            @ExampleObject(value = """
                                    {                                                                       
                                         {                                                                 
                                         "uuid": "eaaa0912-a7f8-49e6-bb1d-46317237c498",
                                         "numero": 11,
                                         "nombre": "Tipografía antigua editado",
                                         "image": "https://cdn-icons-png.flaticon.com/512/2422/2422208.png",
                                         "publicaciones": []
 
                                        }  
                                    }
                                                                    """)})}),
            @ApiResponse(responseCode = "404", description = "Not found any category with that uuid", content = @Content),
    })
    @PutMapping("/admin/category/edit/{categoryUuid}")
    public ResponseEntity<GetCategoriaDTO> editPublication(@PathVariable UUID categoryUuid,
                                                          @Valid @RequestBody CreateCategoryDTO categoryDTO) {

        Optional<Categoria> optional = service.findByUuidOptional(categoryUuid);

        if(optional.isEmpty()){
            throw new NotFoundException("Category");
        }else{
            Categoria categoria = service.editCategory(categoryUuid,categoryDTO);
            return new ResponseEntity<>(GetCategoriaDTO.of(categoria), HttpStatus.OK);
        }
    }


    @Operation(summary = "Method to remove a category")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "The category removed successfully", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = Categoria.class)))}),
            @ApiResponse(responseCode = "404", description = "Not found any category with that UUID", content = @Content)
    })
    @DeleteMapping("/admin/category/remove/{categoryUuid}")
    public ResponseEntity<?> removeCategory(@PathVariable UUID categoryUuid){
        Optional<Categoria> categoriaOptional = service.findByUuidOptional(categoryUuid);
        if(categoriaOptional.isEmpty()){
            throw new NotFoundException("Category");
        }else{
            service.deleteCategory(categoriaOptional.get());
            return  ResponseEntity.noContent().build();
        }
    }

    @Operation(summary = "Gets a category by its number")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The category has been found", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = Categoria.class),
                            examples = {
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
                                                         "titulo": "La última Cena",
                                                         "valoracionMedia": 4.7
                                                     }
                                                 ]
                                             }""")
                            })}),
            @ApiResponse(responseCode = "404", description = "No category found with that number", content = @Content),
    })
    @GetMapping("/category/filter/numero/{numero}")
    public ResponseEntity<GetCategoriaDTO> getCategoriaByNumero(@PathVariable Long numero) {
        Optional<GetCategoriaDTO> categoriaDTO = service.findCategoriaByNumero(numero);
        return categoriaDTO.map(ResponseEntity::ok).orElseThrow(() -> new NotFoundException("Category"));
    }
}

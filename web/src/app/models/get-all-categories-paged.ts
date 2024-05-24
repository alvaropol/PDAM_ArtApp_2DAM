export interface GetAllCategoriesPagedResponse {
    content:          Category[];
    pageable:         Pageable;
    totalElements:    number;
    totalPages:       number;
    last:             boolean;
    size:             number;
    number:           number;
    sort:             Sort;
    numberOfElements: number;
    first:            boolean;
    empty:            boolean;
}

export interface Category {
    uuid:          string;
    numero:        number;
    nombre:        string;
    image:         string;
    publicaciones: Publicaciones[];
}

export interface Publicaciones {
    uuid:                 string;
    titulo:               string;
    image:                string;
    cantidadValoraciones: number;
    valoracionMedia:      number;
}

export interface Pageable {
    pageNumber: number;
    pageSize:   number;
    sort:       Sort;
    offset:     number;
    unpaged:    boolean;
    paged:      boolean;
}

export interface Sort {
    empty:    boolean;
    sorted:   boolean;
    unsorted: boolean;
}

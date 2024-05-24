export interface GetAllCommentsPagedResponse {
    content:          Comment[];
    pageable:         Pageable;
    last:             boolean;
    totalPages:       number;
    totalElements:    number;
    first:            boolean;
    numberOfElements: number;
    size:             number;
    number:           number;
    sort:             Sort;
    empty:            boolean;
}

export interface Comment {
    uuidComment: string;
    usuario:     string;
    comment:     string;
    publication: Publication;
}

export interface Publication {
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

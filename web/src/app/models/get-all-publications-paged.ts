export interface GetAllPublicationsPagedResponse {
    content: Publication[];
    pageable: Pageable;
    last: boolean;
    totalPages: number;
    totalElements: number;
    first: boolean;
    size: number;
    number: number;
    sort: Sort;
    numberOfElements: number;
    empty: boolean;
}

export interface Publication {
    uuid: string;
    artista: string;
    titulo: string;
    descripcion: string;
    tamanyoDimensiones: string;
    direccionObra: string;
    nombreMuseo: string;
    lat: string;
    lon: string;
    valoracionMedia: number;
    image: string;
    categoria: string;
    cantidadValoraciones: number;
    comentarios: Comentario[];
}


export interface Comentario {
    usuario: string;
    comment: string;
}

export interface Pageable {
    pageNumber: number;
    pageSize: number;
    sort: Sort;
    offset: number;
    paged: boolean;
    unpaged: boolean;
}

export interface Sort {
    empty: boolean;
    sorted: boolean;
    unsorted: boolean;
}

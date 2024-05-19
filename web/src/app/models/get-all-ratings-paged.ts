export interface GetAllRatingsPaged {
    content:          Rating[];
    pageable:         Pageable;
    last:             boolean;
    totalElements:    number;
    totalPages:       number;
    first:            boolean;
    size:             number;
    number:           number;
    sort:             Sort;
    numberOfElements: number;
    empty:            boolean;
}

export interface Rating {
    publication: Publication;
    user:        User;
    rating:      number;
}

export interface Publication {
    uuid:                 string;
    titulo:               string;
    image:                string;
    cantidadValoraciones: number;
    valoracionMedia:      number;
}

export interface User {
    uuid:     string;
    nombre:   Nombre;
    username: Username;
}

export enum Nombre {
    Admin = "admin",
    User1 = "User 1",
    User2 = "User 2",
    User3 = "User 3",
}

export enum Username {
    Admin = "admin",
    User1 = "user1",
    User2 = "user2",
    User3 = "user3",
}

export interface Pageable {
    pageNumber: number;
    pageSize:   number;
    sort:       Sort;
    offset:     number;
    paged:      boolean;
    unpaged:    boolean;
}

export interface Sort {
    empty:    boolean;
    sorted:   boolean;
    unsorted: boolean;
}

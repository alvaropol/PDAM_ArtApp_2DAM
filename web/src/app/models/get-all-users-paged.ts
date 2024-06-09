export interface GetAllUsersPagedResponse {
    content:          User[];
    pageable:         Pageable;
    last:             boolean;
    totalPages:       number;
    totalElements:    number;
    first:            boolean;
    size:             number;
    number:           number;
    sort:             Sort;
    numberOfElements: number;
    empty:            boolean;
}

export interface User {
    uuid:      string;
    nombre:    string;
    username:  string;
    email: string;
    role: string;
    isEnabled: boolean;
    createdAt: Date;
    pais:      string;
    favoritos: any[];
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

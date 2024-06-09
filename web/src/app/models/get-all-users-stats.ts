export interface GetAllUserStatsResponse {
    uuid:         string;
    nombre:       string;
    username:     string;
    email:        string;
    role:         string;
    createdAt:    Date;
    isEnabled:    boolean;
    pais:         string;
    favoritos:    any[];
    publications: number;
}

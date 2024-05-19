import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GetAllPublicationsPagedResponse } from '../models/get-all-publications-paged';
import { environment } from '../enviroments/enviroments';
import { CreatePublicationDTO } from '../models/create-publication.interface';

@Injectable({
  providedIn: 'root'
})
export class PublicationService {

  constructor(private http: HttpClient) { }

  getPublicationListPaged(page: number): Observable<GetAllPublicationsPagedResponse> {
    return this.http.get<GetAllPublicationsPagedResponse>(`${environment.apiBaseUrl}publications/paged?page=${page}`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }
  createPublication(publicationDTO: CreatePublicationDTO): Observable<any> {
    return this.http.post<any>(`${environment.apiBaseUrl}publication/create`, publicationDTO,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }

  editPublication(uuid: string, publicationDTO: CreatePublicationDTO): Observable<any> {
    return this.http.put<any>(`${environment.apiBaseUrl}admin/publication/edit/${uuid}`, publicationDTO,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }

  removePublication(uuid: string): Observable<any> {
    return this.http.delete<any>(`${environment.apiBaseUrl}admin/publication/remove/${uuid}`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }
}

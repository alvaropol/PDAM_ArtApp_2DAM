import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GetAllPublicationsPagedResponse } from '../models/get-all-publications-paged';
import { environment } from '../enviroments/enviroments';

@Injectable({
  providedIn: 'root'
})
export class PublicationService {

  constructor(private http: HttpClient) { }

  getPublicationListPaged(page: number): Observable<GetAllPublicationsPagedResponse> {
    return this.http.get<GetAllPublicationsPagedResponse>(`${environment.apiBaseUrl}publications/paged?page=${page}`);
  }
}

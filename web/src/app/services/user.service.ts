import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GetAllUsersPagedResponse } from '../models/get-all-users-paged';
import { environment } from '../enviroments/enviroments';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http: HttpClient) { }

  getUserListPaged(page: number): Observable<GetAllUsersPagedResponse> {
    return this.http.get<GetAllUsersPagedResponse>(`${environment.apiBaseUrl}admin/users/paged?page=${page}`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }

}

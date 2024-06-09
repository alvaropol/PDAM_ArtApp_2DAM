import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GetAllUsersPagedResponse } from '../models/get-all-users-paged';
import { environment } from '../enviroments/enviroments';
import { CreateAdminDTO } from '../models/create-admin';
import { EditUserDTO } from '../models/edit-user';
import { GetUserEnabledResponse } from '../models/get-user-enabled';
import { GetAllUserStatsResponse } from '../models/get-all-users-stats';

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

  getUserListStats(): Observable<GetAllUserStatsResponse[]> {
    return this.http.get<GetAllUserStatsResponse[]>(`${environment.apiBaseUrl}admin/users`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }

  createAdmin(createAdminDTO: CreateAdminDTO): Observable<any> {
    return this.http.post<any>(`${environment.apiBaseUrl}admin/create/admin`, createAdminDTO,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }

  editUser(uuid: string, editUserDTO: EditUserDTO): Observable<any> {
    return this.http.put<any>(`${environment.apiBaseUrl}admin/edit/user/${uuid}`, editUserDTO,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }

  banUser(uuid: string): Observable<GetUserEnabledResponse> {
    return this.http.put<GetUserEnabledResponse>(
        `${environment.apiBaseUrl}admin/ban/user/${uuid}`, 
        {}, 
        {
            headers: {
                accept: 'application/json',
                'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
            }
        }
    );
}

}

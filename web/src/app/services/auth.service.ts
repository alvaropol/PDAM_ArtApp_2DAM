import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { environment } from '../enviroments/enviroments';
import { Observable } from 'rxjs';
import { TokenStorageService } from './token-storage.service';

const httpOptions = {
  headers: new HttpHeaders({ 'Content-Type': 'application/json' })
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private http: HttpClient) { }
  userRole!: string;

  login(username: string, password: string): Observable<any> {

    return this.http.post(`${environment.authUrl}`, {
      username,
      password
    });
  }

  isAdmin(): boolean {
    if (inject(TokenStorageService).getUser().role === 'ROLE_ADMIN') return true;
    return false;
  }

}

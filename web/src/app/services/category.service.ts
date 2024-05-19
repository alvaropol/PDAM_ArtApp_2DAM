import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../enviroments/enviroments';
import { GetCategoriesForFormResponse } from '../models/get-categories-for-form.interface';


@Injectable({
  providedIn: 'root'
})
export class CategoryService {

  constructor(private http: HttpClient) { }

  getCategoriesForForm(): Observable<GetCategoriesForFormResponse[]> {
    return this.http.get<GetCategoriesForFormResponse[]>(`${environment.apiBaseUrl}categories/createform`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }


}

import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../enviroments/enviroments';
import { GetCategoriesForFormResponse } from '../models/get-categories-for-form.interface';
import { GetAllCategoriesPagedResponse } from '../models/get-all-categories-paged';
import { CreateCategoryDTO } from '../models/create-category';



@Injectable({
  providedIn: 'root'
})
export class CategoryService {

  constructor(private http: HttpClient) { }

  getCategoryListPaged(page: number): Observable<GetAllCategoriesPagedResponse> {
    return this.http.get<GetAllCategoriesPagedResponse>(`${environment.apiBaseUrl}categories/paged?page=${page}`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }

  getCategoriesForForm(): Observable<GetCategoriesForFormResponse[]> {
    return this.http.get<GetCategoriesForFormResponse[]>(`${environment.apiBaseUrl}categories/createform`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }

  createCategory(categoryDTO: CreateCategoryDTO): Observable<any> {
    return this.http.post<any>(`${environment.apiBaseUrl}admin/category/create`, categoryDTO,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }

  editCategory(uuid: string, categoryDTO: CreateCategoryDTO): Observable<any> {
    return this.http.put<any>(`${environment.apiBaseUrl}admin/category/edit/${uuid}`, categoryDTO,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }

  removeCategory(uuid: string): Observable<any> {
    return this.http.delete<any>(`${environment.apiBaseUrl}admin/category/remove/${uuid}`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }

}

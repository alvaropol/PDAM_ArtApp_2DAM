import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GetAllRatingsPaged } from '../models/get-all-ratings-paged';
import { environment } from '../enviroments/enviroments';

@Injectable({
  providedIn: 'root'
})
export class RatingService {

  constructor(private http: HttpClient) { }

  getRatingListPaged(page: number): Observable<GetAllRatingsPaged> {
    return this.http.get<GetAllRatingsPaged>(`${environment.apiBaseUrl}admin/ratings/paged?page=${page}`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }
}

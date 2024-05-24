import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GetAllCommentsPagedResponse } from '../models/get-all-comments-paged';
import { environment } from '../enviroments/enviroments';

@Injectable({
  providedIn: 'root'
})
export class CommentService {

  constructor(private http: HttpClient) { }

  getCommentListPaged(page: number): Observable<GetAllCommentsPagedResponse> {
    return this.http.get<GetAllCommentsPagedResponse>(`${environment.apiBaseUrl}admin/comments/paged?page=${page}`,
      {
        headers: {
          accept: 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`
        }
      });
  }
}

import { Component } from '@angular/core';
import { CommentService } from '../../services/comment.service';
import { Comment } from '../../models/get-all-comments-paged';

@Component({
  selector: 'app-comment-board-page',
  templateUrl: './comment-board-page.component.html',
  styleUrl: './comment-board-page.component.css'
})
export class CommentBoardPageComponent {

  listComments: Comment[] = [];
  countComments: number = 0;
  currentPage: number = 0;

  constructor(private commentService: CommentService) { }

  ngOnInit(): void {
    this.loadNewPage();
  }


  loadNewPage() {
    this.commentService.getCommentListPaged(this.currentPage - 1).subscribe(resp => {
      this.listComments = resp.content;
      this.countComments = resp.totalElements;
    });
  }

}

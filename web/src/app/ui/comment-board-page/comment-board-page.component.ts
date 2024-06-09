import { Component } from '@angular/core';
import { CommentService } from '../../services/comment.service';
import { Comment } from '../../models/get-all-comments-paged';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-comment-board-page',
  templateUrl: './comment-board-page.component.html',
  styleUrl: './comment-board-page.component.css'
})
export class CommentBoardPageComponent {

  listComments: Comment[] = [];
  countComments: number = 0;
  currentPage: number = 0;
  selectedComment!: Comment;
  private modalRef: NgbModalRef | undefined;

  messageOfError!: string;
  
  constructor(private commentService: CommentService,private modalService: NgbModal, private snackbar: MatSnackBar) { }

  ngOnInit(): void {
    this.loadNewPage();
  }


  loadNewPage() {
    this.commentService.getCommentListPaged(this.currentPage - 1).subscribe(resp => {
      this.listComments = resp.content;
      this.countComments = resp.totalElements;
    });
  }

  openPopDelete(content: any, comment: Comment) {

    this.selectedComment = comment;
    this.modalRef = this.modalService.open(content, {
      ariaLabelledBy: 'modal-basic-title'
    });
  }


  remove() {
    if (this.selectedComment) {
      this.commentService.removeComment(this.selectedComment.uuidComment).subscribe({
        next: data => {
          this.modalService.dismissAll();
          this.snackbar.open('Comment removed succesfully', 'Close', {
            duration: 3000,
          });
          this.loadNewPage();
        },
        error: err => {{
            this.messageOfError = err.error.message;
          }
        }
      });
    }
  }
}

import { Component, TemplateRef } from '@angular/core';
import { User } from '../../models/get-all-users-paged';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { UserService } from '../../services/user.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { GetAllUserStatsResponse } from '../../models/get-all-users-stats';
import { CommentService } from '../../services/comment.service';
import { RatingService } from '../../services/rating.service';

@Component({
  selector: 'app-user-board-page',
  templateUrl: './user-board-page.component.html',
  styleUrls: ['./user-board-page.component.css']
})
export class UserBoardPageComponent {
  listUsers: User[] = [];
  selectedUser!: User;
  countUsers: number = 0;
  currentPage: number = 0;
  private modalRef: NgbModalRef | undefined;
  usernameExists = false;
  usernames: string[] = [];
  listUserStats: GetAllUserStatsResponse[] = [];
  countPublications : number = 0;
  countComments : number = 0;
  countRatings: number = 0;

  formCreateAdmin: any = {
    username: null,
    password: null,
    verifyPassword: null,
    email: null,
    nombre: null,
    pais: null
  };

  formEditUser: any = {
    email: null,
    nombre: null,
    pais: null
  }

  messageOfError!: string;

  constructor(private userService: UserService, private modalService: NgbModal, private commentService : CommentService, private snackbar: MatSnackBar, private ratingService: RatingService) { }

  ngOnInit(): void {
    this.loadNewPage();
  }

  loadNewPage() {
    this.userService.getUserListPaged(this.currentPage - 1).subscribe(resp => {
      this.listUsers = resp.content;
      this.countUsers = resp.totalElements;
    });
    this.userService.getUserListStats().subscribe(resp => {
      this.listUserStats = resp;
      this.countPublications = this.listUserStats.reduce((total, user) => total + user.publications, 0);
    });
    this.commentService.getCommentListPaged(this.currentPage - 1).subscribe(resp => {

      this.countComments = resp.totalElements;
    });
    this.ratingService.getRatingListPaged(this.currentPage - 1).subscribe(resp => {
      this.countRatings = resp.totalElements;
    });
  }

  checkUsername(username: string): void {
    this.usernameExists = this.usernames.includes(username);
  }

  openForm(content: TemplateRef<any>) {
    this.modalRef = this.modalService.open(content, {
      ariaLabelledBy: 'modal-basic-title'
    });
    this.userService.getUserListPaged(0).subscribe(resp => {
      this.usernames = resp.content.map(user => user.username);
    });
  }

  openEditModal(content: any, user: User) {
    this.selectedUser = user;
    this.formEditUser = {
      email: user.email,
      nombre: user.nombre,
      pais: user.pais
    };
    this.modalRef = this.modalService.open(content, {
      ariaLabelledBy: 'modal-basic-title'
    });
  }

  onSubmit() {
    if (this.usernameExists) {
      this.messageOfError = 'Username already exists';
      return;
    }

    this.userService.createAdmin(this.formCreateAdmin).subscribe({
      next: () => {
        this.modalService.dismissAll();
        this.resetForm();
        this.snackbar.open('User with admin role created successfully', 'Close', {
          duration: 3000,
        });
        this.loadNewPage();
      },
      error: err => {
        this.messageOfError = err.error.message;
      }
    });
  }

  edit() {
    if (this.selectedUser) {
      this.userService.editUser(this.selectedUser.uuid, this.formEditUser).subscribe({
        next: data => {
          this.modalService.dismissAll();
          this.snackbar.open('User edited succesfully', 'Close', {
            duration: 3000,
          });
          this.loadNewPage();
        },
        error: err => {
          {
            this.messageOfError = err.error.message;
          }
        }
      });
    }
  }

  openPopDelete(content: any, user: User) {
    this.selectedUser = user;
    this.modalRef = this.modalService.open(content, {
      ariaLabelledBy: 'modal-basic-title'
    });
  }

  ban() {
    if (this.selectedUser) {
      this.userService.banUser(this.selectedUser.uuid).subscribe({
        next: data => {
          this.modalService.dismissAll();
          this.snackbar.open('User banned succesfully', 'Close', {
            duration: 3000,
          });
          this.loadNewPage();
        },
        error: err => {
          {
            this.messageOfError = err.error.message;
          }
        }
      });
    }
  }

  resetForm() {
    this.formCreateAdmin = {
      username: null,
      password: null,
      verifyPassword: null,
      email: null,
      nombre: null,
      pais: null
    };
    this.usernameExists = false;
  }
}
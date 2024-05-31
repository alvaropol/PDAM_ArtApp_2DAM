import { Component, TemplateRef } from '@angular/core';
import { User } from '../../models/get-all-users-paged';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { UserService } from '../../services/user.service';
import { MatSnackBar } from '@angular/material/snack-bar';

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

  formCreateAdmin: any = {
    username: null,
    password: null,
    verifyPassword: null,
    email: null,
    nombre: null,
    pais: null
  };

  messageOfError!: string;

  constructor(private userService: UserService, private modalService: NgbModal, private snackbar: MatSnackBar) {}

  ngOnInit(): void {
    this.loadNewPage();
  }

  loadNewPage() {
    this.userService.getUserListPaged(this.currentPage - 1).subscribe(resp => {
      this.listUsers = resp.content;
      this.countUsers = resp.totalElements;
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
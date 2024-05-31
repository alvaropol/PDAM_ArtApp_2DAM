import { Component } from '@angular/core';
import { User } from '../../models/get-all-users-paged';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { UserService } from '../../services/user.service';
import { MatSnackBar } from '@angular/material/snack-bar';


@Component({
  selector: 'app-user-board-page',
  templateUrl: './user-board-page.component.html',
  styleUrl: './user-board-page.component.css'
})
export class UserBoardPageComponent {

  listUsers: User[] = [];
  selectedUser!: User;
  countUsers: number = 0;
  currentPage: number = 0;
  private modalRef: NgbModalRef | undefined;

  constructor(private userService: UserService, private modalService: NgbModal, private snackbar: MatSnackBar) { }



  ngOnInit(): void {
    this.loadNewPage();
  }


  loadNewPage() {
    this.userService.getUserListPaged(this.currentPage - 1).subscribe(resp => {
      this.listUsers = resp.content;
      this.countUsers = resp.totalElements;
    });
  }


}

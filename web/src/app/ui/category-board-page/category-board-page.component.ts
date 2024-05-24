import { Component } from '@angular/core';
import { Category } from '../../models/get-all-categories-paged';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { MatSnackBar } from '@angular/material/snack-bar';
import { CategoryService } from '../../services/category.service';

@Component({
  selector: 'app-category-board-page',
  templateUrl: './category-board-page.component.html',
  styleUrl: './category-board-page.component.css'
})
export class CategoryBoardPageComponent {

  listCategories: Category[] = [];
  selectedCategory!: Category;
  countCategories: number = 0;
  currentPage: number = 0;
  private modalRef: NgbModalRef | undefined;


  constructor(private categoryService: CategoryService, private modalService: NgbModal, private snackbar: MatSnackBar) { }

  formCategory: any = {
    nombre: null,
    image: null,
  }

  ngOnInit(): void {
    this.loadNewPage();
  }


  loadNewPage() {
    this.categoryService.getCategoryListPaged(this.currentPage - 1).subscribe(resp => {
      this.listCategories = resp.content;
      this.countCategories = resp.totalElements;
    });
  }
}

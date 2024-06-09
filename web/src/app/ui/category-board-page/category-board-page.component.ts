import { Component, TemplateRef } from '@angular/core';
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

  formEditCategory: any = {
    nombre: null,
    image: null,
  }

  messageOfError!: string;


  ngOnInit(): void {
    this.loadNewPage();
  }


  loadNewPage() {
    this.categoryService.getCategoryListPaged(this.currentPage - 1).subscribe(resp => {
      this.listCategories = resp.content;
      this.countCategories = resp.totalElements;
    });
  }

  openForm(content: TemplateRef<any>) {
    this.modalRef = this.modalService.open(content, {
      ariaLabelledBy: 'modal-basic-title'
    });
  }

  onSubmit() {
    this.categoryService.createCategory(this.formCategory).subscribe({
      next: () => {
        this.modalService.dismissAll();
        this.formCategory.nombre = '';
        this.formCategory.image = '';
        this.snackbar.open('Category created succesfully', 'Close', {
          duration: 3000,
        });
        this.loadNewPage();
      },
      error: err => {
        this.messageOfError = err.error.message;
      }
    });
  }

  openEditModal(content: any, category: Category) {
    this.selectedCategory = category;
      this.formEditCategory = {
        nombre : category.nombre,
        image: category.image,
      };
      this.modalRef = this.modalService.open(content, {
        ariaLabelledBy: 'modal-basic-title'
      });
  }

  edit() {
    if (this.selectedCategory) {
      this.categoryService.editCategory(this.selectedCategory.uuid, this.formEditCategory).subscribe({
        next: data => {
          this.modalService.dismissAll();
          this.snackbar.open('Category edited succesfully', 'Close', {
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

openPopDelete(content: any, category: Category) {

  this.selectedCategory = category;
  this.modalRef = this.modalService.open(content, {
    ariaLabelledBy: 'modal-basic-title'
  });
}


remove() {
  if (this.selectedCategory) {
    this.categoryService.removeCategory(this.selectedCategory.uuid).subscribe({
      next: data => {
        this.modalService.dismissAll();
        this.snackbar.open('Category removed succesfully', 'Close', {
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

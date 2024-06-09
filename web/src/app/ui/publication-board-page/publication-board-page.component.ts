import { Component, OnInit, TemplateRef } from '@angular/core';
import { Publication } from '../../models/get-all-publications-paged';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { PublicationService } from '../../services/publication.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { CategoryService } from '../../services/category.service';
import { GetCategoriesForFormResponse } from '../../models/get-categories-for-form.interface';

@Component({
  selector: 'app-publication-board-page',
  templateUrl: './publication-board-page.component.html',
  styleUrl: './publication-board-page.component.css'
})
export class PublicationBoardPageComponent implements OnInit {

  listPublications: Publication[] = [];
  selectedPublication!: Publication;
  countPublications: number = 0;
  currentPage: number = 0;
  categories: GetCategoriesForFormResponse[] = [];
  private modalRef: NgbModalRef | undefined;

  formPublication: any = {
    titulo: null,
    descripcion: null,
    tamanyoDimensiones: null,
    direccionObra: null,
    nombreMuseo: null,
    lat: null,
    lon: null,
    image: null,
    numeroCategoria: null
  }

  formEditPublication: any = {
    titulo: null,
    descripcion: null,
    tamanyoDimensiones: null,
    direccionObra: null,
    nombreMuseo: null,
    lat: null,
    lon: null,
    image: null,
    numeroCategoria: null
  }

  messageOfError!: string;

  constructor(private publicationService: PublicationService, private categoryService: CategoryService, private modalService: NgbModal, private snackbar: MatSnackBar) { }

  ngOnInit(): void {
    this.loadNewPage();
  }


  loadNewPage() {
    this.publicationService.getPublicationListPaged(this.currentPage - 1).subscribe(resp => {
      this.listPublications = resp.content;
      this.countPublications = resp.totalElements;
    });
  }

  openForm(content: TemplateRef<any>) {
    this.categoryService.getCategoriesForForm().subscribe(resp => {
      this.categories = resp;
    });
    this.modalRef = this.modalService.open(content, {
      ariaLabelledBy: 'modal-basic-title'
    });
  }



  openEditModal(content: any, publication: Publication) {
    this.categoryService.getCategoriesForForm().subscribe(resp => {
      this.categories = resp;
 
      const categoriaSeleccionada = this.categories.find(category => category.nombre === publication.categoria);

    this.selectedPublication = publication;
      this.formEditPublication = {
        titulo : publication.titulo,
        descripcion : publication.descripcion,
        tamanyoDimensiones: publication.tamanyoDimensiones,
        direccionObra: publication.direccionObra,
        nombreMuseo: publication.nombreMuseo,
        lat: publication.lat,
        lon: publication.lon,
        image: publication.image,
        numeroCategoria : categoriaSeleccionada ? categoriaSeleccionada.numero : null
      };
      this.modalRef = this.modalService.open(content, {
        ariaLabelledBy: 'modal-basic-title'
      });
    });
  }

  onSubmit() {
    this.publicationService.createPublication(this.formPublication).subscribe({
      next: () => {
        this.modalService.dismissAll();
        this.formPublication.titulo = '';
        this.formPublication.descripcion = '';
        this.formPublication.tamanyoDimensiones = '';
        this.formPublication.direccionObra = '';
        this.formPublication.nombreMuseo = '';
        this.formPublication.lat = '';
        this.formPublication.lon = '';
        this.formPublication.image = '';
        this.snackbar.open('Publication created succesfully', 'Close', {
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
    
      if (this.selectedPublication) {
        this.publicationService.editPublication(this.selectedPublication.uuid, this.formEditPublication).subscribe({
          next: data => {
            this.modalService.dismissAll();
            this.snackbar.open('Publication edited succesfully', 'Close', {
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

  openPopDelete(content: any, publication: Publication) {

    this.selectedPublication = publication;
    this.modalRef = this.modalService.open(content, {
      ariaLabelledBy: 'modal-basic-title'
    });
  }


  remove() {
    if (this.selectedPublication) {
      this.publicationService.removePublication(this.selectedPublication.uuid).subscribe({
        next: data => {
          this.modalService.dismissAll();
          this.snackbar.open('Publication removed succesfully', 'Close', {
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

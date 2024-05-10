import { Component, OnInit } from '@angular/core';
import { Publication } from '../../models/get-all-publications-paged';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { PublicationService } from '../../services/publication.service';

@Component({
  selector: 'app-publication-board-page',
  templateUrl: './publication-board-page.component.html',
  styleUrl: './publication-board-page.component.css'
})
export class PublicationBoardPageComponent implements OnInit {

  listPublications: Publication[] = [];
  selectedPublication!: Publication;
  countPublications: number = 0;
  currentPage: number = 1;
  private modalRef: NgbModalRef | undefined;

  constructor(private publicationService: PublicationService, private modalService: NgbModal) { }

  ngOnInit(): void {
    throw new Error('Method not implemented.');
  }



}

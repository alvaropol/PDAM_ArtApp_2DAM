import { Component, OnInit } from '@angular/core';
import { RatingService } from '../../services/rating.service';
import { Rating } from '../../models/get-all-ratings-paged';

@Component({
  selector: 'app-rating-board-page',
  templateUrl: './rating-board-page.component.html',
  styleUrl: './rating-board-page.component.css'
})
export class RatingBoardPageComponent implements OnInit {

  listRatings: Rating[] = [];
  countRatings: number = 0;
  currentPage: number = 0;

  constructor(private ratingService: RatingService) { }

  ngOnInit(): void {
    this.loadNewPage();
  }


  loadNewPage() {
    this.ratingService.getRatingListPaged(this.currentPage - 1).subscribe(resp => {
      this.listRatings = resp.content;
      this.countRatings = resp.totalElements;
    });
  }

}

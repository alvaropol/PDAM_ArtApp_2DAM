import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-error-page',
  templateUrl: './error-page.component.html',
  styleUrl: './error-page.component.css'
})
export class ErrorPageComponent implements OnInit {
  errorMessage: string;
  num1: string;
  num2: string;
  isAdmin: boolean | undefined;

  constructor(private route: ActivatedRoute) {
    this.errorMessage = 'Unknown error occurred';
    this.num1 = "4";
    this.num2 = "4";
  }

  ngOnInit(): void {
    this.route.queryParams.subscribe(params => {
      if (params['error']) {
        this.errorMessage = params['error'];
      }
      if (params['num1']) {
        this.num1 = params['num1'];
      }
      if (params['num2']) {
        this.num2 = params['num2'];
      }
      if (localStorage.getItem("ROLE") == "ROLE_ADMIN") {
        this.isAdmin = true;
      } else {
        this.isAdmin = false;
      }
    });
  }
}

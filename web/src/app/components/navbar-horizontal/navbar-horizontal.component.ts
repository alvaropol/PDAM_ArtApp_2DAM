import { Component, Input, OnInit, Output } from '@angular/core';

@Component({
  selector: 'app-navbar-horizontal',
  templateUrl: './navbar-horizontal.component.html',
  styleUrl: './navbar-horizontal.component.css'
})
export class NavbarHorizontalComponent {

  @Input() entity: string | undefined;

  getUsername() {
    return localStorage.getItem('USERNAME');
  }
}

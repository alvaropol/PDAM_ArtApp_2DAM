import { Injectable } from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';
import feather from 'feather-icons';

@Injectable({
  providedIn: 'root'
})
export class FeatherIconsService {

  constructor(private router: Router) {
    this.router.events.subscribe(event => {
      if (event instanceof NavigationEnd) {
        this.replaceIcons();
      }
    });
  }

  replaceIcons() {
    feather.replace();
  }
}
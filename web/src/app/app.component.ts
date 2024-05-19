import { Component } from '@angular/core';
import { TokenStorageService } from './services/token-storage.service';
import { FeatherIconsService } from './services/feather-icons.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'ArtApp';
  isLoggedIn = false;
  username?: string;

  constructor(private tokenStorageService: TokenStorageService, private featherIconsService: FeatherIconsService) { }

  ngOnInit(): void {
    this.isLoggedIn = !!this.tokenStorageService.getToken();

    if (this.isLoggedIn) {
      const user = this.tokenStorageService.getUser();
      this.username = user.username;
    }
  }

  logout(): void {
    this.tokenStorageService.signOut();
    window.location.reload();
  }
}

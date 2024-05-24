import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { TokenStorageService } from '../../services/token-storage.service';

@Component({
  selector: 'app-login-page',
  templateUrl: './login-page.component.html',
  styleUrl: './login-page.component.css'
})
export class LoginPageComponent {

  form: any = {
    username: null,
    password: null
  };
  isLoggedIn = false;
  isLoginFailed = false;
  errorMessage = '';
  role!: string;
  username!: string;

  constructor(private authService: AuthService, private tokenStorage: TokenStorageService, private router: Router) { }

  ngOnInit(): void {
    if (this.tokenStorage.getToken()) {
      this.isLoggedIn = true;
    }
  }

  onSubmit(): void {
    const { username, password } = this.form;

    this.authService.login(username, password).subscribe({
      next: data => {

        this.tokenStorage.saveToken(data.token);
        this.tokenStorage.saveUser(data);
        localStorage.setItem("USER_ID", data.id)
        localStorage.setItem("USERNAME", data.username)
        localStorage.setItem("ROLE", data.role)
        this.isLoginFailed = false;
        this.isLoggedIn = true;
        this.role = data.role;
        this.username = data.username;
        if (this.role === 'ROLE_ADMIN') {
          this.router.navigate(['/publications']);
        } else {
          this.router.navigate(['/error-page'], { queryParams: { error: 'Access dennied, only admins can access this page', num1: '4', num2: '1' } });
        }

      },
      error: err => {
        if (err.status === 500) {
          this.errorMessage = 'The username or password is incorrect.';
        } else {
          this.errorMessage = err.error.message;
        }
        this.isLoginFailed = true;
        console.log(err);
      },
    });
  }

  reloadPage(): void {
    window.location.reload();
  }
}

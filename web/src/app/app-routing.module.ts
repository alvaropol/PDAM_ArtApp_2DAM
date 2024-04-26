import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginPageComponent } from './ui/login-page/login-page.component';
import { ErrorPage404Component } from './ui/error-page-404/error-page-404.component';

const routes: Routes = [
  { path: 'login', component: LoginPageComponent },
  { path: 'error-404', component: ErrorPage404Component },
  { path: '', redirectTo: '/login', pathMatch: 'full' },
  { path: '**', redirectTo: '/error-404' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

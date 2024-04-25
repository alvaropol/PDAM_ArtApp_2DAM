import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { ErrorPage404Component } from './ui/error-page-404/error-page-404.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { LoginPageComponent } from './ui/login-page/login-page.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginPageComponent,
    ErrorPage404Component
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    NgbModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatSelectModule } from '@angular/material/select';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { LoginPageComponent } from './ui/login-page/login-page.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { HttpClientModule } from '@angular/common/http';
import { ErrorPageComponent } from './ui/error-page/error-page.component';
import { PublicationBoardPageComponent } from './ui/publication-board-page/publication-board-page.component';
import { NavbarComponent } from './components/navbar/navbar.component';
import { NavbarHorizontalComponent } from './components/navbar-horizontal/navbar-horizontal.component';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { RatingBoardPageComponent } from './ui/rating-board-page/rating-board-page.component';
import { CommentBoardPageComponent } from './ui/comment-board-page/comment-board-page.component';
import { CategoryBoardPageComponent } from './ui/category-board-page/category-board-page.component';
import { UserBoardPageComponent } from './ui/user-board-page/user-board-page.component';



@NgModule({
  declarations: [
    AppComponent,
    LoginPageComponent,
    ErrorPageComponent,
    PublicationBoardPageComponent,
    NavbarComponent,
    NavbarHorizontalComponent,
    RatingBoardPageComponent,
    CommentBoardPageComponent,
    CategoryBoardPageComponent,
    UserBoardPageComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    NgbModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule,
    MatFormFieldModule,
    MatInputModule,
    MatAutocompleteModule,
    MatSelectModule,
    HttpClientModule,
    MatSnackBarModule,
    BrowserAnimationsModule
  ],
  providers: [],
  bootstrap: [AppComponent],
  schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class AppModule { }
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginPageComponent } from './ui/login-page/login-page.component';
import { ErrorPageComponent } from './ui/error-page/error-page.component';
import { PublicationBoardPageComponent } from './ui/publication-board-page/publication-board-page.component';
import { AuthGuard } from './auth.guard';
import { RatingBoardPageComponent } from './ui/rating-board-page/rating-board-page.component';
import { CommentBoardPageComponent } from './ui/comment-board-page/comment-board-page.component';
import { CategoryBoardPageComponent } from './ui/category-board-page/category-board-page.component';
import { UserBoardPageComponent } from './ui/user-board-page/user-board-page.component';

const routes: Routes = [
  { path: 'login', component: LoginPageComponent, },
  { path: 'error-page', component: ErrorPageComponent },
  { path: 'publications', component: PublicationBoardPageComponent, canActivate: [AuthGuard] },
  { path: 'ratings', component: RatingBoardPageComponent, canActivate: [AuthGuard] },
  { path: 'comments', component: CommentBoardPageComponent, canActivate: [AuthGuard] },
  { path: 'categories', component: CategoryBoardPageComponent, canActivate: [AuthGuard] },
  { path: 'users', component: UserBoardPageComponent, canActivate: [AuthGuard] },
  { path: '', redirectTo: '/login', pathMatch: 'full' },
  { path: '**', redirectTo: '/error-page' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

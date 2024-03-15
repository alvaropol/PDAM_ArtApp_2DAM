part of 'create_comment_bloc.dart';

@immutable
sealed class CreateCommentState {}

final class CreateCommentInitial extends CreateCommentState {}

final class CreateCommentSuccess extends CreateCommentState {}

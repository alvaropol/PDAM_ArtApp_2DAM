part of 'create_comment_bloc.dart';

@immutable
sealed class CreateCommentEvent {}

class CreateComment extends CreateCommentEvent {
  final String? comment;
  final String uuid;
  CreateComment(this.comment, this.uuid);
}

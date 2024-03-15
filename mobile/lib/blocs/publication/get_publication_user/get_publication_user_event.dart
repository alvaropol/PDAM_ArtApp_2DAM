part of 'get_publication_user_bloc.dart';

@immutable
sealed class GetPublicationUserEvent {}

class GetPublicationsUser extends GetPublicationUserEvent {
  GetPublicationsUser();
}

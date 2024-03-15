part of 'get_publication_bloc.dart';

@immutable
sealed class GetPublicationEvent {}

class GetPublicationList extends GetPublicationEvent {
  final int offset;
  GetPublicationList(this.offset);
}

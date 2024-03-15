part of 'publication_detail_bloc.dart';

@immutable
sealed class PublicationDetailEvent {}

class GetPublicationDetail extends PublicationDetailEvent {
  final String uuid;
  GetPublicationDetail(this.uuid);
}

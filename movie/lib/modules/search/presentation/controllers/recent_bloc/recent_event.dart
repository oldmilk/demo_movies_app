part of 'recent_bloc.dart';

abstract class RecentEvent extends Equatable {
  const RecentEvent();
}

class GetRecentItemsEvent extends RecentEvent {
  @override
  List<Object?> get props => [];
}

class AddRecentItemEvent extends RecentEvent {
  final Recent recent;

  const AddRecentItemEvent({
    required this.recent,
  });

  @override
  List<Object?> get props => [recent];
}

class RemoveRecentItemEvent extends RecentEvent {
  final Recent recent;

  const RemoveRecentItemEvent({
    required this.recent,
  });

  @override
  List<Object?> get props => [recent];
}

class SearchRecentItemEvent extends RecentEvent {
  final Recent recent;

  const SearchRecentItemEvent({
    required this.recent,
  });

  @override
  List<Object?> get props => [recent];
}

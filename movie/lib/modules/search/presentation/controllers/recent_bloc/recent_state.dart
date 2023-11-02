part of 'recent_bloc.dart';

enum RecentRequestStatus {
  empty,
  loading,
  loaded,
  error,
  itemAdded,
  itemRemoved,
  isItemAdded,
}

class RecentState extends Equatable {
  const RecentState({
    this.items = const [],
    this.status = RecentRequestStatus.loading,
  });

  final List<Recent> items;
  final RecentRequestStatus status;

  RecentState copyWith({
    List<Recent>? items,
    RecentRequestStatus? status,
  }) {
    return RecentState(
      items: items ?? this.items,
      status: this.status,
    );
  }

  @override
  List<Object?> get props => [
        items,
        status,
      ];
}

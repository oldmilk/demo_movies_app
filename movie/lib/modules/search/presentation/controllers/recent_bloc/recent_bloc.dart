import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/app/entities/recent.dart';

import 'package:movie/common/utils/base_use_case.dart';
import 'package:movie/modules/search/domain/usecases/add_recent_item_usecase.dart';
import 'package:movie/modules/search/domain/usecases/get_recent_items_usecase.dart';
import 'package:movie/modules/search/domain/usecases/remove_recent_item_usecase.dart';

part 'recent_event.dart';
part 'recent_state.dart';

class RecentBloc extends Bloc<RecentEvent, RecentState> {
  RecentBloc(
    this._getRecentItemsUseCase,
    this._addRecentItemUseCase,
    this._removeRecentItemUseCase,
  ) : super(const RecentState()) {
    on<GetRecentItemsEvent>(_getRecentItems);
    on<AddRecentItemEvent>(_addRecentItem);
    on<RemoveRecentItemEvent>(_removeRecentItem);
  }

  final GetRecentItemsUseCase _getRecentItemsUseCase;
  final AddRecentItemUseCase _addRecentItemUseCase;
  final RemoveRecentItemUseCase _removeRecentItemUseCase;

  Future<void> _getRecentItems(
      RecentEvent event, Emitter<RecentState> emit) async {
    emit(
      state.copyWith(
        status: RecentRequestStatus.loading,
      ),
    );
    final result = await _getRecentItemsUseCase.call(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          status: RecentRequestStatus.error,
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(
            state.copyWith(
              status: RecentRequestStatus.empty,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: RecentRequestStatus.loaded,
              items: r,
            ),
          );
        }
      },
    );
  }

  Future<void> _addRecentItem(
      AddRecentItemEvent event, Emitter<RecentState> emit) async {
    emit(
      state.copyWith(
        status: RecentRequestStatus.loading,
      ),
    );
    final result = await _addRecentItemUseCase.call(event.recent);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: RecentRequestStatus.error,
        ),
      ),
      (r) {
        List<Recent> rl = state.items.toList();
        rl.add(r);

        emit(state.copyWith(
          status: RecentRequestStatus.itemAdded,
          items: rl,
        ));
      },
    );
  }

  Future<void> _removeRecentItem(
      RemoveRecentItemEvent event, Emitter<RecentState> emit) async {
    emit(
      state.copyWith(
        status: RecentRequestStatus.loading,
      ),
    );

    final result = await _removeRecentItemUseCase.call(event.recent);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: RecentRequestStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: RecentRequestStatus.itemRemoved,
        ),
      ),
    );
  }
}

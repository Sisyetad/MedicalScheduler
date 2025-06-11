import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/presentation/Provider/states/Common/queue_state.dart';
import 'package:medical_scheduler/Application/Usecases/queue/getQueues.dart';
import 'package:medical_scheduler/Application/Usecases/queue/update_queue.dart';
import 'package:medical_scheduler/presentation/events/Receptionist/receptionist_queue_events.dart';

class ReceptionistQueueNotifier extends StateNotifier<QueueUiState> {
  final UpdateQueue updateQueueUseCase;
  final GetAllQueues getAllQueues;
  ReceptionistQueueNotifier(this.updateQueueUseCase, this.getAllQueues)
    : super(QueueUiState());

  Future<void> mapEventToState(ReceptionistQueueEvent event) async {
    if (event is FetchReceptionistQueues) {
      await _fetchQueues();
    } else if (event is UpdateReceptionistQueueStatus) {
      await _updateQueueStatus(event.queueId, event.status);
    } else if (event is FilterReceptionistQueues) {
      await filterQueues(event.query);
    }
  }

  Future<void> _fetchQueues() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final result = await getAllQueues();
      final queues = result.where((q) => q.status != 3).toList();
      final completed = queues.where((q) => q.status == 3).length;
      final pending = queues.where((q) => q.status == 1).length;
      final resolvedPending = queues.where((q) => q.status == 2).length;
      state = state.copyWith(
        isLoading: false,
        queues: queues,
        completed: completed,
        pending: pending,
        resolvedPending: resolvedPending,
        isSuccess: true,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        isSuccess: false,
      );
    }
  }

  Future<void> _updateQueueStatus(int queueId, int newStatus) async {
    try {
      state = state.copyWith(isLoading: true);
      await updateQueueUseCase(
        UpdateQueueParams(queueId: queueId, status: newStatus),
      );
      final updatedQueues = state.queues.map((queue) {
        if (queue.queueId == queueId) {
          return queue.copyWith(status: newStatus);
        }
        return queue;
      }).toList();
      final oldQueue = state.queues.firstWhere((q) => q.queueId == queueId);
      final oldStatus = oldQueue.status;
      int completed = state.completed;
      int pending = state.pending;
      int resolved = state.resolvedPending;
      if (oldStatus != newStatus) {
        if (oldStatus == 1) pending--;
        if (oldStatus == 2) resolved--;
        if (oldStatus == 3) completed--;
        if (newStatus == 1) pending++;
        if (newStatus == 2) resolved++;
        if (newStatus == 3) completed++;
      }
      state = state.copyWith(
        queues: updatedQueues,
        completed: completed,
        pending: pending,
        resolvedPending: resolved,
        isSuccess: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> filterQueues(String query) async {
    if (query.isEmpty) {
      await _fetchQueues();
      return;
    }
    final filteredQueues = state.queues.where((queue) {
      return queue.patient.username.toLowerCase().contains(
            query.toLowerCase(),
          ) ||
          queue.queueId.toString().contains(query);
    }).toList();
    state = state.copyWith(queues: filteredQueues);
  }
}

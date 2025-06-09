import 'package:medical_scheduler/domain/entities/response/queue.dart';

class QueueUiState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final int completed;
  final int pending;
  final int resolvedPending;
  final List<DataQueue> queues;

  QueueUiState({
    this.completed = 0,
    this.pending = 0,
    this.resolvedPending = 0,
    this.queues = const[],
    this.error,
    this.isLoading = false,
    this.isSuccess = false,
  });

  QueueUiState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    int? completed,
    int? pending,
    int? resolvedPending,
    List<DataQueue>? queues,
  }) {
    return QueueUiState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      completed: completed ?? this.completed,
      pending: pending ?? this.pending,
      resolvedPending: resolvedPending ?? this.resolvedPending,
      queues: queues ?? this.queues,
    );
  }
}

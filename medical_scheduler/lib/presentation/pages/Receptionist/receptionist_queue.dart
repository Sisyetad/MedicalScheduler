import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart';
import 'package:medical_scheduler/presentation/widgets/popup_menu.dart';
import 'package:medical_scheduler/presentation/widgets/resolved_widget.dart';
import 'package:medical_scheduler/presentation/widgets/side_bar.dart';
import 'package:medical_scheduler/presentation/widgets/pending_widget.dart';
import 'package:medical_scheduler/presentation/widgets/receptionist_queue_widget.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Receptionist/receptionist_queue_provider.dart';
import 'package:medical_scheduler/presentation/events/Receptionist/receptionist_queue_events.dart';

// leave import for you

class ReceptionistQueuePage extends ConsumerStatefulWidget {
  const ReceptionistQueuePage({super.key});

  @override
  ConsumerState<ReceptionistQueuePage> createState() =>
      _ReceptionistQueuePageState();
}

class _ReceptionistQueuePageState extends ConsumerState<ReceptionistQueuePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(receptionistQueueNotifierProvider.notifier)
          .mapEventToState(FetchReceptionistQueues());
    });
  }

  void _filterQueues(String query) {
    ref
        .read(receptionistQueueNotifierProvider.notifier)
        .mapEventToState(FilterReceptionistQueues(query));
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authViewModelProvider.select((s) => s.user));
    return SafeArea(
      child: Scaffold(
        drawer: const SideBar(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          actions: const [PopupMenu()],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Receptionist queue",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) => Resolved(
                  resolvedCount: ref
                      .watch(receptionistQueueNotifierProvider)
                      .resolvedPending,
                ),
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) => Pending(
                  pendingCount: ref
                      .watch(receptionistQueueNotifierProvider)
                      .pending,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {
                    context.go(
                      '/receptionist/add-patient/${currentUser?.userId}',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 39, 81, 195),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Add patient'),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Search patient in queue...",
                ),
                onChanged: _filterQueues,
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, _) {
                  final state = ref.watch(receptionistQueueNotifierProvider);
                  return ReceptionistQueueWidget(queues: state.queues);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

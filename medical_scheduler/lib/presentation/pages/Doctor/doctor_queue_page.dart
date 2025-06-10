import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Doctor/queue_provider.dart';
import 'package:medical_scheduler/presentation/widgets/completed_widget.dart';
import 'package:medical_scheduler/presentation/widgets/pending_widget.dart';
import 'package:medical_scheduler/presentation/widgets/popup_menu.dart';
import 'package:medical_scheduler/presentation/widgets/resolved_widget.dart';
import 'package:medical_scheduler/presentation/widgets/side_bar.dart';
import 'package:medical_scheduler/presentation/widgets/doctor_queue_widget.dart';
import 'package:medical_scheduler/presentation/events/Doctor/doctor_queue_events.dart';

class DoctorPage extends ConsumerStatefulWidget {
  const DoctorPage({super.key});

  @override
  ConsumerState<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends ConsumerState<DoctorPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(doctorQueueNotifierProvider.notifier)
          .mapEventToState(FetchQueues());
    });
  }

  void _filterQueues(String query) {
    ref
        .read(doctorQueueNotifierProvider.notifier)
        .mapEventToState(FilterQueues(query));
  }

  @override
  Widget build(BuildContext context) {
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
                  "Doctor Queue",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              Consumer(
                builder: (context, ref, child) => Completed(
                  completedCount: ref
                      .watch(doctorQueueNotifierProvider)
                      .completed,
                ),
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) => Pending(
                  pendingCount: ref.watch(doctorQueueNotifierProvider).pending,
                  label: '',
                ),
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) => Resolved(
                  resolvedCount: ref
                      .watch(doctorQueueNotifierProvider)
                      .resolvedPending,
                ),
              ),
              const SizedBox(height: 20),
              SearchBar(
                hintText: "Search for Users...",
                onChanged: _filterQueues,
              ),
              const SizedBox(height: 20),

              // DoctorQueueWidget uses the queues list from state
              Consumer(
                builder: (context, ref, _) {
                  final state = ref.watch(doctorQueueNotifierProvider);

                  return DoctorQueueWidget(queues: state.queues);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

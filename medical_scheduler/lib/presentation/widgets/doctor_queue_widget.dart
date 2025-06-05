import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/domain/entities/response/queue.dart';
import 'package:medical_scheduler/presentation/Provider/providers/queue_provider.dart';
import 'package:medical_scheduler/presentation/events/queue_events.dart'; // import your DataQueue entity

class DoctorQueueWidget extends StatelessWidget {
  final List<DataQueue> queues;

  const DoctorQueueWidget({
    super.key,
    required this.queues,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: WidgetStateProperty.resolveWith<Color?>(
        (states) => const Color.fromARGB(255, 43, 95, 145),
      ),
      headingRowHeight: 40,
      dataRowHeight: 120,
      columns: const [
        DataColumn(label: Text('Name', style: TextStyle(color: Colors.white))),
        DataColumn(label: Text('Status', style: TextStyle(color: Colors.white))),
        DataColumn(label: Text('Actions', style: TextStyle(color: Colors.white))),
      ],
      rows: queues.map((queue) {
        return DataRow(cells: [
          DataCell(Text(queue.patient.firstName)),
          DataCell(Text(_statusText(queue.status))),
          DataCell(
            SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 26,
                    child: Consumer(
                      builder: (context, ref, child) => ElevatedButton(
                        onPressed: () => ref
                            .read(doctorQueueNotifierProvider.notifier)
                            .mapEventToState(UpdateQueueStatus(queue.queueId, queue.status == 1 ? 2 : 1)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2B5F91),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        child: Text(
                          queue.status == 1 ? 'Resolve' : 'Pend',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 26,
                    child: ElevatedButton(
                      onPressed: () => context.go('/patient_history/${queue.patient.patientId}'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2B5F91),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      child: const Text('View History', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 26,
                    child: Consumer(
                      builder: (context, ref, child) => ElevatedButton(
                        onPressed: () => ref
                            .read(doctorQueueNotifierProvider.notifier)
                            .mapEventToState(UpdateQueueStatus(queue.queueId, 3)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2B5F91),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        child: const Text('Complete', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]);
      }).toList(),
      border: TableBorder.all(color: Colors.grey, width: 1),
    );
  }

  String _statusText(int status) {
    switch (status) {
      case 1:
        return 'Pending';
      case 2:
        return 'Resolved';
      case 3:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}

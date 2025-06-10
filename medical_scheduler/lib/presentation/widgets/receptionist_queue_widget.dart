import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/domain/entities/response/queue.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Doctor/queue_provider.dart';
import 'package:medical_scheduler/presentation/events/Doctor/doctor_queue_events.dart';

class ReceptionistQueueWidget extends StatelessWidget {
  final List<DataQueue> queues;

  const ReceptionistQueueWidget({super.key, required this.queues});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: WidgetStateProperty.resolveWith<Color?>(
        (states) => const Color(0xFF2B5F91), // Matches blue header background
      ),
      headingRowHeight: 40,
      dataRowHeight: 50, // Compact rows
      columns: const [
        DataColumn(
          label: Text('Name', style: TextStyle(color: Colors.white)),
        ),
        DataColumn(
          label: Text('Status', style: TextStyle(color: Colors.white)),
        ),
        DataColumn(
          label: Text('Actions', style: TextStyle(color: Colors.white)),
        ),
      ],
      rows: queues.map((queue) {
        return DataRow(
          cells: [
            DataCell(Text(queue.patient.firstName)),
            DataCell(Text(_statusText(queue.status))),
            DataCell(
              Consumer(
                builder: (context, ref, child) => SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () => ref
                        .read(doctorQueueNotifierProvider.notifier)
                        .mapEventToState(
                          UpdateQueueStatus(
                            queue.queueId,
                            queue.status == 1 ? 2 : 1,
                          ),
                        ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2B5F91),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: const Text(
                      'Resolve',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }).toList(),
      border: TableBorder.all(color: Colors.grey.shade300, width: 1),
    );
  }

  String _statusText(int status) {
    switch (status) {
      case 1:
        return 'Not Pending';
      case 2:
        return 'Resolved';
      case 3:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}

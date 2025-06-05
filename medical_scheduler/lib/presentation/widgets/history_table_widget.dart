import 'package:flutter/material.dart';
import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';

class HistoryTableWidget extends StatelessWidget {
  final List<DiagnosisHistory> diagnosisList;
  final Function(int diagnosisId) onViewDetails;

  const HistoryTableWidget({
    super.key,
    required this.diagnosisList,
    required this.onViewDetails,
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
        DataColumn(
          label: SizedBox(
            width: 70,
            child: Text('Date', style: TextStyle(color: Colors.white)),
          ),
        ),
        DataColumn(
          label: Text('Actions', style: TextStyle(color: Colors.white)),
        ),
      ],
      rows:
          diagnosisList.map((diagnosis) {
            return DataRow(
              cells: [
                DataCell(
                  Text(
                    diagnosis.diagnosisName,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                DataCell(
                  SizedBox(
                    width: 70,
                    child: Text(
                      diagnosis.createdTime,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
                DataCell(
                  SizedBox(
                    height: 30,
                    width: 90,
                    child: ElevatedButton(
                      onPressed: () => onViewDetails(diagnosis.diagnosisId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2B5F91),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Text(
                        'View',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
      border: TableBorder.all(color: Colors.grey, width: 1),
    );
  }
}

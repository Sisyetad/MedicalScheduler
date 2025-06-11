import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Doctor/patient_provider.dart';
import 'package:medical_scheduler/presentation/events/Doctor/patient_history_events.dart';
import 'package:medical_scheduler/presentation/widgets/back_to_home.dart';
import 'package:medical_scheduler/presentation/widgets/completed_widget.dart';
import 'package:medical_scheduler/presentation/widgets/history_table_widget.dart';

class PatientHistoryPage extends ConsumerStatefulWidget {
  final int patientId;
  const PatientHistoryPage({super.key, required this.patientId});

  @override
  ConsumerState<PatientHistoryPage> createState() => _PatientHistoryState();
}

class _PatientHistoryState extends ConsumerState<PatientHistoryPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(patientHistoryNotifierProvider.notifier)
          .handleEvent(FetchPatientHistory(widget.patientId));
    });
  }

  void _filterQueues(String query) {
    ref
        .read(patientHistoryNotifierProvider.notifier)
        .handleEvent(FilterPatientHistryQueues(query));
  }

  void _handleViewDetails(int diagnosisId) {
    context.go('/diagnosis_detail/$diagnosisId');
  }

  void _handleAddDiagnosis() {
    context.go('/diagnosis_form/${widget.patientId}');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(patientHistoryNotifierProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          key: const Key('patient_history_appbar'),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
        ),
        body: state.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  key: Key('patient_history_loading'),
                ),
              )
            : state.error != null
            ? Center(
                child: Text(
                  'Error: ${state.error}',
                  key: const Key('patient_history_error'),
                  style: const TextStyle(color: Colors.red),
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Patient History",
                        key: Key('patient_history_title'),
                        style: TextStyle(fontSize: 25),
                      ),
                    ),

                    if (state.patient != null)
                      Container(
                        key: const Key('patient_history_info_card'),
                        width: 308,
                        height: 193,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 43, 95, 145),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Name: ${state.patient!.firstName} ${state.patient!.lastName}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Birth Date: ${state.patient!.dateOfBirth}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Id: ${state.patient!.patientId}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Location: ${state.patient!.address}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 20),

                    Consumer(
                      builder: (context, ref, child) => Completed(
                        key: const Key('patient_history_completed_count'),
                        completedCount: state.diagnosisList.length,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      key: const Key('patient_history_add_diagnosis_button'),
                      onPressed: () => _handleAddDiagnosis(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 39, 81, 195),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Add Diagnosis"),
                    ),

                    const SizedBox(height: 20),

                    SearchBar(
                      key: const Key('patient_history_search_bar'),
                      hintText: 'Search for Diagnosis...',
                      onChanged: _filterQueues,
                    ),

                    const SizedBox(height: 20),

                    HistoryTableWidget(
                      key: const Key('patient_history_table_widget'),
                      diagnosisList: state.diagnosisList,
                      onViewDetails: _handleViewDetails,
                    ),

                    const SizedBox(height: 30),

                    const BackToHome(roleId: 4),
                  ],
                ),
              ),
      ),
    );
  }
}

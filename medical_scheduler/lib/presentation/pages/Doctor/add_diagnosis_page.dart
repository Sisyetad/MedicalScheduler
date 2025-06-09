import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Doctor/diagnosis_form_provider.dart';
import 'package:medical_scheduler/presentation/events/Doctor/diagnosis_form_events.dart';

class AddDiagnosisScreen extends ConsumerStatefulWidget {
  final int patientId;
  const AddDiagnosisScreen({super.key, required this.patientId});

  @override
  ConsumerState<AddDiagnosisScreen> createState() => _AddDiagnosisState();
}

class _AddDiagnosisState extends ConsumerState<AddDiagnosisScreen> {
  final _diagnosisController = TextEditingController();
  final _medicationController = TextEditingController();
  final _commentsController = TextEditingController();

  @override
  void dispose() {
    _diagnosisController.dispose();
    _medicationController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(diagnosisFormNotifierProvider);
    final notifier = ref.read(diagnosisFormNotifierProvider.notifier);

    if (state.isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Diagnosis added successfully!')),
        );
        notifier.state = notifier.state.copywith(isSuccess: false);

        context.go('/patient_history/${widget.patientId}');
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.tertiary),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Add Diagnosis", style: TextStyle(fontSize: 25)),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Diagnosis Name", style: TextStyle(fontSize: 20)),
                ),
                TextField(
                  controller: _diagnosisController,
                  decoration: InputDecoration(
                    labelText: 'Diagnosis Name',
                    errorText:
                        state.error != null && _diagnosisController.text.isEmpty
                        ? 'Please enter a diagnosis name'
                        : null,
                  ),
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Medication", style: TextStyle(fontSize: 20)),
                ),
                TextField(
                  controller: _medicationController,
                  decoration: InputDecoration(labelText: "Medication"),
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Comments", style: TextStyle(fontSize: 20)),
                ),
                TextField(
                  controller: _commentsController,
                  decoration: InputDecoration(labelText: 'Comments'),
                ),
                SizedBox(height: 20),
                state.isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          final diagnosisText = _diagnosisController.text
                              .trim();
                          final medicationText = _medicationController.text
                              .trim();
                          final commentText = _commentsController.text.trim();

                          if (diagnosisText.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Diagnosis Name is required'),
                              ),
                            );
                            return;
                          }

                          // ✅ Update state with form values
                          final updatedRequest = state.diagnosis.copyWith(
                            diagnosisName: diagnosisText,
                            medication: medicationText,
                            comment: commentText,
                            patientId: widget.patientId,
                            doctorId: 1,
                            visible: true,
                          );

                          notifier.state = state.copywith(
                            diagnosis: updatedRequest,
                          );
                          await notifier.mapEventToState(SubmitForm());
                        },
                        child: Text('Add Diagnosis'),
                      ),
                if (state.error != null) ...[
                  SizedBox(height: 15),
                  Text(state.error!, style: TextStyle(color: Colors.red)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

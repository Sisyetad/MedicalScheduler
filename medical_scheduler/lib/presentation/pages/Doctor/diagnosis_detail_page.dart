import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Doctor/diagnosis_provider.dart';
import 'package:medical_scheduler/presentation/widgets/back_to_home.dart';
import 'package:medical_scheduler/presentation/widgets/card_widget.dart';

class DiagnosisSummaryScreen extends ConsumerStatefulWidget {
  final int diagnosisId;
  const DiagnosisSummaryScreen({super.key, required this.diagnosisId});

  @override
  ConsumerState<DiagnosisSummaryScreen> createState() => _DiagnosisState();
}

class _DiagnosisState extends ConsumerState<DiagnosisSummaryScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch diagnosis by ID when page loads
    Future.microtask(() {
      ref
          .read(diagnosisDetailNotifierProvider.notifier)
          .fetchDiagnosis(widget.diagnosisId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(diagnosisDetailNotifierProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          key: const Key('diagnosis_summary_appbar'),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Diagnosis Details",
                    key: Key('diagnosis_summary_title'),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                if (state.isLoading)
                  const CircularProgressIndicator(
                    key: Key('diagnosis_summary_loading'),
                  )
                else if (state.error != null)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Error: ${state.error}',
                      key: Key('diagnosis_summary_error'),
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                else if (state.diagnosis != null)
                  GreenBook(
                    key: const Key('diagnosis_summary_greenbook'),
                    diagnosis: state.diagnosis!,
                  )
                else
                  const Text(
                    "No diagnosis found.",
                    key: Key('diagnosis_summary_empty'),
                  ),
                const SizedBox(height: 20),
                const BackToHome(roleId: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

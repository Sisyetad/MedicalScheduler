import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Receptionist/receptionist_add_patient_provider.dart';
import 'package:medical_scheduler/presentation/events/Receptionist/receptionist_add_patient_events.dart';
import 'package:medical_scheduler/presentation/Provider/states/Receptionist/receptionist_add_patient_state.dart';

class AddPatientPage extends ConsumerStatefulWidget {
  const AddPatientPage({super.key});

  @override
  ConsumerState<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends ConsumerState<AddPatientPage> {
  final _formKey = GlobalKey<FormState>();
  String fullName = '';
  String dateOfBirth = '';
  String email = '';
  String address = '';
  String phoneNumber = '';
  bool _hasNavigated = false; // Flag to prevent multiple navigations

  @override
  void initState() {
    super.initState();
    // Removed ref.listen from initState
  }

  @override
  void dispose() {
    // Removed subscription disposal
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref.read(receptionistAddPatientNotifierProvider.notifier).onEvent(
        SubmitPatientForm(
          fullName: fullName,
          dateOfBirth: dateOfBirth,
          email: email,
          address: address,
          phoneNumber: phoneNumber,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(receptionistAddPatientNotifierProvider);

    // Handle navigation after successful patient add
    if (state.isSuccess && !_hasNavigated) {
      _hasNavigated = true; // Set flag to prevent re-navigation
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/receptionist/queue');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Full Name'),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Full Name'),
                onSaved: (val) => fullName = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              const Text('Date of Birth'),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Date of Birth'),
                onSaved: (val) => dateOfBirth = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              const Text('Email'),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                onSaved: (val) => email = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              const Text('Address'),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Address'),
                onSaved: (val) => address = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              const Text('Phone Number'),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Phone Number'),
                onSaved: (val) => phoneNumber = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              if (state.isLoading)
                const Center(child: CircularProgressIndicator()),
              if (state.error != null)
                Text(state.error!, style: const TextStyle(color: Colors.red)),
              if (state.isSuccess)
                const Text('Patient added successfully!', style: TextStyle(color: Colors.green)),
              Center(
                child: ElevatedButton(
                  onPressed: state.isLoading ? null : _submit,
                  child: const Text('Add patient'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 
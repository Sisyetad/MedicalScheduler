import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Receptionist/receptionist_add_patient_provider.dart';
import 'package:medical_scheduler/presentation/Provider/states/Receptionist/receptionist_add_patient_state.dart';
import 'package:medical_scheduler/presentation/events/Receptionist/receptionist_add_patient_events.dart';
import 'package:medical_scheduler/presentation/widgets/back_to_home.dart';

class AddPatientPage extends ConsumerStatefulWidget {
  final int receptionistId;
  const AddPatientPage({super.key, required this.receptionistId});

  @override
  ConsumerState<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends ConsumerState<AddPatientPage> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  String? selectedGender;
  bool _hasNavigated = false;

  @override
  void dispose() {
    fullNameController.dispose();
    dateOfBirthController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Reset state before submitting
      ref.read(receptionistAddPatientNotifierProvider.notifier).state =
          ReceptionistAddPatientState();
      ref
          .read(receptionistAddPatientNotifierProvider.notifier)
          .onEvent(
            SubmitPatientForm(
              fullName: fullNameController.text,
              dateOfBirth: dateOfBirthController.text,
              email: emailController.text,
              address: addressController.text,
              phoneNumber: phoneNumberController.text,
              registeredBy: widget.receptionistId,
              gender: selectedGender ?? '',
            ),
          );
    }
  }

  void _clearForm() {
    fullNameController.clear();
    dateOfBirthController.clear();
    emailController.clear();
    addressController.clear();
    phoneNumberController.clear();
    setState(() {
      selectedGender = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(receptionistAddPatientNotifierProvider);

    if (state.isSuccess && !_hasNavigated) {
      _hasNavigated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _clearForm();
        context.go('/receptionist/queue');
      });
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.tertiary),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Full Name'),
                TextFormField(
                  key: const Key('add_patient_full_name_field'),
                  controller: fullNameController,
                  decoration: const InputDecoration(hintText: 'Full Name'),
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                const Text('Date of Birth'),
                TextFormField(
                  key: const Key('add_patient_dob_field'),
                  controller: dateOfBirthController,
                  decoration: const InputDecoration(hintText: 'Date of Birth'),
                  readOnly: true,
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      dateOfBirthController.text = pickedDate
                          .toIso8601String()
                          .split('T')[0];
                    }
                  },
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                const Text('Email'),
                TextFormField(
                  key: const Key('add_patient_email_field'),
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Required';
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Address'),
                TextFormField(
                  key: const Key('add_patient_address_field'),
                  controller: addressController,
                  decoration: const InputDecoration(hintText: 'Address'),
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                const Text('Phone Number'),
                TextFormField(
                  key: const Key('add_patient_phone_field'),
                  controller: phoneNumberController,
                  decoration: const InputDecoration(hintText: 'Phone Number'),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Required';
                    if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(val)) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Gender'),
                DropdownButtonFormField<String>(
                  key: const Key('add_patient_gender_dropdown'),
                  value: selectedGender,
                  decoration: const InputDecoration(hintText: 'Select Gender'),
                  items: ['Male', 'Female', 'Other']
                      .map(
                        (gender) =>
                            DropdownMenuItem(value: gender, child: Text(gender)),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 24),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator()),
                if (state.error != null)
                  Text(state.error!, style: const TextStyle(color: Colors.red)),
                Center(
                  child: ElevatedButton(
                    key: const Key('add_patient_submit_button'),
                    onPressed: state.isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 39, 81, 195),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Add patient'),
                  ),
                ),
                Center(child: const BackToHome(roleId: 5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

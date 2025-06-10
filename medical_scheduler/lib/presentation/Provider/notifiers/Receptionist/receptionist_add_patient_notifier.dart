import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/presentation/Provider/states/Receptionist/receptionist_add_patient_state.dart';
import 'package:medical_scheduler/presentation/events/Receptionist/receptionist_add_patient_events.dart';
import 'package:medical_scheduler/domain/entities/response/patient.dart';
import 'package:medical_scheduler/Application/Usecases/patient/add_patient.dart';
import 'package:medical_scheduler/domain/entities/response/role.dart';

class ReceptionistAddPatientNotifier extends StateNotifier<ReceptionistAddPatientState> {
  final CreatePatient createPatientUseCase;
  ReceptionistAddPatientNotifier(this.createPatientUseCase)
      : super(ReceptionistAddPatientState());

  Future<void> onEvent(AddPatientEvent event) async {
    if (event is SubmitPatientForm) {
      await _submitForm(event);
    }
  }

  Future<void> _submitForm(SubmitPatientForm event) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      // Split full name into first and last name
      String firstName = event.fullName.trim();
      String lastName = '';
      if (event.fullName.trim().contains(' ')) {
        final parts = event.fullName.trim().split(' ');
        firstName = parts.first;
        lastName = parts.sublist(1).join(' ');
      }

      // Create the Role object for the patient
      final patientRole = Role(roleId: 3, name: 'Patient');

      final patient = Patient(
        patientId: 0,
        username: '',
        email: event.email,
        password: '',
        createdAt: '',
        updatedAt: '',
        role: patientRole,
        firstName: firstName,
        lastName: lastName,
        address: event.address,
        phoneNumber: event.phoneNumber,
        gender: 'Male',
        dateOfBirth: event.dateOfBirth,
        registeredBy: null,
      );
      await createPatientUseCase(patient);
      state = state.copyWith(isLoading: false, isSuccess: true, patient: patient);
    } catch (e) {
      state = state.copyWith(isLoading: false, isSuccess: false, error: e.toString());
    }
  }
} 
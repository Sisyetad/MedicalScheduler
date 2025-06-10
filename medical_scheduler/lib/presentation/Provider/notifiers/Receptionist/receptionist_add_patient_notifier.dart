import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/data/model/RequestModel/patient_request_model.dart';
import 'package:medical_scheduler/presentation/Provider/states/Receptionist/receptionist_add_patient_state.dart';
import 'package:medical_scheduler/presentation/events/Receptionist/receptionist_add_patient_events.dart';
import 'package:medical_scheduler/Application/Usecases/patient/add_patient.dart';

class ReceptionistAddPatientNotifier
    extends StateNotifier<ReceptionistAddPatientState> {
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
      String firstName = event.fullName.trim();
      String lastName = '';
      if (event.fullName.trim().contains(' ')) {
        final parts = event.fullName.trim().split(' ');
        firstName = parts.first;
        lastName = parts.sublist(1).join(' ');
      }

      final patient = PatientRequestModel(
        email: event.email,
        firstName: firstName,
        lastName: lastName,
        address: event.address,
        gender: event.gender,
        dateofBirth: event.dateOfBirth,
        phone: event.phoneNumber,
        registeredby: event.registeredBy,
      );
      await createPatientUseCase(patient);
      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        patient: patient,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: e.toString(),
      );
    }
  }
}

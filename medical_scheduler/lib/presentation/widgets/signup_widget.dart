import 'package:flutter/material.dart';
import 'package:medical_scheduler/presentation/pages/doctor_queue_page.dart';
import 'package:medical_scheduler/presentation/widgets/dropDown.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _BuildsignupState();
}

class _BuildsignupState extends State<SignupWidget> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPw = TextEditingController();
  TextEditingController controllerCP = TextEditingController();
  String confirmedEmail = '';

  @override
  void dispose() {
    controllerName.dispose();
    controllerEmail.dispose();
    controllerPw.dispose();
    controllerCP.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            controller: controllerName,
            decoration: InputDecoration(labelText: 'Name'),
          ),
        ),
        RoleDropdown(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            controller: controllerEmail,
            decoration: InputDecoration(labelText: 'Email'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            controller: controllerPw,
            decoration: InputDecoration(labelText: 'Enter Password'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            controller: controllerCP,
            decoration: InputDecoration(labelText: 'Confirm Password'),
          ),
        ),

        SizedBox(height: 20),
        // Add more fields as needed
        Center(
          child: OutlinedButton(
            onPressed: () {
              onSignUpPressed();
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: const Color.fromARGB(255, 39, 81, 195),
            ),

            child: Center(
              child: Text(
                "SignUp",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onSignUpPressed() {
    if (confirmedEmail == controllerEmail) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DoctorPage()),
      );
    }
  }
}

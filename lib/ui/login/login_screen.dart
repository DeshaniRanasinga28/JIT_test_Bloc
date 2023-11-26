import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jit_transfer_app/bloc/user_block.dart';
import 'package:jit_transfer_app/models/user_model.dart';

import '../../common_widget/custom_elevated_button.dart';
import '../../common_widget/custom_text_form_field.dart';
import '../../const/string_const.dart';
import 'user_registration_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  StringConst.welcomeLabel,
                  style: TextStyle(
                      fontSize: 42.0,
                      fontFamily: "Lora",
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  controller: _usernameController,
                  labelText: StringConst.usernameLabel,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  controller: _passwordController,
                  labelText: StringConst.passwordLabel,
                ),
                const SizedBox(
                  height: 40.0,
                ),
                CustomElevatedButton(
                  onPressed: () => userLogin(context),
                  label: StringConst.loginLabel,
                ),
                const SizedBox(
                  height: 40.0,
                ),
                InkWell(
                  onTap: () => navigateToUserRegistration(context),
                  child: const Text(
                    StringConst.registrationLabel,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14.0,
                        fontFamily: "Lora",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  userLogin(BuildContext context){
    if(_formKey.currentState?.validate() ?? false){
      final username = _usernameController.text;
      final password = _passwordController.text;
      final user = UserModel(username: username, password: password);
      BlocProvider.of<UserBlock>(context).login(user);
    }
  }


  navigateToUserRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserRegistrationScreen()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jit_transfer_app/bloc/user_block.dart';
import 'package:jit_transfer_app/models/user_model.dart';
import 'package:jit_transfer_app/ui/splash/splash_screen_wrapper.dart';

import '../../bloc/user_state.dart';
import '../../common_widget/custom_elevated_button.dart';
import '../../common_widget/custom_text_form_field.dart';
import '../../const/color_const.dart';
import '../../const/string_const.dart';
import 'login_screen.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBlock>(context).initializeDatabase();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConst.black,
          title: const Text(
            StringConst.userRegistrationLabel,
            style: TextStyle(color: ColorConst.white),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: ColorConst.white,
            ),
            onPressed: () {
              navigateToLogin(context);
            },
          ),
        ),
        body: BlocConsumer<UserBlock, UserState>(
          listener: (context, state) {
            if (state is UserLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(StringConst.userRegisteredSuccessfullyLabel),
                  duration: Duration(seconds: 2),
                ),
              );
            } else if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40.0,
                      ),
                      CustomTextFormField(
                        controller: usernameController,
                        labelText: StringConst.usernameLabel,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        labelText: StringConst.passwordLabel,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      CustomElevatedButton(
                        onPressed: () => _submitForm(context),
                        label: StringConst.saveLabel,
                      ),
                    ],
                  ),
                )
              );
            }
          },
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final username = usernameController.text;
      final password = passwordController.text;
      final user = UserModel(username: username, password: password);
      BlocProvider.of<UserBlock>(context).registerUser(user);
      navigateToUserRegistration(context);
    }
  }

  navigateToUserRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreenWrapper()),
    );
  }

  navigateToLogin(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}
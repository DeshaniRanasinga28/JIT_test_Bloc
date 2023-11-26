import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jit_transfer_app/const/color_const.dart';

import '../../bloc/user_block.dart';
import '../../bloc/user_state.dart';
import '../../common_widget/custom_snack_bar.dart';
import '../../const/string_const.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';

class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBlock>(context).initializeDatabase();
    return BlocBuilder<UserBlock, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return  const HomeScreen();
        } else if (state is UserInitial) {
          return LoginScreen();
        } else if(state is UserError){
          CustomSnackBar.showSnackBar(StringConst.invalidCredentialsError);
          return LoginScreen();
        }else{
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: ColorConst.white,
              color: ColorConst.blue,
            ),
          );
        }
      },
    );
  }
}

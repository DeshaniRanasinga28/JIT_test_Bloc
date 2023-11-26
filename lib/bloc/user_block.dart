import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';
import '../db_helper/user_db_helper.dart';
import 'user_state.dart';

class UserBlock extends Cubit<UserState> {
  final UserDBHelper userRepository = UserDBHelper();

  UserBlock() : super(UserInitial());

  Future<void> initializeDatabase() async {
    await userRepository.initDatabase();
  }

  Future<void> registerUser(UserModel user) async {
    try {
      emit(UserLoading());
      await userRepository.insertUser(user);
      final users = await userRepository.getUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Error registering user'));
    }
  }

  Future<void> login(UserModel user) async {
    try {
      emit(UserLoading());
      final users = await userRepository.getUsers();
      final authenticatedUser = users.firstWhere(
            (u) => u.username == user.username && u.password == user.password,
        orElse: () => throw Exception('Invalid credentials'),
      );
      emit(UserLoaded([authenticatedUser]));
    } catch (e) {
      emit(UserError('Error logging in: $e'));
    }
  }

  Future<void> logout() async {
    emit(UserInitial());
  }

}

import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/bloc/auth_state.dart';
import './auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield AuthLoading();
      try {
        final response = await http.post(
          Uri.parse("http://localhost:8080/login"),
          body: {'email': event.email, 'password': event.password},
        );
        if (response.statusCode == 200) {
          // Parse token from response
          final Map<String, dynamic> data = jsonDecode(response.body);
          final String? token = data['token'];

          // Save token locally ______________________________
          if (token != null) {
            await _saveToken(token);
          }

          yield AuthSuccess();
        } else {
          yield AuthFailure("Invalid email or password. Please try again.");
        }
      } catch (error) {
        yield AuthFailure("Error occurred: $error");
      }
    } else if (event is RegisterEvent) {
      yield AuthLoading();
      try {
        final response = await http.post(
          Uri.parse("http://localhost:8080/register"),
          body: {'email': event.email, 'password': event.password},
        );
        if (response.statusCode == 200) {
          // Registration successful________________
          yield AuthSuccess();
        } else {
          yield AuthFailure("Registration failed. Please try again.");
        }
      } catch (error) {
        yield AuthFailure("Error occurred: $error");
      }
    }
  }
}

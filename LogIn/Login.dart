import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/Registration/Registration.dart';
import '../Buttons/Buttons.dart';
import '../HomeScreen.dart';
import '../TextFields/TextFields.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);
  static const String id = 'LogIn';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: LogInForm(),
    );
  }
}

class LogInForm extends StatefulWidget {
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  void _login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    _authBloc.add(LoginEvent(email, password));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamed(context, HomeScreen.id);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome! Please Enter\n your email and password',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              EmailTextField(
                controller: emailController,
                hintText: 'Enter your email address',
              ),
              const SizedBox(height: 10),
              PasswordTextField(
                controller: passwordController,
                hintText: 'Enter your password',
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Log In',
                onPressed: _login,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Registration.id);
                },
                child: Text('Sign Up?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidaya/core/config/assets/vector/app_vector.dart';
import 'package:hidaya/data/model/auth/create_user_req.dart';
import 'package:hidaya/domain/usecase/auth/signup_usecase.dart';
import 'package:hidaya/presentation/auth/pages/sigin.dart';
import 'package:hidaya/presentation/auth/pages/sign_up_with_phone.dart';
import 'package:hidaya/service_locator.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              SizedBox(height: 110, child: SvgPicture.asset(Appvector.quran)),
              SizedBox(height: 20),
              Text("Sign up",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Color.fromARGB(255, 250, 253, 234),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          filled: true,
                          fillColor: Color.fromARGB(255, 250, 253, 234),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          fillColor: Color.fromARGB(255, 250, 253, 234),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            );
                          },
                        );

                        var result = await sl<SignupUsecase>().call(
                          params: CreateUserReq(
                            fullname: _usernameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );

                        Navigator.pop(context);

                        result.fold(
                          (ifLeft) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(ifLeft)));
                          },
                          (ifRight) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return SignInScreen();
                              },
                            ));
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: const Size(double.infinity, 48),
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SignInScreen();
                          },
                        ));
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Already have an Account? ",
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                          children: [
                            TextSpan(
                              text: "Sign in",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SignUpWithPhone();
                    },
                  ));
                },
                child: Text('Sign up with Phone number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

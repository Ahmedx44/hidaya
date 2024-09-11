import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidaya/core/config/assets/vector/app_vector.dart';
import 'package:hidaya/data/model/auth/signin_user_req.dart';
import 'package:hidaya/domain/usecase/auth/siginin_usecase.dart';
import 'package:hidaya/presentation/Page/auth/signup.dart';
import 'package:hidaya/service_locator.dart';

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          color: Theme.of(context).colorScheme.surface,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.1),
                    SizedBox(
                        height: 110, child: SvgPicture.asset(Appvector.quran)),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Text("Sign In",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                    SizedBox(height: constraints.maxHeight * 0.05),
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
                                  horizontal: 16.0 * 1.5, vertical: 16.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (phone) {
                              // Save it
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                filled: true,
                                fillColor: Color.fromARGB(255, 250, 253, 234),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0 * 1.5, vertical: 16.0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                              ),
                              onSaved: (passaword) {
                                // Save it
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              print(_emailController.text);

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  );
                                },
                              );

                              var result = await sl<SigininUsecase>().call(
                                  params: SigninUserReq(
                                      email: _emailController.text,
                                      password: _passwordController.text));

                              Navigator.pop(context);

                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return SignInScreen();
                                },
                              ));

                              result.fold((ifLeft) {
                                var snackbar = SnackBar(content: Text(ifLeft));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              }, (ifRight) {
                                var snackbar = SnackBar(content: Text(ifRight));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 48),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text(
                              "Sign in",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return SignUpScreen();
                                },
                              ));
                            },
                            child: Text.rich(
                              TextSpan(
                                text: "Don’t have an account? ",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ],
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.64),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

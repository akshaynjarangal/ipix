import 'package:akshaytest/src/constants/constants.dart';
import 'package:akshaytest/src/logic/authentication/authentication_bloc.dart';
import 'package:akshaytest/src/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    'https://b.zmtcdn.com/web_assets/81f3ff974d82520780078ba1cfbd453a1583259680.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Spacer(),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Login \nyour account",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w600))),
                      const Spacer(),
                      setHeight(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter username';
                          } else if (!isValidEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: loginFieldDecoration(hintText: 'Username'),
                      ),
                      setHeight(height: 16),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter password';
                          } else if (value.trim().length < 6) {
                            return 'Password length must be greater than 6';
                          }

                          return null;
                        },
                        obscureText: true,
                        decoration: loginFieldDecoration(hintText: 'Password'),
                      ),
                      setHeight(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                  activeColor: AppColors.amber,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  side: const BorderSide(width: 0.7),
                                  value: false,
                                  onChanged: (val) {}),
                              const Text('Remember me')
                            ],
                          ),
                          setWidth(width: 16),
                          Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Forgot password?',
                                      style: TextStyle(color: AppColors.black),
                                    ))),
                          )
                        ],
                      ),
                      const Spacer(),
                      BlocConsumer<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                          if(state is AuthenticationSuccess){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Home()), (route) => false);
                          }

                        },
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CupertinoButton(
                                disabledColor: AppColors.amber,
                                  color: AppColors.amber,
                                  onPressed:state is AuthenticationLoading?null:() {
                                    if (formKey.currentState!.validate()) {
                                      context.read<AuthenticationBloc>().add(
                                          UserLogin(
                                              username: usernameController.text,
                                              password:
                                                  passwordController.text));
                                    }
                                  },
                                  child:state is AuthenticationLoading?Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.white)),
                                  ): const Text("Login")),
                            ],
                          );
                        },
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration loginFieldDecoration({required String hintText}) {
    return InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        hintText: hintText,
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: AppColors.amber)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: AppColors.amber)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: CupertinoColors.systemRed)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: AppColors.amber)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: AppColors.amber)));
  }

  bool isValidEmail(String email) {
    // Regular expression for email validation
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_snack_bar.dart';
import 'package:product_pulse/core/widgets/custom_text_field.dart';
import 'package:product_pulse/features/registretion_feature/presentation/manager/login_cubit/login_cubit.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/register_view.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/create_or_have_account_buttom.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_divider.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_regisretion_buttom.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_social_media_row.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  String? email, password;
  bool isAsync = false;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  bool checkUserId = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return ModalProgressHUD(
      inAsyncCall: isAsync,
      color: const Color(0xff1F41BB).withOpacity(0.1),
      progressIndicator: const CircularProgressIndicator(
        color: Color(0xff1F41BB),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              isAsync = false;
              setState(() {});
            } else if (state is LoginFailuer) {
              isAsync = false;
              setState(() {});
              CustomSnackBar()
                  .showSnackBar(context: context, msg: state.message);
            } else if (state is LoginLoading) {
              isAsync = true;
              setState(() {});
            } else if (state is LoginEndLoading) {
              isAsync = false;
              setState(() {});
            } else {
              isAsync = false;
              setState(() {});
            }
          },
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: autovalidateMode,
              key: _formKey,
              child: Column(
                children: [
                  SafeArea(
                    child: SizedBox(
                      height: height * 0.05,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Login Here',
                      style: Style.font24Bold(context).copyWith(
                        color: const Color(0xff1F41BB),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    'Welcome back you\'ve',
                    style: Style.font20SemiBold(context).copyWith(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'been missed',
                    style: Style.font20SemiBold(context).copyWith(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  CustomTextField(
                    hintTitle: 'Email',
                    obscure: false,
                    onChanged: (value) {
                      email = value;
                    },
                    isPassword: false,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CustomTextField(
                    hintTitle: 'Password',
                    obscure: true,
                    onChanged: (value) {
                      password = value;
                    },
                    isPassword: true,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () async {
                        if (email == null || email!.isEmpty) {
                          CustomSnackBar().showSnackBar(
                              context: context,
                              msg: 'Please enter an email address.');
                          return;
                        }
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email!);
                          CustomSnackBar().showSnackBar(
                              // ignore: use_build_context_synchronously
                              context: context,
                              msg: 'Password reset email sent.');
                        } on FirebaseAuthException catch (e) {
                          switch (e.code) {
                            case 'invalid-email':
                              CustomSnackBar().showSnackBar(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  msg: 'Invalid email address format.');
                              break;
                            case 'user-not-found':
                              CustomSnackBar().showSnackBar(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  msg: 'No user found for this email.');
                              break;
                            case 'network-request-failed':
                              CustomSnackBar().showSnackBar(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  msg:
                                      'Network error. Please try again later.');
                              break;
                            default:
                              CustomSnackBar().showSnackBar(
                                  context: context,
                                  msg:
                                      'An unexpected error occurred. Please try again later.');
                          }
                        } catch (e) {
                          CustomSnackBar().showSnackBar(
                              // ignore: use_build_context_synchronously
                              context: context,
                              msg:
                                  'An unexpected error occurred. Please try again later.');
                        }
                      },
                      child: Text(
                        'Forget Your Password?',
                        style: Style.font18SemiBold(context)
                            .copyWith(color: const Color(0XFF1F41BB)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CustomRegistretionButtom(
                    title: 'Sign in',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await BlocProvider.of<LoginCubit>(context).loginUser(
                            email: email!,
                            password: password!,
                            context: context);
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CheckAccountOrCreateNewButtom(
                    title: 'Create new account',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return const RegisterView();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  const CustomDivider(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  const CustomSocailMediaConnectRow(),
                  SizedBox(
                    height: height * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

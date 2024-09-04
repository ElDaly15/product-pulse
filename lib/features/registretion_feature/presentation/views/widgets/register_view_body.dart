import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_snack_bar.dart';
import 'package:product_pulse/core/widgets/custom_text_register_field.dart';
import 'package:product_pulse/features/registretion_feature/presentation/manager/register_cubit/register_cubit_cubit.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/login_view.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/start_data_view.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/create_or_have_account_buttom.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_divider.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_regisretion_buttom.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_social_media_row.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final _formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? email;
  String? password;
  String? confirmPassword;
  bool isAsync = false;

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
        child: BlocListener<RegisterCubitCubit, RegisterCubitState>(
          listener: (context, state) {
            if (state is RegisterCubitSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return const StartDataView();
                  },
                ),
              );
            } else if (state is RegisterCubitFailuer) {
              CustomSnackBar()
                  .showSnackBar(context: context, msg: state.errorMsg);
              isAsync = false;
              setState(() {});
            } else if (state is RegisterCubitLoading) {
              isAsync = true;
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
                      'Create Account',
                      style: Style.font24Bold(context).copyWith(
                        color: const Color(0xff1F41BB),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    'Create an account so you can explore all the existing products',
                    style: Style.font20SemiBold(context).copyWith(
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  CustomTextFieldForRegistration(
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
                  CustomTextFieldForRegistration(
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
                  CustomTextFieldForRegistration(
                    hintTitle: 'Confirm Password',
                    obscure: true,
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                    isPassword: true,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CustomRegistretionButtom(
                    title: 'Sign Up',
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          password == confirmPassword) {
                        await BlocProvider.of<RegisterCubitCubit>(context)
                            .registerNewUser(
                                email: email!, password: password!);
                      } else {
                        if (password != confirmPassword) {
                          CustomSnackBar().showSnackBar(
                              context: context, msg: 'Passwords don\'t match');
                        }
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CheckAccountOrCreateNewButtom(
                    title: 'Already Have an Account?',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return const LoginView();
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

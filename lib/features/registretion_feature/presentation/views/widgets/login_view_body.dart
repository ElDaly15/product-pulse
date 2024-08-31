import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_text_field.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/create_or_have_account_buttom.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_divider.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_regisretion_buttom.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_social_media_row.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: SingleChildScrollView(
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
              onChanged: (value) {},
              isPassword: false,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            CustomTextField(
              hintTitle: 'Password',
              obscure: false,
              onChanged: (value) {},
              isPassword: true,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forget Your Password?',
                style: Style.font18SemiBold(context)
                    .copyWith(color: const Color(0XFF1F41BB)),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            CustomRegistretionButtom(
              title: 'Sign in',
              onPressed: () {},
            ),
            SizedBox(
              height: height * 0.03,
            ),
            CheckAccountOrCreateNewButtom(
              title: 'Create new account',
              onPressed: () {},
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
    );
  }
}

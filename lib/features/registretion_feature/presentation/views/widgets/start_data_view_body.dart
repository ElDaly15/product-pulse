import 'package:flutter/material.dart';

import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_snack_bar.dart';
import 'package:product_pulse/core/widgets/custom_text_field.dart';
import 'package:product_pulse/features/post_feature/presentation/views/main_view.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/birth_day_pick.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_circle_avatar_stack.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_menu_drawer_for_product_select.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/select_male_or_female.dart';

// ignore: must_be_immutable
class StartDataViewBody extends StatefulWidget {
  StartDataViewBody({super.key});
  String? selectedProduct;
  String? gender;

  @override
  State<StartDataViewBody> createState() => _StartDataViewBodyState();
}

class _StartDataViewBodyState extends State<StartDataViewBody>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKeyData = GlobalKey<FormState>();

  AutovalidateMode autovalidateModeData = AutovalidateMode.disabled;

  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 22.0,
        ),
        child: Form(
          autovalidateMode: autovalidateModeData,
          key: formKeyData,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SafeArea(
                child: SizedBox(
                  height: 30,
                ),
              ),
              Center(
                child: Text(
                  'Initialize Your Account',
                  style: Style.font22Bold(context).copyWith(
                    color: const Color(0xff1F41BB),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Start To Initialize Your Data For The First Time',
                  style:
                      Style.font18Medium(context).copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomStartDataImageStack(),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        hintTitle: 'First Name',
                        obscure: false,
                        onChanged: (value) {},
                        isPassword: false),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: CustomTextField(
                        hintTitle: 'Last Name',
                        obscure: false,
                        onChanged: (value) {},
                        isPassword: false),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Select Your Real Birth date',
                style: Style.font18SemiBold(context)
                    .copyWith(color: const Color(0xff1F41BB)),
              ),
              const SizedBox(
                height: 15,
              ),
              BirthDayPick(
                onChangedDay: (value) {},
                onChangedMonth: (value) {},
                onChangedYear: (value) {},
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Select Your Gender',
                style: Style.font18SemiBold(context)
                    .copyWith(color: const Color(0xff1F41BB)),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomDrawerForMaleOrFemale(
                onChanged: (value) {
                  widget.gender = value;

                  setState(() {});
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Select Your Favourit Products You Bought Last Year',
                style: Style.font18SemiBold(context)
                    .copyWith(color: const Color(0xff1F41BB)),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomMenuDrawer(
                onChanged: (value) {
                  widget.selectedProduct = value;

                  setState(() {});
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1F41BB),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      if (formKeyData.currentState!.validate() &&
                          widget.selectedProduct != null &&
                          widget.gender != null) {
                        formKeyData.currentState!.save();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const MainView();
                        }));
                      } else {
                        autovalidateModeData = AutovalidateMode.always;
                        setState(() {});
                        if (widget.selectedProduct == null &&
                            widget.gender == null) {
                          CustomSnackBar().showSnackBar(
                              context: context,
                              msg:
                                  'Select Product From Products List and Select Your Gender');
                        } else {
                          if (widget.selectedProduct == null) {
                            CustomSnackBar().showSnackBar(
                                context: context,
                                msg: 'Select Product From Products List');
                          }
                          if (widget.gender == null) {
                            CustomSnackBar().showSnackBar(
                                context: context, msg: 'Select Your Gender');
                          }
                        }
                      }
                    },
                    child: Text(
                      'Confirm',
                      style: Style.font18SemiBold(context)
                          .copyWith(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

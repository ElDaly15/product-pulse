import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:product_pulse/core/utils/images.dart';

import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_snack_bar.dart';
import 'package:product_pulse/core/widgets/custom_text_field.dart';
import 'package:product_pulse/core/widgets/no_internet_connecition.dart';
import 'package:product_pulse/features/post_feature/presentation/views/main_view.dart';
import 'package:product_pulse/features/registretion_feature/presentation/manager/add_user_data_cubit/add_user_data_cubit.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/birth_day_pick.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_circle_avatar_stack.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_menu_drawer_for_product_select.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/select_male_or_female.dart';

// ignore: must_be_immutable
class StartDataViewBody extends StatefulWidget {
  StartDataViewBody({super.key});
  String? selectedProduct;
  String? gender;
  String? firstName, lastName;
  String? year, month, day;

  bool isAsync = false;
  String? image;

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
    return BlocListener<AddUserDataCubit, AddUserDataState>(
      listener: (context, state) {
        if (state is AddUserDataSuccess) {
          widget.isAsync = false;
          setState(() {});
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainView()),
              (route) => false);
        } else if (state is AddUserDataFailuer) {
          widget.isAsync = false;
          setState(() {});
          CustomSnackBar().showSnackBar(
              context: context, msg: 'Something went wrong , Try Again .');
        }
        if (state is AddUserDataLoading) {
          widget.isAsync = true;
          setState(() {});
        }
      },
      child: OfflineBuilder(
        connectivityBuilder: (context, value, child) {
          final bool connection = value.first != ConnectivityResult.none;
          return connection ? child : const NoconnectionScreen();
        },
        child: ModalProgressHUD(
          inAsyncCall: widget.isAsync,
          color: const Color(0xff1F41BB).withOpacity(0.1),
          progressIndicator: const CircularProgressIndicator(
            color: Color(0xff1F41BB),
          ),
          child: SingleChildScrollView(
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
                        style: Style.font18Medium(context)
                            .copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomStartDataImageStack(
                      status: (status) {
                        widget.isAsync = status;
                        setState(() {});
                      },
                      onSubmitImage: (image) {
                        widget.image = image;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                              hintTitle: 'First Name',
                              obscure: false,
                              onChanged: (value) {
                                widget.firstName = value;
                              },
                              isPassword: false),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: CustomTextField(
                              hintTitle: 'Last Name',
                              obscure: false,
                              onChanged: (value) {
                                widget.lastName = value;
                              },
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
                      onChangedDay: (value) {
                        widget.day = value;
                      },
                      onChangedMonth: (value) {
                        widget.month = value;
                      },
                      onChangedYear: (value) {
                        widget.year = value;
                      },
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
                          onPressed: () async {
                            if (formKeyData.currentState!.validate() &&
                                widget.selectedProduct != null &&
                                widget.gender != null) {
                              formKeyData.currentState!.save();

                              await BlocProvider.of<AddUserDataCubit>(context)
                                  .addUserData(
                                      firstName: widget.firstName!,
                                      lastName: widget.lastName!,
                                      image: widget.image ??
                                          Assets.imageOfStartUser,
                                      birthDay: widget.day!,
                                      birthMonth: widget.month!,
                                      birthYear: widget.year!,
                                      email: FirebaseAuth
                                          .instance.currentUser!.email!,
                                      gender: widget.gender!,
                                      bestProduct: widget.selectedProduct!,
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid);
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
                                      context: context,
                                      msg: 'Select Your Gender');
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
          ),
        ),
      ),
    );
  }
}

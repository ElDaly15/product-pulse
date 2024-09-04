import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_create_text_field.dart';
import 'package:product_pulse/core/widgets/custom_snack_bar.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_menu_drawer_for_product_select.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final GlobalKey<FormState> formKeyPost = GlobalKey<FormState>();

  AutovalidateMode autovalidateModeDataPost = AutovalidateMode.disabled;

  String? url;
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Form(
        key: formKeyPost,
        autovalidateMode: autovalidateModeDataPost,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Text(
                  'Create Your Post',
                  style: Style.font18SemiBold(context),
                ),
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xffffffff),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      if (formKeyPost.currentState!.validate() &&
                          url != null &&
                          selectedValue != null) {
                        formKeyPost.currentState!.save();
                      } else {
                        autovalidateModeDataPost = AutovalidateMode.always;
                        setState(() {});
                        if (url == null && selectedValue == null) {
                          CustomSnackBar().showSnackBar(
                              context: context,
                              msg:
                                  'Select Image To Your Post and Select Category');
                        } else {
                          if (url == null) {
                            CustomSnackBar().showSnackBar(
                                context: context,
                                msg: 'Select Image To Your Post');
                          }
                          if (selectedValue == null) {
                            CustomSnackBar().showSnackBar(
                                context: context,
                                msg: 'Select Category To Your Post');
                          }
                        }
                      }
                    },
                    child: Text(
                      'Post',
                      style: Style.font18SemiBold(context)
                          .copyWith(color: const Color(0xff1F41BB)),
                    )),
              ],
            ),
            CustomMenuDrawer(onChanged: (value) {
              selectedValue = value;
            }),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: CustomCreateTextField(
                  hintTitle: 'Create Your Post ... ',
                  obscure: false,
                  onChanged: (value) {},
                  isPassword: false),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.photo,
                      color: Colors.green,
                    ),
                    title: Text(
                      'Photo',
                      style: Style.font18SemiBold(context),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

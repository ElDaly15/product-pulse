import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_create_text_field.dart';
import 'package:product_pulse/core/widgets/custom_snack_bar.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final GlobalKey<FormState> formKeyPost = GlobalKey<FormState>();

  AutovalidateMode autovalidateModeDataPost = AutovalidateMode.disabled;

  String? url;

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
            Text(
              'Create Your Post',
              style: Style.font18SemiBold(context),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomCreateTextField(
                hintTitle: 'Create Your Post ... ',
                obscure: false,
                onChanged: (value) {},
                isPassword: false),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            ListTile(
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
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1F41BB),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () {
                    if (formKeyPost.currentState!.validate() && url != null) {
                      formKeyPost.currentState!.save();
                    } else {
                      autovalidateModeDataPost = AutovalidateMode.always;
                      setState(() {});
                      if (url == null) {
                        CustomSnackBar().showSnackBar(
                            context: context, msg: 'Select Image To Your Post');
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
    );
  }
}

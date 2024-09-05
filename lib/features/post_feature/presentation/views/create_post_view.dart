// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:path/path.dart' as path;
import 'package:product_pulse/core/widgets/custom_create_text_field.dart';
import 'package:product_pulse/core/widgets/custom_snack_bar.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/add_post/add_post_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_user_data/get_user_data_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/main_view.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_menu_drawer_for_product_select.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final GlobalKey<FormState> formKeyPost = GlobalKey<FormState>();

  AutovalidateMode autovalidateModeDataPost = AutovalidateMode.disabled;
  File? file;
  String? url;
  String? selectedValue;
  bool isAsync = false;

  UserDataModel? user;
  String? postTitle;

  Future<void> getImage({required ImageSource source}) async {
    setState(() {
      isAsync = true;
    });

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? imageCamera = await picker.pickImage(source: source);

      if (imageCamera != null) {
        file = File(imageCamera.path);
        var imageName = path.basename(imageCamera.path);
        var refStorage = FirebaseStorage.instance.ref(imageName);
        await refStorage.putFile(file!);
        url = await refStorage.getDownloadURL();
      }
    } catch (e) {
      // Handle error and show a message
      CustomSnackBar().showSnackBar(
        context: context,
        msg: 'Error while uploading image',
      );
    } finally {
      setState(() {
        isAsync = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    await BlocProvider.of<GetUserDataCubit>(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetUserDataCubit, GetUserDataState>(
      listener: (context, state) {
        if (state is GetUserDataLoading) {
          setState(() {
            isAsync = true;
          });
        } else if (state is GetUserDataSuccess) {
          setState(() {
            user = state.userDataModel;
            isAsync = false;
          });
        } else if (state is GetUserDataFailuer) {
          setState(() {
            isAsync = false;
          });
        }
      },
      child: BlocListener<AddPostCubit, AddPostState>(
        listener: (context, postState) {
          if (postState is AddPostSuccess) {
            setState(() {
              isAsync = false;
            });
            CustomSnackBar().showSnackBar(
                context: context, msg: 'Post Now In Our App , Thank You');
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return const MainView();
            }));
          } else if (postState is AddPostFailuer) {
            setState(() {
              isAsync = false;
            });
            CustomSnackBar().showSnackBar(
                context: context,
                msg: 'An Error While Posting , Try Again Later');
          } else if (postState is AddPostLoading) {
            setState(() {
              isAsync = true;
            });
          }
        },
        child: ModalProgressHUD(
          inAsyncCall: isAsync, // Should reflect the state change
          color: const Color(0xff1F41BB).withOpacity(0.1),
          progressIndicator: const CircularProgressIndicator(
            color: Color(0xff1F41BB),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Form(
              key: formKeyPost,
              autovalidateMode: autovalidateModeDataPost,
              child: ListView(
                children: [
                  const SizedBox(height: 20),
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
                          onPressed: () async {
                            if (formKeyPost.currentState!.validate() &&
                                url != null &&
                                selectedValue != null) {
                              formKeyPost.currentState!.save();
                              setState(() {
                                isAsync = true;
                              });

                              await BlocProvider.of<AddPostCubit>(context)
                                  .addPost(
                                      firstName: user!.firstName,
                                      lastName: user!.lastName,
                                      title: postTitle!,
                                      category: selectedValue!,
                                      image: url!,
                                      userImage: user!.image,
                                      userId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      userEmail: FirebaseAuth
                                          .instance.currentUser!.email!);
                            } else {
                              autovalidateModeDataPost =
                                  AutovalidateMode.always;
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomMenuDrawer(onChanged: (value) {
                      selectedValue = value;
                    }),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: CustomCreateTextField(
                        hintTitle: 'Create Your Post ... ',
                        obscure: false,
                        onChanged: (value) {
                          postTitle = value;
                        },
                        isPassword: false),
                  ),
                  const SizedBox(height: 10),
                  file == null
                      ? const SizedBox()
                      : SizedBox(
                          height: 350,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: FileImage(file!), fit: BoxFit.cover),
                            ),
                          ),
                        ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Column(
                      children: [
                        const Divider(thickness: 1, color: Colors.grey),
                        ListTile(
                          onTap: () {
                            getImage(source: ImageSource.gallery);
                          },
                          leading: const Icon(
                            Icons.photo,
                            color: Colors.green,
                          ),
                          title: Text(
                            'Photo',
                            style: Style.font18SemiBold(context),
                          ),
                        ),
                        const Divider(thickness: 1, color: Colors.grey),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

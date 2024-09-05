import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:product_pulse/core/controller/depency_injection.dart';
import 'package:product_pulse/core/widgets/waiting_view.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/add_comment/add_comment_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/add_post/add_post_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/delete_post/delete_post_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_comments/get_comments_cubit.dart';

import 'package:product_pulse/features/post_feature/presentation/manager/get_posts/get_posts_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_reactions/get_reactions_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_ur_posts/get_ur_posts_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_user_data/get_user_data_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/reaction_handle/reaction_handle_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/main_view.dart';
import 'package:product_pulse/features/registretion_feature/presentation/manager/add_user_data_cubit/add_user_data_cubit.dart';
import 'package:product_pulse/features/registretion_feature/presentation/manager/check_user_id/check_user_id_cubit.dart';
import 'package:product_pulse/features/registretion_feature/presentation/manager/google_auth/google_auth_cubit.dart';
import 'package:product_pulse/features/registretion_feature/presentation/manager/login_cubit/login_cubit.dart';
import 'package:product_pulse/features/registretion_feature/presentation/manager/register_cubit/register_cubit_cubit.dart';

import 'package:product_pulse/features/registretion_feature/presentation/views/start_app_view.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/start_data_view.dart';
import 'package:product_pulse/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyInjection.init();
  runApp(DevicePreview(
      enabled: false, builder: (context) => const ProductPulseApp()));
}

class ProductPulseApp extends StatelessWidget {
  const ProductPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterCubitCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => CheckUserIdCubit()
            ..checkUserId(FirebaseAuth.instance.currentUser!.uid),
        ),
        BlocProvider(
          create: (context) => AddUserDataCubit(),
        ),
        BlocProvider(
          create: (context) => GoogleAuthCubit(),
        ),
        BlocProvider(
          create: (context) => GetUserDataCubit()..getUserData(),
        ),
        BlocProvider(
          create: (context) => AddPostCubit(),
        ),
        BlocProvider(
          create: (context) => GetPostsCubit(),
        ),
        BlocProvider(
          create: (context) => ReactionHandleCubit(),
        ),
        BlocProvider(
          create: (context) => GetReactionsCubit(),
        ),
        BlocProvider(
          create: (context) => AddCommentCubit(),
        ),
        BlocProvider(
          create: (context) => GetCommentsCubit(),
        ),
        BlocProvider(
          create: (context) => DeletePostCubit(),
        ),
        BlocProvider(
          create: (context) => GetUrPostsCubit(),
        ),
      ],
      child: GetMaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        home: FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified
            ? BlocListener<CheckUserIdCubit, CheckUserIdState>(
                listener: (context, state) {
                  if (state is CheckUserIdSuccess) {
                    if (state.checkUserId) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const MainView();
                      }));
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const StartDataView();
                          },
                        ),
                      );
                    }
                  }
                },
                child: const WelcomeScreen(),
              )
            : const StartAppView(),
      ),
    );
  }
}

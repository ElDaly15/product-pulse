import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:product_pulse/core/controller/depency_injection.dart';
import 'package:product_pulse/features/post_feature/presentation/views/main_view.dart';
import 'package:product_pulse/features/registretion_feature/presentation/manager/check_user_id/check_user_id_cubit.dart';
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
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const StartDataView();
                      }));
                    }
                  }
                },
                child: const Scaffold(
                  backgroundColor: Color(0xffFFFFFF),
                  body: Center(
                      child: CircularProgressIndicator(
                    color: Color(0xff1F41BB),
                  )),
                ),
              )
            : const StartAppView(),
      ),
    );
  }
}

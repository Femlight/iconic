import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:iconic_university/features/camera/presentation/bloc/camera_bloc.dart';
import 'package:iconic_university/features/location/presentation/bloc/location_bloc.dart';
import 'package:iconic_university/features/reports/presentation/bloc/reports_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/navigation/presentation/pages/main_navigation_page.dart';
import 'injection_container.dart' as di;

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize cameras
  try {
    cameras = await availableCameras();
  } catch (e) {
    print('Error initializing cameras: $e');
  }

  // Initialize dependencies
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>()..add(AuthCheckStatusEvent()),
        ),
        BlocProvider<ReportsBloc>(create: (context) => di.sl<ReportsBloc>()),
        BlocProvider<LocationBloc>(create: (context) => di.sl<LocationBloc>()),
        BlocProvider<CameraBloc>(create: (context) => di.sl<CameraBloc>()),
      ],
      child: MaterialApp(
        title: 'Iconic University Reporting',
        theme: AppTheme.lightTheme,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return const MainNavigationPage();
            }
            return const LoginPage();
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

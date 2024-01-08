import 'package:absence_schedule/common/models/section.dart';
import 'package:absence_schedule/common/models/student.dart';
import 'package:absence_schedule/common/utils/dark_theme.dart';
import 'package:absence_schedule/features/absence_schedule/cubit/absence_cubit/absence_cubit.dart';
import 'package:absence_schedule/features/absence_schedule/cubit/sections_cubit/sections_cubit.dart';
import 'package:absence_schedule/features/absence_schedule/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SectionAdapter());
  Hive.registerAdapter(StudentAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SectionsCubit()..fetchSections()),
        BlocProvider(create: (context) => AbsenceCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
        home: const HomeView(),
      ),
    );
  }
}

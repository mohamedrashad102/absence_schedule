import 'package:absence_schedule/common/widgets/adaptive_layout.dart';
import 'package:absence_schedule/features/absence_schedule/views/home_view/layers/desktop_layout.dart';
import 'package:absence_schedule/features/absence_schedule/views/home_view/layers/mobile_layout.dart';
import 'package:absence_schedule/features/absence_schedule/views/home_view/layers/tablet_layout.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        mobileLayout: (context) => const MobileLayout(),
        tabletLayout: (context) => const TabletLayout(),
        desktopLayout: (context) => const DesktopLayout(),
      ),
    );
  }
}

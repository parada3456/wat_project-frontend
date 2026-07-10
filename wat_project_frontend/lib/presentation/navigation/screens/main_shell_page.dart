import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wat_project_frontend/presentation/navigation/widgets/custom_bottom_nav_bar.dart';

class MainShellPage extends StatelessWidget {
  final Widget child;

  const MainShellPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Determine the current index based on the active path
    final String location = GoRouterState.of(context).matchedLocation;
    int currentIndex = 0;

    if (location.startsWith('/journey')) {
      currentIndex = 1;
    } else if (location.startsWith('/expenses')) {
      currentIndex = 2;
    } else if (location.startsWith('/jobs')) {
      currentIndex = 3;
    } else if (location.startsWith('/profile')) {
      currentIndex = 4;
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == currentIndex) return; // Prevent redundant routing

          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/journey');
              break;
            case 2:
              context.go('/expenses');
              break;
            case 3:
              context.go('/jobs');
              break;
            case 4:
              context.go('/profile');
              break;
          }
        },
      ),
    );
  }
}

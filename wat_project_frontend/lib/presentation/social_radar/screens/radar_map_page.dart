import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/social_radar/widgets/radar_user_marker.dart';
import 'package:wat_project_frontend/core/utils/theme_constants.dart';

class RadarMapPage extends StatelessWidget {
  const RadarMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Social Radar',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Placeholder for Map View
          Container(
            color: AppColors.surfaceAlt,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.map_outlined,
                    size: 80,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(height: AppDimension.space16),
                  const Text(
                    'Map View Integration Needed',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ),
          // Sample Markers
          const Positioned(
            top: 200,
            left: 100,
            child: RadarUserMarker(name: 'John'),
          ),
          const Positioned(
            top: 350,
            left: 250,
            child: RadarUserMarker(name: 'Sarah'),
          ),
          const Positioned(
            top: 500,
            left: 150,
            child: RadarUserMarker(name: 'Mike'),
          ),
          // Bottom Actions
          Positioned(
            bottom: AppDimension.space32,
            left: AppDimension.space32,
            right: AppDimension.space32,
            child: Container(
              padding: const EdgeInsets.all(AppDimension.space16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sharing your location',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Only friends can see you',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: true,
                    onChanged: (val) {},
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

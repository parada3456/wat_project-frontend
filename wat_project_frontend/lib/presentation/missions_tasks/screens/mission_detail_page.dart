import 'package:flutter/material.dart';
import 'package:wat_project_frontend/presentation/missions_tasks/widgets/task_checkbox_tile.dart';
import 'package:wat_project_frontend/presentation/widgets/wat_button.dart';
import 'package:wat_project_frontend/utils/theme_constants.dart';

class MissionDetailPage extends StatefulWidget {
  const MissionDetailPage({super.key});

  @override
  State<MissionDetailPage> createState() => _MissionDetailPageState();
}

class _MissionDetailPageState extends State<MissionDetailPage> {
  bool embassyAppointmentChecked = false;
  bool interviewPrepChecked = false;

  final List<Map<String, dynamic>> documents = [
    {
      'title': 'Passport',
      'subtitle': 'เล่มที่มีอายุเกิน 6 เดือน และเล่มเก่าทั้งหมด',
      'checked': false,
    },
    {
      'title': 'Appointment Confirmation',
      'subtitle': null,
      'checked': false,
    },
    {
      'title': 'DS-160',
      'subtitle': 'Confirmation Page',
      'checked': false,
    },
    {
      'title': 'DS-2019',
      'subtitle': 'หนังสือจริง (ไม่อนุญาตให้ใช้สำเนา)',
      'checked': false,
    },
    {
      'title': 'ใบเสร็จ SEVIS Fee (I-901)',
      'subtitle': 'หนังสือจริง (ไม่อนุญาตให้ใช้สำเนา)',
      'checked': false,
    },
    {
      'title': 'รูปถ่าย 2x2 นิ้ว',
      'subtitle': 'พื้นหลังขาว ไม่เกิน 6 เดือน (ห้ามใส่ต่างหู/แว่นตา เห็นหูชัดเจน)',
      'checked': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    int completedItems = 0;
    if (embassyAppointmentChecked) completedItems++;
    if (interviewPrepChecked) completedItems++;
    
    bool allDocumentsChecked = documents.isNotEmpty && documents.every((doc) => doc['checked'] == true);
    if (allDocumentsChecked) completedItems++;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppDimension.space32, vertical: AppDimension.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Phase 1: Mission 2 of 10',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimension.space8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Visa Prep',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '$completedItems/3',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimension.space16),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimension.radiusSmall),
              child: LinearProgressIndicator(
                value: completedItems / 3.0,
                backgroundColor: AppColors.surfaceAlt,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: AppDimension.space32),
            
            TaskCheckboxTile(
              title: 'Embassy Appointment',
              isChecked: embassyAppointmentChecked,
              onChanged: (val) => setState(() => embassyAppointmentChecked = val ?? false),
            ),
            const Divider(color: AppColors.surface),

            TaskCheckboxTile(
              title: 'Interview Prep',
              subtitle: 'Prepare required documents and mock interview',
              isChecked: interviewPrepChecked,
              onChanged: (val) => setState(() => interviewPrepChecked = val ?? false),
            ),
            const Divider(color: AppColors.surface),

            const SizedBox(height: AppDimension.space32),
            Row(
              children: [
                const Text(
                  'Documents',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${documents.length} items',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimension.space16),
            
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppDimension.radiusMedium),
                border: Border.all(color: AppColors.surfaceAlt),
              ),
              child: Column(
                children: documents.map((doc) {
                  int index = documents.indexOf(doc);
                  return Column(
                    children: [
                      TaskCheckboxTile(
                        title: doc['title'] as String,
                        subtitle: doc['subtitle'] as String?,
                        isChecked: doc['checked'] as bool,
                        onChanged: (val) => setState(() => documents[index]['checked'] = val ?? false),
                      ),
                      if (index < documents.length - 1)
                        const Divider(height: 1, indent: 56),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppDimension.space50),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimension.space32),
          child: WatButton(
            label: 'Mark as Done',
            onPressed: completedItems == 3 ? () {} : () {}, // Should be properly handled
          ),
        ),
      ),
    );
  }
}

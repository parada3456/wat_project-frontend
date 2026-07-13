import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

class TempTestScreen extends StatefulWidget {
  const TempTestScreen({super.key});

  @override
  State<TempTestScreen> createState() => _TempTestScreenState();
}

class _TempTestScreenState extends State<TempTestScreen> {
  late final TextEditingController _urlController;
  String _status = 'Press button to test backend';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final defaultUrl = kIsWeb
        ? 'http://localhost:3456/health'
        : (defaultTargetPlatform == TargetPlatform.android
              ? 'http://10.0.2.2:3456/health'
              : 'http://localhost:3456/health');
    _urlController = TextEditingController(text: defaultUrl);
  }

  Future<void> _testBackend() async {
    setState(() {
      _isLoading = true;
      _status = 'Connecting to ${_urlController.text}...';
    });

    try {
      final url = Uri.parse(_urlController.text);
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _status = 'Success!\nBackend Status: ${data['status']}';
        });
      } else {
        setState(() {
          _status = 'Backend Error: ${response.statusCode}\n${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _status =
            'Connection failed: $e\n\nTips:\n'
            '- Android Emulator: http://10.0.2.2:3456/health\n'
            '- iOS Simulator: http://localhost:3456/health\n'
            '- Physical Device: http://<YOUR_IP>:3456/health';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Auth & Profile':
        return Icons.security;
      case 'Missions & Tasks':
        return Icons.assignment;
      case 'Journey & Gamification':
        return Icons.emoji_events;
      case 'Social & Radar':
        return Icons.share;
      case 'Expense Sharing':
        return Icons.account_balance_wallet;
      case 'Job Market':
        return Icons.storefront;
      case 'Notifications':
        return Icons.notifications_active;
      default:
        return Icons.link;
    }
  }

  List<Widget> _buildNavigationCategories(BuildContext context) {
    final Map<String, List<_RouteNavInfo>> categories = {
      'Auth & Profile': [
        const _RouteNavInfo(title: 'Login', path: '/login', icon: Icons.login),
        const _RouteNavInfo(
          title: 'Register',
          path: '/register',
          icon: Icons.person_add,
        ),
        const _RouteNavInfo(title: 'Home', path: '/home', icon: Icons.home),
        const _RouteNavInfo(
          title: 'Profile',
          path: '/profile',
          icon: Icons.account_circle,
        ),
        const _RouteNavInfo(
          title: 'Edit Profile',
          path: '/profile/edit',
          icon: Icons.edit,
        ),
        const _RouteNavInfo(
          title: 'Settings',
          path: '/settings',
          icon: Icons.settings,
        ),
        const _RouteNavInfo(
          title: 'Admin',
          path: '/admin',
          icon: Icons.admin_panel_settings,
        ),
      ],
      'Missions & Tasks': [
        const _RouteNavInfo(
          title: 'Missions Dashboard',
          path: '/missions',
          icon: Icons.dashboard,
        ),
        const _RouteNavInfo(
          title: 'Mission Detail',
          path: '/missions/detail',
          icon: Icons.info,
        ),
        const _RouteNavInfo(
          title: 'Mission Calendar',
          path: '/missions/calendar',
          icon: Icons.calendar_month,
        ),
        const _RouteNavInfo(
          title: 'Missions Search',
          path: '/missions/search',
          icon: Icons.search,
        ),
      ],
      'Journey & Gamification': [
        const _RouteNavInfo(
          title: 'Journey Timeline',
          path: '/journey',
          icon: Icons.timeline,
        ),
        const _RouteNavInfo(
          title: 'Leaderboard',
          path: '/leaderboard',
          icon: Icons.leaderboard,
        ),
        const _RouteNavInfo(
          title: 'Badges',
          path: '/badges',
          icon: Icons.emoji_events,
        ),
        const _RouteNavInfo(
          title: 'Credit History',
          path: '/credit-history',
          icon: Icons.history,
        ),
      ],
      'Social & Radar': [
        const _RouteNavInfo(
          title: 'Friends List',
          path: '/friends',
          icon: Icons.people,
        ),
        const _RouteNavInfo(
          title: 'Friend Requests',
          path: '/friend-requests',
          icon: Icons.person_pin,
        ),
        const _RouteNavInfo(
          title: 'Radar Map',
          path: '/radar',
          icon: Icons.map,
        ),
      ],
      'Expense Sharing': [
        const _RouteNavInfo(
          title: 'Expense History',
          path: '/expenses',
          icon: Icons.payments,
        ),
        const _RouteNavInfo(
          title: 'Create Expense',
          path: '/expenses/create',
          icon: Icons.add_card,
        ),
        const _RouteNavInfo(
          title: 'Expense Details',
          path: '/expenses/details',
          icon: Icons.receipt,
        ),
        const _RouteNavInfo(
          title: 'Payment Submission',
          path: '/expenses/submit',
          icon: Icons.send,
        ),
      ],
      'Job Market': [
        const _RouteNavInfo(
          title: 'Job Search',
          path: '/jobs',
          icon: Icons.work,
        ),
        const _RouteNavInfo(
          title: 'Job Details',
          path: '/jobs/job-123',
          icon: Icons.business_center,
        ),
        const _RouteNavInfo(
          title: 'Job Cart',
          path: '/jobs/cart',
          icon: Icons.shopping_cart,
        ),
        const _RouteNavInfo(
          title: 'Write Review',
          path: '/jobs/review',
          icon: Icons.rate_review,
        ),
      ],
      'Notifications': [
        const _RouteNavInfo(
          title: 'Notifications Center',
          path: '/notifications',
          icon: Icons.notifications,
        ),
      ],
    };

    return categories.entries.map((entry) {
      final categoryTitle = entry.key;
      final routes = entry.value;

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey[200]!),
        ),
        child: ExpansionTile(
          title: Text(
            categoryTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          leading: Icon(
            _getCategoryIcon(categoryTitle),
            color: const Color(0xFF9747FF),
          ),
          childrenPadding: const EdgeInsets.all(12),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: routes.map((info) {
                  return ElevatedButton.icon(
                    onPressed: () => context.push(info.path),
                    icon: Icon(info.icon, size: 16),
                    label: Text(info.title),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF2E7FF),
                      foregroundColor: const Color(0xFF9747FF),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Dashboard'),
        backgroundColor: const Color(0xFF9747FF),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[200]!),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.api, size: 36, color: Color(0xFF9747FF)),
                        SizedBox(width: 12),
                        Text(
                          'Backend Connectivity Test',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _urlController,
                      decoration: const InputDecoration(
                        labelText: 'Backend URL',
                        border: OutlineInputBorder(),
                        hintText: 'http://localhost:3456/health',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Text(
                        _status,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _testBackend,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9747FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Test Connection'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'App Screen Navigator',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9747FF),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Easily navigate to any screen in the application for testing.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ..._buildNavigationCategories(context),
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteNavInfo {
  final String title;
  final String path;
  final IconData icon;

  const _RouteNavInfo({
    required this.title,
    required this.path,
    required this.icon,
  });
}

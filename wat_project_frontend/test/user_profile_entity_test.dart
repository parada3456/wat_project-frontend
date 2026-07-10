import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:wat_project_frontend/data/entities/user/user_profile_entity.dart';
import 'package:wat_project_frontend/data/entities/gamification/user_badge_entity.dart';
import 'package:wat_project_frontend/data/sources/api/api_model/pagination_response.dart';

void main() {
  group('UserProfileEntity Parsing Tests', () {
    test('Verify if mock user profile response parses correctly', () {
      final mockJsonString = '''
      {
          "user": {
              "user_id": "usr_alice",
              "email": "alice@example.com",
              "first_name": "Alice",
              "last_name": "Smith",
              "profile_id": "prf_alice",
              "phone_number": "+15551234567",
              "bio": "J1 student from London, UK. Excited to work in the US!",
              "avatar_url": "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
              "radar_visibility": "show_anonymous",
              "current_coordinates": "13.776300,100.521800",
              "location_updated_at": "2026-06-29T16:36:14.802336+07:00",
              "current_phase_id": "phs_003",
              "total_lifetime_points": 460,
              "current_phase_points": 150,
              "mission_streak": 4,
              "arrival_date": "2026-04-30T16:36:14.802336+07:00",
              "job_start_date": "2026-05-05T16:36:14.802336+07:00",
              "created_at": "2026-06-29T16:36:14.802336+07:00",
              "updated_at": "2026-06-29T16:36:14.802336+07:00"
          },
          "credit_score": {
              "credit_id": "crd_alice",
              "user_id": "usr_alice",
              "current_score": 98,
              "last_updated": "2026-06-29T16:36:14.802336+07:00"
          },
          "user_jobs": [
              {
                  "user_id": "usr_alice",
                  "job_id": "job_002",
                  "assigned_at": "2026-05-05T09:36:14.802336Z",
                  "is_main": true,
                  "start_date": "2026-05-10T09:00:00Z",
                  "end_date": "2026-09-10T17:00:00Z"
              }
          ]
      }
      ''';

      final Map<String, dynamic> jsonMap =
          jsonDecode(mockJsonString) as Map<String, dynamic>;

      try {
        final profile = UserProfileEntity.fromJson(jsonMap);
        print(
          'Successfully parsed! User Account ID: ${profile.userAccount.userId}',
        );
      } catch (e, stack) {
        print('Parsing failed: $e');
        print('Stack trace: $stack');
        rethrow;
      }
    });

    test('Verify if mock user badges pagination response parses correctly', () {
      final mockJsonString = '''
      {
          "data": [
              {
                  "user_badge_id": "ubg_ali_1",
                  "user_id": "usr_alice",
                  "badge_id": "bdg_001",
                  "source_id": "ums_alice_mis_001",
                  "earned_at": "2026-05-18T10:43:57.21105+07:00",
                  "badge": {
                      "badge_id": "bdg_001",
                      "title": "Early Bird",
                      "description": "Complete a mission 7+ days before its calculated due date.",
                      "trigger_type": "speed",
                      "icon_url": "https://example.com/badge_early_bird.png",
                      "created_at": "2026-07-02T10:43:57.21105+07:00"
                  }
              },
              {
                  "user_badge_id": "ubg_ali_2",
                  "user_id": "usr_alice",
                  "badge_id": "bdg_002",
                  "source_id": "ums_alice_mis_001",
                  "earned_at": "2026-05-23T10:43:57.21105+07:00",
                  "badge": {
                      "badge_id": "bdg_002",
                      "title": "Streak Master",
                      "description": "Maintain a streak of 3 or more mission completions.",
                      "trigger_type": "streak",
                      "icon_url": "https://example.com/badge_streak.png",
                      "created_at": "2026-07-02T10:43:57.21105+07:00"
                  }
              },
              {
                  "user_badge_id": "ubg_ali_3",
                  "user_id": "usr_alice",
                  "badge_id": "bdg_003",
                  "source_id": "ums_alice_mis_002",
                  "earned_at": "2026-05-28T10:43:57.21105+07:00",
                  "badge": {
                      "badge_id": "bdg_003",
                      "title": "Pioneer",
                      "description": "Be the first student to submit proof for a mission.",
                      "trigger_type": "first_completer",
                      "icon_url": "https://example.com/badge_pioneer.png",
                      "created_at": "2026-07-02T10:43:57.21105+07:00"
                  }
              }
          ],
          "pagination": {
              "page": 1,
              "page_size": 10,
              "total_items": 3,
              "total_pages": 1
          }
      }
      ''';

      final Map<String, dynamic> jsonMap =
          jsonDecode(mockJsonString) as Map<String, dynamic>;

      try {
        final paginatedBadges = PaginationResponse<UserBadgeEntity>.fromJson(
          jsonMap,
          (item) => UserBadgeEntity.fromJson(item as Map<String, dynamic>),
        );
        expect(paginatedBadges.data.length, equals(3));
        expect(paginatedBadges.data[0].userBadgeId, equals('ubg_ali_1'));
        expect(paginatedBadges.data[0].badge.title, equals('Early Bird'));
        print(
          'Successfully parsed UserBadges! Count: ${paginatedBadges.data.length}',
        );
      } catch (e, stack) {
        print('Parsing UserBadges failed: $e');
        print('Stack trace: $stack');
        rethrow;
      }
    });
  });
}

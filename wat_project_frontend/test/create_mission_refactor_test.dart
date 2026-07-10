import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wat_project_frontend/data/entities/mission/mission_entity.dart';
import 'package:wat_project_frontend/domain/models/mission_models.dart';
import 'package:wat_project_frontend/data/mappers/mission_mapper.dart';
import 'package:wat_project_frontend/data/sources/api/auth_api_client.dart';
import 'package:wat_project_frontend/domain/services/auth_manager.dart';
import 'package:wat_project_frontend/domain/models/auth/auth_model.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}
class MockAuthApiService extends Mock implements AuthApiService {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late MockAuthApiService mockApi;
  late AuthSessionManager authManager;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    mockApi = MockAuthApiService();
    authManager = AuthSessionManager(mockStorage, api: mockApi);
  });

  group('AuthSessionManager.isAdmin Tests', () {
    String createJwt(Map<String, dynamic> claims) {
      final header = base64.encode(utf8.encode(jsonEncode({'alg': 'HS256', 'typ': 'JWT'})));
      final payload = base64.encode(utf8.encode(jsonEncode(claims)));
      return '$header.$payload.signature';
    }

    test('should return true if is_admin is true in JWT', () {
      final token = createJwt({'is_admin': true, 'sub': 'usr_1'});
      authManager.sessionNotifier.value = AuthModel(
        token: token,
        refreshToken: 'refresh',
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
        tokenType: 'Bearer',
      );

      expect(authManager.isAdmin, true);
    });

    test('should return false if is_admin is false in JWT', () {
      final token = createJwt({'is_admin': false, 'sub': 'usr_1'});
      authManager.sessionNotifier.value = AuthModel(
        token: token,
        refreshToken: 'refresh',
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
        tokenType: 'Bearer',
      );

      expect(authManager.isAdmin, false);
    });

    test('should return false if token format is invalid', () {
      authManager.sessionNotifier.value = AuthModel(
        token: 'invalid_token',
        refreshToken: 'refresh',
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
        tokenType: 'Bearer',
      );

      expect(authManager.isAdmin, false);
    });
  });

  group('MissionEntity mapping Tests', () {
    test('should map createdBy correctly from entity to model', () {
      final entity = MissionEntity(
        missionId: 'mis_123',
        phaseId: 'phs_1',
        title: 'Test Title',
        basePoints: 100,
        isMandatory: false,
        verificationType: VerificationType.none,
        isActive: true,
        isLocked: false,
        createdBy: 'usr_creator',
        tasks: const [],
        createdAt: DateTime.utc(2026, 7, 6),
        updatedAt: DateTime.utc(2026, 7, 6),
      );

      final model = entity.toModel();
      expect(model.createdBy, 'usr_creator');
    });

    test('should map createdBy correctly from model to entity', () {
      final model = MissionModel(
        missionId: 'mis_123',
        phaseId: 'phs_1',
        title: 'Test Title',
        basePoints: 100,
        isMandatory: false,
        verificationType: VerificationType.none,
        isActive: true,
        isLocked: false,
        createdBy: 'usr_creator',
        tasks: const [],
        createdAt: DateTime.utc(2026, 7, 6),
        updatedAt: DateTime.utc(2026, 7, 6),
      );

      final entity = model.toEntity();
      expect(entity.createdBy, 'usr_creator');
    });
  });
}

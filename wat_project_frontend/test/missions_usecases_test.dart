// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:wat_project_frontend/domain/repositories/mission_repository.dart';
// import 'package:wat_project_frontend/domain/usecases/mission_usecases.dart';
// import 'package:wat_project_frontend/domain/models/mission_models.dart';
// import 'package:wat_project_frontend/data/entities/mission/mission_entity.dart';
// import 'package:wat_project_frontend/data/entities/mission/user_mission_entity.dart';

// class MockMissionRepository extends Mock implements MissionRepository {}

// void main() {
//   late MockMissionRepository mockRepository;
//   late GetExploreMissionUseCase getExploreMissionUseCase;
//   late JoinMissionUseCase joinMissionUseCase;

//   setUp(() {
//     mockRepository = MockMissionRepository();
//     getExploreMissionUseCase = GetExploreMissionUseCase(mockRepository);
//     joinMissionUseCase = JoinMissionUseCase(mockRepository);
//   });

//   group('GetExploreMissionUseCase Tests', () {
//     final tMissionEntity = MissionEntity(
//       missionId: 'mis_123',
//       phaseId: 'phs_1',
//       title: 'Test Explore Mission',
//       description: 'Test Description',
//       location: 'Test Location',
//       basePoints: 100,
//       isMandatory: false,
//       verificationType: VerificationType.none,
//       // dueDateType: 'fixed',
//       // fixedDueDate: DateTime.parse('2026-07-10T00:00:00Z'),
//       // relativeTriggerEvent: null,
//       // relativeDaysOffset: null,
//       isActive: true,
//       isLocked: false,
//       createdAt: DateTime.parse('2026-07-06T00:00:00Z'),
//       updatedAt: DateTime.parse('2026-07-06T00:00:00Z'), tasks: [],
//     );

//     test('should return a list of MissionModel from the repository', () async {
//       // arrange
//       when(() => mockRepository.listExploreMissions())
//           .thenAnswer((_) async => [tMissionEntity]);

//       // act
//       final result = await getExploreMissionUseCase();

//       // assert
//       expect(result.isRight(), true);
//       result.fold(
//         (failure) => fail('should not return failure'),
//         (models) {
//           expect(models.length, 1);
//           expect(models[0].missionId, 'mis_123');
//           expect(models[0].title, 'Test Explore Mission');
//         },
//       );
//       verify(() => mockRepository.listExploreMissions()).called(1);
//       verifyNoMoreInteractions(mockRepository);
//     });

//     test('should return Failure when repository throws exception', () async {
//       // arrange
//       when(() => mockRepository.listExploreMissions())
//           .thenThrow(Exception('API error'));

//       // act
//       final result = await getExploreMissionUseCase();

//       // assert
//       expect(result.isLeft(), true);
//       verify(() => mockRepository.listExploreMissions()).called(1);
//       verifyNoMoreInteractions(mockRepository);
//     });
//   });

//   group('JoinMissionUseCase Tests', () {
//     final tUserMissionEntity = UserMissionEntity(
//       userMissionId: 'um_123',
//       userId: 'usr_1',
//       missionId: 'mis_123',
//       status: UserMissionStatus.notStarted,
//       createdAt: DateTime.parse('2026-07-06T00:00:00Z'),
//       updatedAt: DateTime.parse('2026-07-06T00:00:00Z'),
//     );

//     final tJoinedMissionEntity = MissionEntity(
//       missionId: 'mis_123',
//       phaseId: 'phs_1',
//       title: 'Test Explore Mission',
//       description: 'Test Description',
//       location: 'Test Location',
//       basePoints: 100,
//       isMandatory: false,
//       verificationType: VerificationType.none,
//       isActive: true,
//       isLocked: false,
//       createdAt: DateTime.parse('2026-07-06T00:00:00Z'),
//       updatedAt: DateTime.parse('2026-07-06T00:00:00Z'),
//       tasks: [],
//       userMission: tUserMissionEntity,
//     );

//     test('should return the joined MissionModel', () async {
//       // arrange
//       when(() => mockRepository.joinMission('mis_123'))
//           .thenAnswer((_) async => tJoinedMissionEntity);

//       // act
//       final result = await joinMissionUseCase('mis_123');

//       // assert
//       expect(result.isRight(), true);
//       result.fold(
//         (failure) => fail('should not return failure'),
//         (model) {
//           expect(model, tJoinedMissionEntity.toModel());
//           expect(model.userMission?.userMissionId, 'um_123');
//           expect(model.missionId, 'mis_123');
//         },
//       );
//       verify(() => mockRepository.joinMission('mis_123')).called(1);
//       verifyNoMoreInteractions(mockRepository);
//     });

//     test('should return Failure when repository throws exception', () async {
//       // arrange
//       when(() => mockRepository.joinMission('mis_123'))
//           .thenThrow(Exception('API error'));

//       // act
//       final result = await joinMissionUseCase('mis_123');

//       // assert
//       expect(result.isLeft(), true);
//       verify(() => mockRepository.joinMission('mis_123')).called(1);
//       verifyNoMoreInteractions(mockRepository);
//     });
//   });
// }

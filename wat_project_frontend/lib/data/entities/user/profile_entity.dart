import 'package:json_annotation/json_annotation.dart';
import 'package:wat_project_frontend/domain/models/user_models.dart';

part 'profile_entity.g.dart';

@JsonSerializable()
class ProfileEntity {
  @JsonKey(name: 'profile_id')
  final String profileId;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? bio;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @JsonKey(name: 'radar_visibility')
  final RadarVisibility radarVisibility;
  @JsonKey(name: 'current_coordinates')
  final String? currentCoordinates;
  @JsonKey(name: 'location_updated_at')
  final DateTime locationUpdatedAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  ProfileEntity({
    required this.profileId,
    required this.userId,
    this.firstName, 
    this.lastName,
    this.phoneNumber,
    this.bio,
    this.avatarUrl,
    required this.radarVisibility,
    this.currentCoordinates,
    required this.locationUpdatedAt,
    required this.updatedAt, 
  });

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => _$ProfileEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileEntityToJson(this);
  

  ProfileModel toModel() => ProfileModel(
    profileId: profileId,
    userId: userId,
    phoneNumber: phoneNumber,
    bio: bio,
    avatarUrl: avatarUrl,
    radarVisibility: radarVisibility,
    currentCoordinates: currentCoordinates,
    locationUpdatedAt: locationUpdatedAt,
    updatedAt: updatedAt,
  );
}

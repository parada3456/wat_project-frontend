import 'package:json_annotation/json_annotation.dart';

enum RadarVisibility {
  @JsonValue('show_anonymous')                                                                                                
  showAnonymous,                                                                                                              
  @JsonValue('show_friends')                                                                                                  
  showFriends,                                                                                                                
  @JsonValue('hidden')                                                                                                        
  hidden,                                                                                                                     
}

class ProfileModel {
  final String profileId;
  final String userId;
  final String? phoneNumber;
  final String? bio;
  final String? avatarUrl;
  final RadarVisibility radarVisibility;
  final String? currentCoordinates;
  final DateTime? locationUpdatedAt;
  final DateTime updatedAt;

  const ProfileModel({
    required this.profileId,
    required this.userId,
    this.phoneNumber,
    this.bio,
    this.avatarUrl,
    this.radarVisibility = RadarVisibility.hidden,
    this.currentCoordinates,
    this.locationUpdatedAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModel &&
          runtimeType == other.runtimeType &&
          profileId == other.profileId &&
          userId == other.userId &&
          phoneNumber == other.phoneNumber &&
          bio == other.bio &&
          avatarUrl == other.avatarUrl &&
          radarVisibility == other.radarVisibility &&
          currentCoordinates == other.currentCoordinates &&
          locationUpdatedAt == other.locationUpdatedAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
        profileId,
        userId,
        phoneNumber,
        bio,
        avatarUrl,
        radarVisibility,
        currentCoordinates,
        locationUpdatedAt,
        updatedAt,
      );
}

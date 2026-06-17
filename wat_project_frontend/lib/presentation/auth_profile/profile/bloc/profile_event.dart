abstract class ProfileEvent {
  const ProfileEvent();
}

class GetProfileEvent extends ProfileEvent {
  const GetProfileEvent();
}

class UpdateProfileSubmittedEvent extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String bio;
  final String avatarUrl;

  const UpdateProfileSubmittedEvent({
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.avatarUrl,
  });
}

class UpdateLocationSubmittedEvent extends ProfileEvent {
  final double latitude;
  final double longitude;

  const UpdateLocationSubmittedEvent({
    required this.latitude,
    required this.longitude,
  });
}

class DeleteAccountSubmittedEvent extends ProfileEvent {
  final String password;
  const DeleteAccountSubmittedEvent(this.password);
}

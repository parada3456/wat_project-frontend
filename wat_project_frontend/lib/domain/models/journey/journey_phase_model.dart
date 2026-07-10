class JourneyPhaseModel {
  final String phaseId;
  final int phaseNumber;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const JourneyPhaseModel({
    required this.phaseId,
    required this.phaseNumber,
    required this.title,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JourneyPhaseModel &&
          runtimeType == other.runtimeType &&
          phaseId == other.phaseId &&
          phaseNumber == other.phaseNumber &&
          title == other.title &&
          description == other.description &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
    phaseId,
    phaseNumber,
    title,
    description,
    createdAt,
    updatedAt,
  );
}

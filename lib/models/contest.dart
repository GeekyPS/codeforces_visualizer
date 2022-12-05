class Contest {
  final int id;
  final String name;
  final String type;
  final String phase;
  final bool frozen;
  final int durationSeconds; //duration in seconds
  final int? startTimeSeconds;

  Contest({
    required this.id,
    required this.name,
    required this.type,
    required this.phase,
    required this.frozen,
    required this.durationSeconds,
    this.startTimeSeconds,
  });
}

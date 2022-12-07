import 'package:codeforces_visualizer/models/enums.dart';

class ProblemResult {
  final double points;
  final int? penalty;
  final int rejectedAttemptCount;
  final problemresult_type type;
  final int? bestSubmissionTimeSeconds;

  ProblemResult({
    required this.points,
    this.penalty,
    required this.rejectedAttemptCount,
    required this.type,
    this.bestSubmissionTimeSeconds
  });
}
import 'package:codeforces_visualizer/models/party.dart';
import 'package:codeforces_visualizer/models/problem_result.dart';

class RanklistRow {
  final Party party;
  final int rank;
  final double points;
  final int penalty;
  final int successfulHackCount;
  final int unsuccessfulHackCount;
  final List<ProblemResult> problemResults;
  final int? lastSubmissionTimeSeconds;

  RanklistRow({
    required this.party,
    required this.rank,
    required this.points,
    required this.penalty,
    required this.successfulHackCount,
    required this.unsuccessfulHackCount,
    required this.problemResults,
    this.lastSubmissionTimeSeconds
  });
}
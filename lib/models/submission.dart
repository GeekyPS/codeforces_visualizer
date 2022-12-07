import 'package:codeforces_visualizer/models/party.dart';

import './problem.dart';

class Submission {
  final int id;
  final int? contestId;
  final int creationTimeSeconds; // unix format
  final Problem problem;
  final Party? party;
  final String programmingLanguage;
  final String verdict;
  final int passedTestCount;
  final int timeConsumedMillis; // time consumed in milliseconds
  final int memoryConsumedBytes;

  Submission({
    required this.id,
    required this.contestId,
    required this.creationTimeSeconds,
    required this.problem,
    required this.party,
    required this.programmingLanguage,
    required this.verdict,
    required this.passedTestCount,
    required this.timeConsumedMillis,
    required this.memoryConsumedBytes,
  });
}

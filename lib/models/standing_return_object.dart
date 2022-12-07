import 'package:codeforces_visualizer/models/problem.dart';
import 'package:codeforces_visualizer/models/rank_list_row.dart';

import 'contest.dart';

class StandingReturnObject {
  final Contest contest;
  final List<Problem> problems;
  final List<RanklistRow> rows;

  StandingReturnObject({
    required this.contest,
    required this.problems,
    required this.rows
  });
}
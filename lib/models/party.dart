import 'package:codeforces_visualizer/models/enums.dart';

class Member {
  final String handle;
  final String? name;

  Member({
    required this.handle,
    this.name,
  });
}

class Party {
  final int? contestId;
  final List<Member> members;
  final participant_type participantType;
  final int? teamId;
  final String? teamName;
  final bool? ghost;
  final int? room;
  final int? startTimeSeconds;

  Party({
    this.contestId,
    required this.members,
    required this.participantType,
    this.teamId,
    this.teamName,
    this.ghost,
    this.room,
    this.startTimeSeconds
  });
}

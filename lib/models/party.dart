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

  Party({
    this.contestId,
    required this.members,
  });
}

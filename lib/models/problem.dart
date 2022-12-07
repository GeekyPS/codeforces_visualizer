class Problem {
  final int? contestId;
  final String index;
  final String name;
  final String type;
  final String? rating;
  final List<dynamic> tags;

  Problem({
    this.contestId,
    required this.index,
    required this.name,
    required this.type,
    this.rating,
    required this.tags,
  });
}

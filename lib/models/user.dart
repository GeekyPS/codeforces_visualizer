class User {
  final String handle;
  final String email; // assign gmail as CF email may be absent
  final int contribution;
  final String rank;
  final int rating;
  final String maxRank;
  final int maxRating;
  final int lastOnlineTimeSeconds; // unix format
  final int registrationTimeSeconds; // unix format
  final String avatar;
  final String? titlePhoto;

  User({
    required this.handle,
    required this.email,
    required this.contribution,
    required this.rank,
    required this.rating,
    required this.maxRank,
    required this.maxRating,
    required this.lastOnlineTimeSeconds,
    required this.registrationTimeSeconds,
    required this.avatar,
    required this.titlePhoto,
  });
}

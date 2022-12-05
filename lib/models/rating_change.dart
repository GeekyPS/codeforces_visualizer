class RatingChange {
  final int contestId;
  final String contestName;
  final String handle;
  final int rank;
  final String ratingUpdateTimeSeconds;
  final String oldRating;
  final String newRating;

  RatingChange({
    required this.contestId,
    required this.contestName,
    required this.handle,
    required this.rank,
    required this.ratingUpdateTimeSeconds,
    required this.oldRating,
    required this.newRating,
  });
}

class StatisticModel {
  final String userId;
  final String courseId;
  final String categoryId;
  final String exerciseId;
  final bool answerFlag;

  const StatisticModel(
      {required this.userId,
      required this.courseId,
      required this.categoryId,
      required this.exerciseId,
      required this.answerFlag});
}

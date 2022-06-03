List<RatingType> ratingItems = [
  RatingType(1, 'Batman', 'batman'),
  RatingType(2, 'Superman', 'superman'),
  RatingType(3, 'Hulk', 'hulk'),
  RatingType(4, 'Robin', 'robin'),
];

class RatingType {
  final int id;
  final String title;
  final String key;

  RatingType(this.id, this.title, this.key);
}

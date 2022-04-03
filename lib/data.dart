class Timetable {
  String name;
  String time;
  String teacher;
  String clas;
  String image;

  Timetable(
      this.name,
      this.time,
      this.teacher,
      this.clas,
      this.image,
      );

  static List<Timetable> samples = [
    Timetable(
      'Mathematical Analysis',
      '8.15-9.35',
      'Mazanik',
      '605',
      'assets/2.jpg',

    ),
    Timetable(
      'Differential Equations',
      '9.45-11.05',
      'Zadvorny',
      '517',
      'assets/3.jpg',
    ),
    Timetable(
      'Programming',
      '11.15-12.35',
      'Vasilenko',
      '508',
      'assets/4.jpg',
    ),
    Timetable(
      'Swimming',
      '3.30-5.00',
      'Hojempo',
      'Swimming pool',
      'assets/5.jpg',
    ),

  ];
}
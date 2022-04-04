class Item {
  String title;
  String link;
  String description;
  String date;
  String guid;

  Item(
      this.title,
      this.link,
      this.description,
      this.date,
      this.guid,
      );

  static List<Item> samples = [
    Item(
      'Альфа-Банк автоматизировал работу МФО с участниками закупок',
      'https://alfabank.ru/press/news/2021/7/13/86418.html?from=alfa_rss_news',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit,',
      'Tue, 13 Jul 2021 10:16:00 GMT',
      'https://alfabank.ru/press/news/2021/7/13/86418.html',
    ),
    Item(
      'Альфа-Банк возглавил рэнкинг организаторов дебютных выпусков корпоративных облигаций от Cbonds',
      'https://alfabank.ru/press/news/2021/7/12/86417.html?from=alfa_rss_news',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit,',
      'Mon, 12 Jul 2021 16:13:00 GMT',
      'https://alfabank.ru/press/news/2021/7/12/86417.html',
    ),
    Item(
      'Альфа-Банк запустил сервис приема платежей по QR-коду для оффлайн-магазинов',
      'https://alfabank.ru/press/news/2021/7/9/86293.html?from=alfa_rss_news',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit,',
      'Fri, 09 Jul 2021 09:03:00 GMT',
      'https://alfabank.ru/press/news/2021/7/9/86293.html',
    ),

  ];

}
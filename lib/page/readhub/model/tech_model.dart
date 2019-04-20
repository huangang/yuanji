class TechModel {
  String summary;
  int id;
  String title;
  String summaryAuto;
  String url;
  String mobileUrl;
  String siteName;
  String language;
  String authorName;
  String publishDate;

  TechModel(
      {
        this.summary,
        this.id,
        this.title,
        this.summaryAuto,
        this.url,
        this.mobileUrl,
        this.siteName,
        this.language,
        this.authorName,
        this.publishDate
      });

  factory TechModel.fromJson(Map<String, dynamic> json) {
    return TechModel(
      summary: json['summary'],
      id: json['id'],
      title: json['title'],
      summaryAuto: json['summaryAuto'],
      url: json['url'],
      mobileUrl: json['mobileUrl'],
      siteName: json['siteName'],
      language: json['language'],
      authorName: json['authorName'],
      publishDate: json['publishDate']
    );
  }
}
class NewsModel {
  String source;
  String imgsrc;
  String title;
  String ptime;
  String digest;
  int votecount;
  String subtitle;
  NewsModel(
      {
        this.source,
        this.imgsrc,
        this.title,
        this.ptime,
        this.digest,
        this.votecount,
        this.subtitle,
      });

  factory NewsModel.fromJson(Map<String, dynamic> json) {

    return NewsModel(
      source: json['source'],
      imgsrc: json['imgsrc'],
      title: json['title'],
      ptime: json['ptime'],
      digest: json['digest'],
      votecount: json['votecount'],
      subtitle: json['subtitle']
    );
  }
}
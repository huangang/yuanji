class TopicModel {
  String id;
  List newsArray;
  String mobileUrl;
  String createdAt;
  List eventData;
  String publishDate;
  String summary;
  String title;
  String updatedAt;
  String timeline;
  int order;
  bool hasInstantView;
  Object extra;
  TopicModel(
      {
        this.id,
        this.newsArray,
        this.mobileUrl,
        this.createdAt,
        this.eventData,
        this.publishDate,
        this.summary,
        this.title,
        this.updatedAt,
        this.timeline,
        this.order,
        this.hasInstantView,
        this.extra
      });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'],
      newsArray: json['newsArray'],
      mobileUrl: json['newsArray'][0]['mobileUrl'],
      createdAt: json['createdAt'],
      eventData: json['eventData'],
      publishDate: json['publishDate'],
      summary: json['summary'],
      title: json['title'],
      updatedAt: json['updatedAt'],
      timeline: json['timeline'],
      order: json['order'],
      hasInstantView: json['hasInstantView'],
      extra: json['extra']
    );
  }
}
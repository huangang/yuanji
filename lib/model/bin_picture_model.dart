class BinPictureModel {
  String startdate;
  String fullstartdate;
  String enddate;
  String url;
  String urlbase;
  String copyright;
  String copyrightlink;
  String title;
  String quiz;
  bool wp;
  String hsh;
  int drk;
  int top;
  int bot;
  List hs;

  BinPictureModel(
      {this.startdate,
      this.fullstartdate,
      this.enddate,
      this.url,
      this.urlbase,
      this.copyright,
      this.copyrightlink,
      this.title,
      this.quiz,
      this.wp,
      this.hsh,
      this.drk,
      this.top,
      this.bot,
      this.hs
      });

  factory BinPictureModel.fromJson(Map<String, dynamic> json) {
    const binUrl = 'https://cn.bing.com';

    return BinPictureModel(
      startdate: json['startdate'],
      fullstartdate: json['fullstartdate'],
      enddate: json['enddate'],
      url: binUrl + json['url'],
      urlbase: binUrl + json['urlbase'],
      copyright: json['copyright'],
      copyrightlink: binUrl + json['copyrightlink'],
      title: json['title'],
      quiz: binUrl + json['quiz'],
      wp: json['wp'],
      hsh: json['hsh'],
      drk: json['drk'],
      top: json['top'],
      bot: json['bot'],
      hs: json['hs']
    );
  }
}
class Detail {
  String status;
  int statusCode;
  List<Charpter> charpter;

  Detail({this.status, this.statusCode, this.charpter});

  Detail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      charpter = <Charpter>[];
      json['data'].forEach((v) {
        charpter.add(new Charpter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.charpter != null) {
      data['data'] = this.charpter.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Charpter {
  int chId;
  int courseId;
  String chTitle;
  String chDateadd;
  String chTimetotal;
  int chView;
  String chUrl;

  Charpter(
      {this.chId,
      this.courseId,
      this.chTitle,
      this.chDateadd,
      this.chTimetotal,
      this.chView,
      this.chUrl});

  Charpter.fromJson(Map<String, dynamic> json) {
    chId = json['ch_id'];
    courseId = json['course_id'];
    chTitle = json['ch_title'];
    chDateadd = json['ch_dateadd'];
    chTimetotal = json['ch_timetotal'];
    chView = json['ch_view'];
    chUrl = json['ch_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ch_id'] = this.chId;
    data['course_id'] = this.courseId;
    data['ch_title'] = this.chTitle;
    data['ch_dateadd'] = this.chDateadd;
    data['ch_timetotal'] = this.chTimetotal;
    data['ch_view'] = this.chView;
    data['ch_url'] = this.chUrl;
    return data;
  }
}

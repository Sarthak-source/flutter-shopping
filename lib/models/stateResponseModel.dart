class stateResponseModel {
  int? id;
  int? gstSlNum;
  String? name;

  stateResponseModel({this.id, this.gstSlNum, this.name});

  stateResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gstSlNum = json['gst_sl_num'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gst_sl_num'] = this.gstSlNum;
    data['name'] = this.name;
    return data;
  }
}

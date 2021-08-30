class BoardModel {
  String type;
  String bgColor;
  String code;
  List<TextData> textData;

  BoardModel({this.type, this.bgColor, this.code, this.textData});

  BoardModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    bgColor = json['bgColor'];
    code = json['code'];
    if (json['textData'] != null) {
      textData = new List<TextData>();
      json['textData'].forEach((v) {
        textData.add(new TextData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['bgColor'] = this.bgColor;
    data['code'] = this.code;
    if (this.textData != null) {
      data['textData'] = this.textData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TextData {
  String key;

  TextData({this.key});

  TextData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    return data;
  }
}
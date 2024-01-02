class Humidity {
  int? id;
  double? value;
  String? timestamp;

  Humidity({this.id, this.value, this.timestamp});

  Humidity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Order {
  int? id;
  String? name;
  String? startPlace;
  String? endPlace;
  String? startDate;
  String? endDate;
  double? defaultTemperature;
  double? defaultHumidity;
  double? deltaTemperature;
  double? deltaHumidity;
  double? freezerStatus;
  bool? nebulizerStatus;

  Order(
      {this.id,
      this.name,
      this.startPlace,
      this.endPlace,
      this.startDate,
      this.endDate,
      this.defaultTemperature,
      this.defaultHumidity,
      this.deltaTemperature,
      this.deltaHumidity,
      this.freezerStatus,
      this.nebulizerStatus});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startPlace = json['start_place'];
    endPlace = json['end_place'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    defaultTemperature = json['default_temperature'];
    defaultHumidity = json['default_humidity'];
    deltaTemperature = json['delta_temperature'];
    deltaHumidity = json['delta_humidity'];
    freezerStatus = json['freezer_status'];
    nebulizerStatus = json['nebulizer_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_place'] = startPlace;
    data['end_place'] = endPlace;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['default_temperature'] = defaultTemperature;
    data['default_humidity'] = defaultHumidity;
    data['delta_temperature'] = deltaTemperature;
    data['delta_humidity'] = deltaHumidity;
    data['freezer_status'] = freezerStatus;
    data['nebulizer_status'] = nebulizerStatus;
    return data;
  }
}

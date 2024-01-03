import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:keep_it_fresh/lib.dart';

class FormData {
  String? name;
  String? startPlace;
  String? endPlace;
  String? startDate;
  String? endDate;
  double? defaultTemperature;
  double? defaultHumidity;
  double? deltaTemperature;
  double? deltaHumidity;
  int? freezerStatus;
  bool? nebulizerStatus;

  FormData({
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
    this.nebulizerStatus,
  });

  // Convert FormData to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'start_place': startPlace,
      'end_place': endPlace,
      'start_date': startDate,
      'end_date': endDate,
      'default_temperature': defaultTemperature,
      'default_humidity': defaultHumidity,
      'delta_temperature': deltaTemperature,
      'delta_humidity': deltaHumidity,
      'freezer_status': freezerStatus,
      'nebulizer_status': nebulizerStatus,
    };
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  FormData formData = FormData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
        backgroundColor: AppColors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: AppColors.green,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Start place',
                  labelStyle: TextStyle(
                    color: AppColors.green,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a start place';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.startPlace = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'End place',
                  labelStyle: TextStyle(
                    color: AppColors.green,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an end place';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.endPlace = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Start date',
                  labelStyle: TextStyle(
                    color: AppColors.green,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a start date';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.startDate = "2023-01-20T12:00:00";
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'End date',
                  labelStyle: TextStyle(
                    color: AppColors.green,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an end date';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.endDate = "2023-01-22T12:00:00";
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Default temperature',
                  labelStyle: TextStyle(
                    color: AppColors.green,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a default temperature';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.defaultTemperature = double.tryParse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Default humidity',
                  labelStyle: TextStyle(
                    color: AppColors.green,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a default humidity';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.defaultHumidity = double.tryParse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Delta temperature',
                  labelStyle: TextStyle(
                    color: AppColors.green,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a delta temperature';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.deltaTemperature = double.tryParse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Delta humidity',
                  labelStyle: TextStyle(
                    color: AppColors.green,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a delta humidity';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.deltaHumidity = double.tryParse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Freezer status',
                  labelStyle: TextStyle(
                    color: AppColors.green,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a freezer status';
                  }
                  return null;
                },
                onSaved: (value) {
                  formData.freezerStatus = int.tryParse(value!);
                },
              ),
              CheckboxListTile(
                title: const Text('Nebulizer status'),
                value: formData.nebulizerStatus ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    formData.nebulizerStatus = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Map<String, dynamic> jsonData = formData.toJson();
                    print('THIS IS ===== $jsonData');
                    try {
                      await Dio().post(
                        'http://192.168.1.7:8000/transport',
                        data: jsonData,
                      );
                    } catch (e) {
                      print('ERORRR $e');
                    }
                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

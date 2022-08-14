import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:learnflutternew/Courses.dart';
import 'package:learnflutternew/model/shoes_model.dart';

abstract class ShoesStotage {
  Future<List<ShoesModel>> load();
}

class AssetShoesStorage extends ShoesStotage {
  @override
  Future<List<ShoesModel>> load() async {
    final jsonContent = await rootBundle.loadString('mock/api.json');
    final List jsonData = jsonDecode(jsonContent) as List<dynamic>;

    return jsonData.map((e) => ShoesModel.fromJson(e)).toList();
  }
}

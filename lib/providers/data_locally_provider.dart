import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:instagram/models/data_locally_model.dart';

class DataLocallyProvider extends ChangeNotifier {
  final _boxData = Hive.box('dataView');
  final List<DataLocally> _data = [];

  List<DataLocally> get data => _data;

  int get length => _data.length;

  void loadData() {
    if (_data.isEmpty) {
      for (final data in _boxData.values) {
        _data.add(DataLocally.fromSnap(data));
      }
    }
    // print(_boxData.values);
    // _data.add(DataLocally.fromMap(_boxData.get("LISTDATA")));
    // print((_boxData.get("LISTDATA")));
  }

  void insertData(DataLocally data) {
    _data.insert(0, data);
    // _boxData.add(data.toMap());
    _boxData.put("LISTDATA", data.toMap());
    notifyListeners();
  }

  void updateData({required int index, String? title, String? content}) {
    final data = DataLocally(id: null, title: title, content: content);
    _data[index].title = title;
    _data[index].content = content;

    _boxData.put(
      "LISTDATA",
      data.toMap(),
    );
    notifyListeners();
  }

  void deleteData(DataLocally data) {
    _data.remove(data);
    _boxData.delete("LISTDATA");
    notifyListeners();
  }

  void removeDataAtIndex({required int index}) {
    _data.removeAt(index);
    _boxData.delete("LISTDATA");
    notifyListeners();
  }
}

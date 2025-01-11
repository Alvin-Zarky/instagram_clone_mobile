import 'package:flutter/material.dart';
import 'package:instagram/models/data_locally_model.dart';
import 'package:instagram/providers/data_locally_provider.dart';
import 'package:provider/provider.dart';

class ListDataService {
  final BuildContext context;
  ListDataService({required this.context});

  void insertData({
    required String title,
    required String content,
  }) {
    final DataLocally data = DataLocally(title: title, content: content);
    Provider.of<DataLocallyProvider>(context, listen: false).insertData(data);
  }

  void updateData({
    required String title,
    required String content,
    required int index,
  }) {
    Provider.of<DataLocallyProvider>(context, listen: false)
        .updateData(index: index, title: title, content: content);
  }

  void deleteData(DataLocally data) {
    Provider.of<DataLocallyProvider>(context, listen: false).deleteData(data);
  }
}

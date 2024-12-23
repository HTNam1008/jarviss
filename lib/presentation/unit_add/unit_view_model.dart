import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/data/data_source/remote_data_source.dart';
import 'package:jarvis/data/network/app_kb_api.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/domain/usecase/upload_local_file_usecase.dart';

import '../base/baseviewmodel.dart';

class UnitViewModel extends BaseViewModel {
  final UploadLocalFileUsecase _uploadLocalFileUsecase;

  UnitViewModel(this._uploadLocalFileUsecase);

  final StreamController<String> _errorStreamController = StreamController<String>.broadcast();


  Future<void> uploadLocalFile(String knowledgeId, String filePath) async {
    final input = UploadLocalFileParams(
        id: knowledgeId,
        file:  File(filePath)
    );
    (await _uploadLocalFileUsecase.execute(input)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (_) {}
    );
  }
  @override
  void dispose() {
    _errorStreamController.close();
    super.dispose();
  }
  @override
  Future<void> navigateNamed(BuildContext context, String route) {
    // TODO: implement navigateNamed
    throw UnimplementedError();
  }

  @override
  Future<void> navigateReplaceNamed(BuildContext context, String route) {
    // TODO: implement navigateReplaceNamed
    throw UnimplementedError();
  }
}


import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/data/data_source/remote_data_source.dart';
import 'package:jarvis/data/network/app_kb_api.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/domain/usecase/upload_confluence_file_usecase.dart';
import 'package:jarvis/domain/usecase/upload_local_file_usecase.dart';
import 'package:jarvis/domain/usecase/upload_web_file_usecase.dart';

import '../../domain/usecase/upload_slack_file_usecase.dart';
import '../base/baseviewmodel.dart';

class UnitViewModel extends BaseViewModel {
  final UploadLocalFileUsecase _uploadLocalFileUsecase;
  final UploadWebFileUsecase _uploadWebFileUsecase;
  final UploadSlackFileUsecase _uploadSlackFileUsecase;
  final UploadConfluenceFileUsecase _uploadConfluenceFileUsecase;

  UnitViewModel(this._uploadLocalFileUsecase, this._uploadWebFileUsecase, this._uploadSlackFileUsecase, this._uploadConfluenceFileUsecase);

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

  Future<void> uploadWebFile(String knowledgeId, String unitName, String url) async {
    final request = UploadWebFileRequest(
        unitName: unitName,
        webUrl: url
    );
    final input = UploadWebFileParams(
        id: knowledgeId,
        request: request
    );
    (await _uploadWebFileUsecase.execute(input)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (_) {}
    );
  }

  Future<void> uploadSlackFile(String knowledgeId, String unitName, String slackWorkspace, String slackBotToken) async {
    final request = UploadSlackFileRequest(
        unitName: unitName,
        slackWorkspace: slackWorkspace,
        slackBotToken: slackBotToken
    );
    final input = UploadSlackFileParams(
        id: knowledgeId,
        request: request
    );
    (await _uploadSlackFileUsecase.execute(input)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (_) {}
    );
  }

  Future<void> uploadConfluenceFile(String knowledgeId, String unitName, String wikiPageUrl, String confluenceUsername, String confluenceAccessToken) async {
    final request = UploadConfluenceFileRequest(
        unitName: unitName,
        wikiPageUrl: wikiPageUrl,
        confluenceUsername: confluenceUsername,
        confluenceAccessToken: confluenceAccessToken
    );
    final input = UploadConfluenceFileParams(
        id: knowledgeId,
        request: request
    );
    (await _uploadConfluenceFileUsecase.execute(input)).fold(
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


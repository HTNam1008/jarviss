import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/app/app.dart';
import 'package:jarvis/app/di/di.dart';
import 'package:jarvis/presentation/email/email_view.dart';
import 'package:provider/provider.dart';

import 'domain/usecase/create_email_reply_usecase.dart';
import 'domain/usecase/create_response_email_usecase.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(ChangeNotifierProvider(
    create: (_) => EmailViewModel(GetIt.instance.get<CreateEmailReplyUsecase>(),GetIt.instance.get<CreateResponseEmailUsecase>()),
    child: MyApp(),
  ),);
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  void updateAppState() {
    MyApp.instance.appState = 10;
  }

  void getAppState() {
    print(MyApp.instance.appState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                updateAppState();
                getAppState();
              },
              child: const Text('Update and Get App State'),
            ),
            ElevatedButton(
              onPressed: getAppState,
              child: const Text('Get App State'),
            ),
          ],
        ),
      ),
    );
  }
}
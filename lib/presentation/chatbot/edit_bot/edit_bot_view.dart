// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:jarvis/app/di/di.dart';
import 'package:jarvis/presentation/chatbot/edit_bot/edit_bot_viewmodel.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/common/loading_overlay.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class EditBotView extends StatefulWidget {
  final String assistantId;

  const EditBotView({
    super.key,
    required this.assistantId,
  });

  @override
  State<EditBotView> createState() => _EditBotViewState();
}

class _EditBotViewState extends State<EditBotView> {
  late final EditBotViewModel _viewModel;
  
  @override
  void initState() {
    super.initState();
    _viewModel = getIt<EditBotViewModel>();
    _viewModel.start();
    _viewModel.init(widget.assistantId);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomHeaderBar(
        centerWidget: const Text(
          'Edit Bot',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: StreamBuilder<bool>(
        stream: _viewModel.outputIsLoading,
        builder: (context, loadingSnapshot) {
          return LoadingOverlay(
            isLoading: loadingSnapshot.data ?? false,
            child: _buildContent(),
          );
        },
      ),
      /* body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/images/avt.png'),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              _buildInputField('Bot name', 'Super bot', context),
              _buildInputField('Description', 'The bot is an experienced science fiction writer...', context, maxLines: 5),
              _buildInputField('Persona & Prompt', 'Answer in 2 sentences', context, maxLines: 3),
              _buildKnowledgeField(),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(double.infinity, 50), // Full width button
                  ),
                  onPressed: () {
                    // Logic to preview bot
                    _previewBot(context);
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ), */
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/images/chatbot_avt.png'),
                  ),
                ),
              ),
            _buildInputField('Bot name', _viewModel.nameController),
            _buildInputField('Description', _viewModel.descriptionController, maxLines: 5),
            _buildInputField('Instruction', _viewModel.instructionsController, maxLines: 3),
            _buildKnowledgeField(),
            const SizedBox(height: 40.0),
            _buildSaveButton(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          // ...existing decoration...
        ),
      ),
    );
  }

  void _previewBot(BuildContext context) {
    // Logic to handle preview action
    // You can show a dialog, navigate to another screen, etc.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Preview Bot'),
          content: const Text('This is a preview of the bot.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: StreamBuilder<bool>(
        stream: _viewModel.outputIsAllInputValid,
        builder: (context, snapshot) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              // ...existing style...
            ),
            onPressed: (snapshot.data ?? false) ? _onSavePressed : null,
            child: const Text('Save'),
          );
        },
      ),
    );
  }

  void _onSavePressed() async {
    final success = await _viewModel.updateBot();
    if (success) {
      Navigator.pop(context, _viewModel.assistant); // Return true to indicate update success
    }
  }

  /* Widget _buildInputField(String label, String preFilledText, BuildContext context, {int maxLines = 1}) {
    TextEditingController controller = TextEditingController(text: preFilledText);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: InputDecorationTheme(
            floatingLabelStyle: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelStyle: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.teal,
                width: 1.0,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          ),
        ),
      ),
    );
  } */

  Widget _buildKnowledgeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Knowledge',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.teal), // Set border color and width
                      borderRadius: BorderRadius.circular(AppSize.s8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Text(
                      '4 units',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    ),
                    onPressed: () {
                      // Add knowledge logic
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

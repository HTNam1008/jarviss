// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:jarvis/app/di/di.dart';
import 'package:jarvis/data/responses/ai_bot/get_knowledge_relation_response.dart';
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
          final isLoading = loadingSnapshot.data ?? false;
          return LoadingOverlay(
            isLoading: isLoading,
            child: _buildContent(isLoading),
          );
        },
      ),
    );
  }

  Widget _buildContent(bool isLoading) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(top: 30.0),
                child: const Center(
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/images/chatbot_avt.png'),
                  ),
                ),
              ),
            _buildInputField('Bot name', _viewModel.nameController),
            _buildInputField('Description', _viewModel.descriptionController, maxLines: 5),
            _buildInputField('Instruction', _viewModel.instructionsController, maxLines: 3),
            _buildKnowledgeField(isLoading),
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

  Widget _buildKnowledgeField(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.s10),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(AppPadding.p16),
              child: Text(
                'Knowledge',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StreamBuilder<List<KnowledgeRelation>>(
              stream: _viewModel.outputKnowledge,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                   return const SizedBox.shrink();
                }
                final knowledgeList = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: knowledgeList.length,
                  itemBuilder: (context, index) {
                    final knowledge = knowledgeList[index];
                    return ListTile(
                      title: Text(knowledge.knowledgeName),
                      subtitle: Text(knowledge.description),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: knowledge.isImported ? Colors.red : ColorManager.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: isLoading ? null : () => 
                          _viewModel.toggleKnowledge(knowledge.id),
                        child: Text(knowledge.isImported ? 'Remove' : 'Add'),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

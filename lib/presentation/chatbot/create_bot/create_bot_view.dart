import 'package:flutter/material.dart';
import 'package:jarvis/app/di/di.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/presentation/chatbot/create_bot/create_bot_viewmodel.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/common/loading_overlay.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class CreateBotView extends StatefulWidget {
  const CreateBotView({super.key});

  @override
  State<CreateBotView> createState() => _CreateBotViewState();
}

class _CreateBotViewState extends State<CreateBotView> {
  late final CreateBotViewModel _viewModel;
  // final Set<String> _importedKnowledgeIds = {};

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<CreateBotViewModel>();
    _viewModel.start();
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
          'Create Bot',
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
            Navigator.pop(context);
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
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30.0),
              child: const Center(
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage('assets/images/avt.png'),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            _buildInputField('Bot name', 'Enter bot name', _viewModel.nameController),
            _buildInputField('Description', 'Example: You are an experienced...', _viewModel.descriptionController, maxLines: 5),
            _buildInputField('Instruction', 'Example: Answer in 2 sentences', _viewModel.instructionsController, maxLines: 3),
            _buildKnowledgeField(),
            const SizedBox(height: 40.0),
            _buildPreviewButton(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: const InputDecorationTheme(
            floatingLabelStyle: TextStyle(
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
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
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
  }

  Widget _buildKnowledgeField() {
    return StreamBuilder<Set<String>>(
        stream: _viewModel.outputSelectedIds,
        builder: (context, snapshot) {
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Knowledge',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<List<KnowledgeData>>(
                    stream: _viewModel.outputKnowledge,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final knowledgeList = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: knowledgeList.length,
                        itemBuilder: (context, index) {
                          final knowledge = knowledgeList[index];
                          final isSelected = _viewModel.isKnowledgeSelected(knowledge.id);

                          return ListTile(
                            title: Text(knowledge.knowledgeName),
                            subtitle: Text(knowledge.description),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected ? Colors.red : ColorManager.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () => setState(() {
                                _viewModel.toggleKnowledge(knowledge.id);
                              }),
                              child: Text(isSelected ? 'Remove' : 'Add',
                              style: TextStyle(
                                color: Colors.white
                              )),
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
        });
  }

/*   Future<void> _handleSaveAndPreview() async {
    final success = await _viewModel.createBot();
    if (success && mounted) {
      Navigator.pop(context);
    }
  } */

  Widget _buildPreviewButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: StreamBuilder<bool>(
        stream: _viewModel.outputIsAllInputValid,
        builder: (context, snapshot) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            onPressed: (snapshot.data ?? false) ? _onPreviewPressed : null,
            child: const Text('Save and Preview bot'),
          );
        },
      ),
    );
  }

  void _onPreviewPressed() async {
    final success = await _viewModel.createBot();
    if (success) {
      Navigator.of(context).pop(true);
      Navigator.of(context).pushNamed(
        Routes.previewBotRoute,
        arguments: _viewModel.createdAssistant!,
      );
    }
  }
}

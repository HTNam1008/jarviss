import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/presentation/common/animated_toggle_tab/animated_toggle_tab.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/prompt/create_prompt/create_prompt_view.dart';
import 'package:jarvis/presentation/prompt/edit_prompt/edit_prompt_view.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

import '../../domain/model/prompt.dart';
import '../../domain/usecase/get_public_prompts_usecase.dart';
import '../base/baseviewmodel.dart';


class PromptView extends StatefulWidget {
  const PromptView({super.key});

  @override
  State<PromptView> createState() => _PromptViewState();
}

class _PromptViewState extends State<PromptView> {
  int _selectedIndexTab = 0;
  bool _isFavourite = false;
  bool _isPublicPrompts = false;
  late final PromptViewModel _viewModel;
  bool _isInitialized = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.instance<PromptViewModel>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _viewModel.getPrompts("all");
      _isInitialized = true;
    }
  }

  // Danh sách dữ liệu cho các tab
  final List<List<String>> _myPromptDataTab = [
    ['MyPrompt A1', 'MyPrompt A2', 'MyPrompt A3','MyPrompt A1', 'MyPrompt A2', 'MyPrompt A3','MyPrompt A1', 'MyPrompt A2', 'MyPrompt A3','MyPrompt A1', 'MyPrompt A2', 'MyPrompt A3','MyPrompt A1', 'MyPrompt A2', 'MyPrompt A3'],
    ['MyPrompt B1', 'MyPrompt B2', 'MyPrompt B3'],
    ['MyPrompt C1', 'MyPrompt C2', 'MyPrompt C3'],
    ['MyPrompt D1', 'MyPrompt D2', 'MyPrompt D3'],
    ['MyPrompt E1', 'MyPrompt E2', 'MyPrompt E3'],
    ['MyPrompt A1', 'MyPrompt A2', 'MyPrompt A3'],
    ['MyPrompt B1', 'MyPrompt B2', 'MyPrompt B3'],
    ['MyPrompt C1', 'MyPrompt C2', 'MyPrompt C3'],
    ['MyPrompt D1', 'MyPrompt D2', 'MyPrompt D3'],
    ['MyPrompt E1', 'MyPrompt E2', 'MyPrompt E3'],
    ['MyPrompt A1', 'MyPrompt A2', 'MyPrompt A3'],
    ['MyPrompt B1', 'MyPrompt B2', 'MyPrompt B3'],
    ['MyPrompt C1', 'MyPrompt C2', 'MyPrompt C3'],
    ['MyPrompt D1', 'MyPrompt D2', 'MyPrompt D3'],
    ['MyPrompt E1', 'MyPrompt E2', 'MyPrompt E3'],
  ];

  final List<List<String>> _publicPromptDataTab = [
    ['Public Prompt 1', 'Public Prompt 2', 'Public Prompt 3'],
    ['Public Prompt 11', 'Public Prompt 22', 'Public Prompt 33'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeaderBar(
        centerTitle: true,
        centerWidget: const Text(
          "Prompt Libraries",
          style: TextStyle(
            fontSize: AppSize.s20,
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(AppSize.s6),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorManager.teal,
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s8, vertical: AppSize.s6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CreatePromptView();
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      size: 14,
                    ),
                    const SizedBox(width: 4,),
                    Text(
                      'Create',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.teal[50],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppSize.s12),
              child: AppinioAnimatedToggleTab(
                callback: (int i) {
                  setState(() {
                    _isPublicPrompts = !_isPublicPrompts;
                    _selectedIndexTab = 0;
                  });
                },
                tabTexts: const [
                  'My Prompts',
                  'Public Prompts',
                ],
                height: 50,
                width: 405,
                boxDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSize.s8),
                ),
                animatedBoxDecoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFc3d2db).withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  color: ColorManager.teal,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSize.s8),
                  ),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                activeStyle: const TextStyle(
                  color: Colors.white,
                ),
                inactiveStyle: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            // Thanh tìm kiếm
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.mic),
                          onPressed: () {},
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(color: ColorManager.teal),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _generateListTab(_isPublicPrompts ? _publicPromptDataTab : _myPromptDataTab),
              ),
            ),
            Expanded(
              child: _generateListData(_isPublicPrompts ? _publicPromptDataTab : _myPromptDataTab),
            ),
          ],
        ),
      ),
    );
  }

  void _showActions(BuildContext context, String botName) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  showDialog(context: context, builder: (builder) => const EditPromptView());
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _generateListTab(List<List<String>> promptData) {
    final categories = _viewModel.getPromptCategories();
    return List.generate(categories.length, (index) {
      final bool isSelected = _selectedIndexTab == index;
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndexTab = index;
            _viewModel.getPrompts(categories[index]); // Trigger new category filter
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.teal : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            categories[index],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget _generateListData(List<List<String>> promptData) {
    return StreamBuilder<List<Prompt>>(
        stream: _viewModel.promptsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final prompt = snapshot.data![index];
                return Container(
                  margin: EdgeInsets.symmetric(
                      vertical: AppSize.s6, horizontal: AppSize.s8),
                  padding: EdgeInsets.all(AppSize.s4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(prompt.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSize.s14,
                      ),
                    ),
                    subtitle: Text(
                      prompt.description ?? '',
                      style: TextStyle(
                        fontSize: AppSize.s14,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isFavourite = !_isFavourite;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,
                                top: 8.0,
                                bottom: 8.0),
                            child: Icon(
                              Icons.star,
                              color: _isFavourite ? Colors.yellow : Colors.grey,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showActions(context,
                                promptData[_selectedIndexTab][index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.more_vert, color: Colors.grey,),
                          ),
                        ),
                      ],
                    ),
                    contentPadding: const EdgeInsets.only(left: AppSize.s8),
                    onTap: () {
                      // Khi nhấn vào item, chuyển đến một trang mới
                    },
                  ),
                );
              },
            );
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading prompts'));
          }
          // Add a default return for loading state
          return const Center(child: CircularProgressIndicator());
        },
    );
  }


  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class PromptViewModel extends BaseViewModel {
  final GetPublicPromptsUseCase _getPublicPromptsUseCase;
  final StreamController<List<Prompt>> _promptsStreamController = StreamController<List<Prompt>>();
  final StreamController<String> _errorStreamController = StreamController<String>();

  Stream<List<Prompt>> get promptsStream => _promptsStreamController.stream;
  Stream<String> get errorStream => _errorStreamController.stream;

  PromptViewModel(this._getPublicPromptsUseCase);

  Future<void> getPrompts(String category) async {
    String normalizedCategory = category.toLowerCase();
    normalizedCategory = normalizedCategory == 'all' ? category : normalizedCategory;

    (await _getPublicPromptsUseCase.execute(normalizedCategory)).fold(
            (failure) {
          _errorStreamController.add(failure.message);
        },
            (prompts) {
          _promptsStreamController.add(prompts);
        }
    );
  }

  List<String> getPromptCategories() {
    return [
      'All',
      'Marketing',
      'Business',
      'SEO',
      'Writing',
      'Coding',
      'Career',
      'Chatbot',
      'Education',
      'Fun',
      'Productivity',
      'Other'
    ];
  }
  @override
  void dispose() {
    _promptsStreamController.close();
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
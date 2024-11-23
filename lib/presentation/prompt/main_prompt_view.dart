import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/domain/usecase/delete_prompt_usecase.dart';
import 'package:jarvis/domain/usecase/update%20_prompt_usecase.dart';
import 'package:jarvis/presentation/common/animated_toggle_tab/animated_toggle_tab.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/prompt/create_prompt/create_prompt_view.dart';
import 'package:jarvis/presentation/prompt/edit_prompt/edit_prompt_view.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

import '../../data/request/request.dart';
import '../../domain/model/prompt.dart';
import '../../domain/usecase/create_prompt_usecase.dart';
import '../../domain/usecase/get_public_prompts_usecase.dart';
import '../base/baseviewmodel.dart';


class PromptView extends StatefulWidget {
  const PromptView({super.key});

  @override
  State<PromptView> createState() => _PromptViewState();
}

class _PromptViewState extends State<PromptView> {
  final TextEditingController _searchController = TextEditingController();
  String _currentCategory = 'All';
  int _selectedIndexTab = 0;
  bool _isPublicPrompts = false;
  late final PromptViewModel _viewModel;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.instance<PromptViewModel>();

    _searchController.addListener(() {
      if (!_searchController.text.isNotEmpty) {
        _viewModel.clearSearch();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _viewModel.getPrivatePrompts(_currentCategory); // Add this
      _viewModel.getPrompts(_currentCategory);
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
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => FavoritePromptsModal(viewModel: _viewModel),
              );
            },
          ),
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
              child:  AppinioAnimatedToggleTab(
                callback: (int i) {
                  setState(() {
                    _isPublicPrompts = i == 1;
                    _viewModel.setPublicMode(i == 1);
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
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _viewModel.clearSearch();
                          },
                        )
                            : null,
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
                      onSubmitted: (value) {
                        _executeSearch();
                      },
                    ),
                  ),
                  // Search Button
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _executeSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
                children: _generateListTab(),
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
  void _executeSearch() {
    _viewModel.setSearchQuery(_searchController.text);
    _viewModel.executeSearch();
  }


  void _showActions(BuildContext context,  Prompt prompt) {
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
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => EditPromptView(prompt: prompt),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(context, prompt);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Prompt prompt) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Prompt'),
        content: Text('Are you sure you want to delete "${prompt.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _viewModel.deletePrompt(prompt.id);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  List<Widget> _generateListTab() {
    final categories = _viewModel.getPromptCategories();
    return categories.map((category) {
      return StreamBuilder<String>(
          stream: _viewModel.currentCategoryStream,
          initialData: _viewModel.currentCategory,
          builder: (context, snapshot)
      {
        final bool isSelected = _currentCategory == category;
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentCategory = category;
              _viewModel.setCurrentCategory(category);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 10.0),
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.teal : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }
      );
    }).toList();
  }

  @override
  Widget _generateListData(List<List<String>> promptData) {
    final Stream<List<Prompt>> activeStream = _isPublicPrompts ?
    _viewModel.promptsStream :
    _viewModel.privatePromptsStream;
      return StreamBuilder<List<Prompt>>(
        stream: activeStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final prompts = snapshot.data ?? [];

          if (prompts.isEmpty) {
            return _buildEmptyState();
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: prompts.length,
              itemBuilder: (context, index) => _buildPromptItem(prompts[index]),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _searchController.text.isNotEmpty ? Icons.search_off : Icons.list,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            _searchController.text.isNotEmpty
                ? 'No prompts found for "${_searchController.text}"'
                : 'No prompts found in this category',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          if (_searchController.text.isNotEmpty) ...[
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                _searchController.clear();
                _viewModel.clearSearch();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Clear Search'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPromptItem(Prompt prompt) {
    return InkWell(
        onTap: () {
      showDialog(
        context: context,
        builder: (context) => PromptDetailDialog(prompt: prompt),
      );
      },
      child: Container(
      margin: const EdgeInsets.symmetric(vertical: AppSize.s6, horizontal: AppSize.s8),
      padding: const EdgeInsets.all(AppSize.s4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.s12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          prompt.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppSize.s14,
          ),
        ),
        subtitle: Text(
          prompt.description,
          style: TextStyle(
            fontSize: AppSize.s14,
            color: Colors.grey,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.star,
                color: prompt.isFavorite ? Colors.yellow : Colors.grey,
              ),
              onPressed: () => _viewModel.toggleFavorite(prompt),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showActions(context, prompt),
            ),
          ],
        ),
      ),
    ),
    );
  }
  @override
  void dispose() {
    _viewModel.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class PromptViewModel extends BaseViewModel {
  final GetPublicPromptsUseCase _getPublicPromptsUseCase;
  final GetPrivatePromptsUseCase _getPrivatePromptsUseCase;
  final AddPromptToFavoriteUseCase _addPromptToFavoriteUseCase;
  final CreatePromptUseCase _createPromptUseCase;
  final UpdatePromptUseCase _updatePromptUseCase;
  final DeletePromptUseCase _deletePromptUseCase;

  bool showFavorites = false;
  String _currentCategory = 'all';
  bool _isPublicMode = false;
  List<Prompt> prompts = [];


  final StreamController<List<Prompt>> _promptsStreamController = StreamController<List<Prompt>>.broadcast();
  final StreamController<String> _errorStreamController = StreamController<String>.broadcast();
  final StreamController<List<Prompt>> _favoritesStreamController = StreamController<List<Prompt>>.broadcast();
  final StreamController<List<Prompt>> _privatePromptsStreamController = StreamController<List<Prompt>>.broadcast();
  final StreamController<String> _currentCategoryController = StreamController<String>.broadcast();


  Stream<String> get currentCategoryStream => _currentCategoryController.stream;
  String get currentCategory => _currentCategory;
  List<Prompt> favoritePrompts = [];
  List<Prompt> privatePrompts = [];
  String _searchQuery = '';

  Stream<List<Prompt>> get promptsStream => _promptsStreamController.stream;
  Stream<List<Prompt>> get favoritesStream => _favoritesStreamController.stream;
  Stream<List<Prompt>> get privatePromptsStream => _privatePromptsStreamController.stream;
  Stream<String> get errorStream => _errorStreamController.stream;

  PromptViewModel(this._getPublicPromptsUseCase, this._addPromptToFavoriteUseCase, this._createPromptUseCase, this._getPrivatePromptsUseCase, this._updatePromptUseCase, this._deletePromptUseCase);

  // Helper method to refresh the current view based on mode and category
  void refreshCurrentView() {
    if (_isPublicMode) {
      getPrompts(_currentCategory, query: _searchQuery);
    } else {
      getPrivatePrompts(_currentCategory, query: _searchQuery);
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    refreshCurrentView();  // Refresh with new search query
  }

  void executeSearch() {
    refreshCurrentView(); // Only refresh when search is executed
  }

  void clearSearch() {
    _searchQuery = '';
    refreshCurrentView();
  }

  Future<void> getPrompts(String category, {bool? isFavorite, String? query, int? limit}) async {
    final input = GetPublicPromptsUseCaseInput(
        category.toLowerCase(),
        isFavorite: isFavorite,
        query: query?.isNotEmpty == true ? query : null,
        limit: (limit != null) == true ? limit : 50
    );

    (await _getPublicPromptsUseCase.execute(input)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (fetchedPrompts) {
          prompts = fetchedPrompts;
          log(prompts.toString());
          _promptsStreamController.add(prompts);
        }
    );
  }

  Future<void> getPrivatePrompts(String category,  {bool? isFavorite, String? query}) async {
    final input = GetPublicPromptsUseCaseInput(
        category.toLowerCase(),
        isFavorite: isFavorite,
        query: query?.isNotEmpty == true ? query : null

    );

    (await _getPrivatePromptsUseCase.execute(input)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (prompts) {
          privatePrompts = prompts;
          _privatePromptsStreamController.add(privatePrompts);
        }
    );
  }

  Future<void> getFavoritePrompts() async {
    final input = GetPublicPromptsUseCaseInput("all", isFavorite: true);
    final input2 = GetPublicPromptsUseCaseInput("all", isFavorite: true);

    (await _getPublicPromptsUseCase.execute(input)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (fetchedPrompts) {
          favoritePrompts = fetchedPrompts;
          _favoritesStreamController.add(favoritePrompts);
        }
    );
    (await _getPrivatePromptsUseCase.execute(input2)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (fetchedPrompts) {
          favoritePrompts = favoritePrompts + fetchedPrompts;
          _favoritesStreamController.add(favoritePrompts);
        }
    );
  }
  Future<void> toggleFavorite(Prompt prompt) async {
    final result = await _addPromptToFavoriteUseCase.execute(prompt.id);

    result.fold(
            (failure) => _errorStreamController.add(failure.message),
            (_) {
          final index = prompts.indexWhere((p) => p.id == prompt.id);
          if (index != -1) {
            prompts[index] = Prompt(
              id: prompt.id,
              title: prompt.title,
              content: prompt.content,
              description: prompt.description,
              category: prompt.category,
              isPublic: prompt.isPublic,
              userName: prompt.userName,
              isFavorite: !prompt.isFavorite,
            );
            if (_isPublicMode){
              _promptsStreamController.add(prompts);
            }
            else{
              _privatePromptsStreamController.add(prompts);
            }
            refreshCurrentView();
          }
        }
    );
  }
  Future<void> createPrompt(String title, String content, String description,
      String category, String language, bool isPublic) async {
    final request = CreatePromptRequest(
        title: title,
        content: content,
        description: description,
        category: category,
        language: language,
        isPublic: isPublic
    );

    (await _createPromptUseCase.execute(request)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (_) {
              refreshCurrentView(); // Refresh the list after creating
            }
    );
  }

  Future<void> updatePrompt(String id, String title,String content, String description, String category, bool isPublic, String language) async {
    final request = UpdatePromptUseCaseInput(id, title, content, description, category, language, isPublic);
    (await _updatePromptUseCase.execute(request)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (_) {
                 refreshCurrentView(); // Refresh the list after updating
            }
    );
  }

  Future<void> deletePrompt(String id) async {
    (await _deletePromptUseCase.execute(id)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (_) {
              refreshCurrentView(); // Refresh the list after updating
            }
    );
  }

  void setCurrentCategory(String category) {
    _currentCategory = category;
    log("rest:"+_currentCategory);
    if (_isPublicMode) {
      getPrompts(category);
    } else {
      getPrivatePrompts(category);
    }
  }

  // Update mode (public/private) and refresh prompts
  void setPublicMode(bool isPublic) {
    _isPublicMode = isPublic;
    if (isPublic) {
      getPrompts(_currentCategory);
    } else {
      getPrivatePrompts(_currentCategory);
    }
  }
  String getCurrentCategory() => _currentCategory;

  void toggleFavoriteFilter() {
    showFavorites = !showFavorites;
    getPrompts('All');
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
    _favoritesStreamController.close();
    _privatePromptsStreamController.close();
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

class FavoritePromptsModal extends StatefulWidget {
  final PromptViewModel viewModel;

  const FavoritePromptsModal({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<FavoritePromptsModal> createState() => _FavoritePromptsModalState();
}

class _FavoritePromptsModalState extends State<FavoritePromptsModal> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getFavoritePrompts();  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(AppSize.s16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Favorite Prompts",
                  style: TextStyle(
                    fontSize: AppSize.s20,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s16),
            Expanded(
              child: StreamBuilder<List<Prompt>>(
                stream: widget.viewModel.favoritesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("No favorite prompts yet"),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final prompt = snapshot.data![index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: AppSize.s6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              prompt.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppSize.s14,
                              ),
                            ),
                            subtitle: Text(
                              prompt.description ?? '',
                              style: const TextStyle(
                                fontSize: AppSize.s14,
                                color: Colors.grey,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.star, color: Colors.yellow),
                              onPressed: () {
                                widget.viewModel.toggleFavorite(prompt);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading favorites'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromptDetailDialog extends StatelessWidget {
  final Prompt prompt;

  const PromptDetailDialog({
    required this.prompt,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(AppSize.s20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prompt.title,
                        style: const TextStyle(
                          fontSize: AppSize.s20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSize.s4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSize.s8,
                              vertical: AppSize.s4,
                            ),
                            decoration: BoxDecoration(
                              color: ColorManager.teal.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppSize.s12),
                            ),
                            child: Text(
                              prompt.category.toUpperCase(),
                              style: TextStyle(
                                fontSize: AppSize.s12,
                                color: ColorManager.teal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSize.s8),
                          Text(
                            'By ${prompt.userName}',
                            style: TextStyle(
                              fontSize: AppSize.s12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  iconSize: AppSize.s20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s16),

            // Description
            if (prompt.description.isNotEmpty) ...[
              Text(
                'Description',
                style: TextStyle(
                  fontSize: AppSize.s14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: AppSize.s8),
              Text(
                prompt.description,
                style: TextStyle(
                  fontSize: AppSize.s14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: AppSize.s16),
            ],

            // Content
            Text(
              'Content',
              style: TextStyle(
                fontSize: AppSize.s14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: AppSize.s8),
            Container(
              padding: const EdgeInsets.all(AppSize.s12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(AppSize.s8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.3,
              ),
              child: SingleChildScrollView(
                child: Text(
                  prompt.content,
                  style: const TextStyle(fontSize: AppSize.s14),
                ),
              ),
            ),
            const SizedBox(height: AppSize.s20),

            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Favorite button
                IconButton(
                  onPressed: () {
                    GetIt.instance<PromptViewModel>().toggleFavorite(prompt);
                  },
                  icon: Icon(
                    prompt.isFavorite ? Icons.star : Icons.star_border,
                    color: prompt.isFavorite ? Colors.amber : Colors.grey,
                  ),
                ),
                const SizedBox(width: AppSize.s8),
                // Copy button
                ElevatedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: prompt.content));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Prompt content copied to clipboard'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy, size: 16),
                  label: const Text('Copy'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.teal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s16,
                      vertical: AppSize.s8,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
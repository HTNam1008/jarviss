import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/domain/usecase/create_knowledge_usecase.dart';
import 'package:jarvis/domain/usecase/update_knowledge_usecase.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/knowledge/knowledge_create/knowledge_create.dart';
import 'package:jarvis/presentation/knowledge/knowledge_detail/knowledge_detail.dart';
import 'package:jarvis/presentation/knowledge/knowledge_edit/knowledge_edit.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

import '../../app/constant.dart';
import '../../data/responses/ai_bot/get_assistants_response.dart';
import '../../domain/usecase/delete_knowledge_usecase.dart';
import '../../domain/usecase/get_knowledge_usecase.dart';
import '../base/baseviewmodel.dart';

class KnowledgeView extends StatefulWidget {
  const KnowledgeView({super.key});

  @override
  State<KnowledgeView> createState() => _KnowledgeViewState();
}

class _KnowledgeViewState extends State<KnowledgeView> {
  final TextEditingController _searchController = TextEditingController();
  late KnowledgeViewModel _viewModel;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.instance<KnowledgeViewModel>();

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
      _viewModel.getKnowledge(null, 0, null, null, null); // Initial fetch
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: CustomHeaderBar(
        centerWidget: const Text(
          'Knowledge',
          style: TextStyle(
            color: Colors.white,
            fontSize: AppSize.s20,
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(AppSize.s6),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorManager.teal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s8, vertical: AppSize.s6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  showDialog(context: context, builder: (builder) => const CreateKnowledgeView());
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.add,
                      size: 14,
                    ),
                    SizedBox(width: 4,),
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
        centerTitle: true,
      ),
      body: Container(
        color: Colors.teal[50],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 10, right: 10, left: 10),
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
                          borderSide: const BorderSide(color: Colors.grey),
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
            Expanded(
                child: StreamBuilder<List<KnowledgeData>>(
                  stream: _viewModel.knowledgeStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No knowledge items found.'));
                    } else {
                      final knowledgeList = snapshot.data!;
                      return ListView.builder(
                        itemCount: knowledgeList.length,
                        itemBuilder: (context, index) {
                          final knowledge = knowledgeList[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: AppSize.s6, horizontal: AppSize.s8),
                            padding: const EdgeInsets.all(AppSize.s8),
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
                              leading: const CircleAvatar(
                                child: Icon(Icons.article_outlined),
                              ),
                              title: Text(
                                knowledge.knowledgeName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSize.s14,
                                ),
                              ),
                              subtitle: Text(
                                knowledge.description,
                                style: const TextStyle(
                                  fontSize: AppSize.s14,
                                  color: Colors.grey,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.more_vert),
                                onPressed: () {
                                  _showActions(context, knowledge);
                                },
                                color: Colors.grey,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailKnowledgeView(knowledge: knowledge),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
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
  void _showActions(BuildContext context, KnowledgeData knowledge) {
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
                  showDialog(context: context, builder: (builder) => EditKnowledgeView(knowledge:knowledge));
                  // Navigate to edit view with selected knowledge item
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(context, knowledge);                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, KnowledgeData knowledge) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Prompt'),
        content: Text('Are you sure you want to delete "${knowledge.knowledgeName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _viewModel.deleteKnowledge(knowledge.index);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  bool get wantKeepAlive => true;
}

class KnowledgeViewModel extends BaseViewModel {
  final GetKnowledgeUsecase _getKnowledgeUseCase;
  final CreateKnowledgeUsecase _createKnowledgeUsecase;
  final UpdateKnowledgeUseCase _updateKnowledgeUseCase;
  final DeleteKnowledgeUsecase _deleteKnowledgeUsecase;

  final StreamController<List<KnowledgeData>> _knowledgeStreamController = StreamController<List<KnowledgeData>>.broadcast();
  final StreamController<String> _errorStreamController = StreamController<String>.broadcast();

  List<KnowledgeData> knowledgeList = [];
  String _searchQuery = '';

  Stream<List<KnowledgeData>> get knowledgeStream => _knowledgeStreamController.stream;

  KnowledgeViewModel(this._getKnowledgeUseCase, this._createKnowledgeUsecase, this._updateKnowledgeUseCase, this._deleteKnowledgeUsecase);

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

  Future<void> getKnowledge(int? limit, int? offset, EnumOrder? order, String? orderField, String? q) async {
    final input = GetKnowledgeUseCaseInput(
        limit: (limit != null) == true ? limit : 50,
        offset: offset,
        order: order,
        orderField: orderField,
        q: q
    );
    (await _getKnowledgeUseCase.execute(input)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (fetchedKnowledge) {
          knowledgeList = fetchedKnowledge.data;
          log(knowledgeList.toString());
          _knowledgeStreamController.add(knowledgeList);
          log('Fetched knowledge count: ${knowledgeList.length}');
        }
    );
  }
  
  Future<void> createKnowledge(String knowledgeName,String? description) async {
    final request = CreateKnowledgeRequest(
        knowledgeName: knowledgeName,
        description: description
    );

    (await _createKnowledgeUsecase.execute(request)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (_) {
            refreshCurrentView(); // Refresh the list after creating
        }
    );
  }

  Future<void> updatePrompt(String id, String knowledgeName,String? description) async {
    final request = CreateKnowledgeRequest(
        knowledgeName: knowledgeName,
        description: description
    );

    final input = UpdateKnowledgeParams(
        id: id,
        request: request
    );
    (await _updateKnowledgeUseCase.execute(input)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (_) {
          refreshCurrentView(); // Refresh the list after updating
        }
    );
  }

  Future<void> deleteKnowledge(String id) async {
    (await _deleteKnowledgeUsecase.execute(id)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (_) {
          refreshCurrentView(); // Refresh the list after updating
        }
    );
  }

  void refreshCurrentView(){
    getKnowledge(null, 0, null, null,_searchQuery!=''?_searchQuery:null);
  }

  @override
  void dispose() {
    _knowledgeStreamController.close();
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

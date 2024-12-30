import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/presentation/chatbot/main_chatbot_viewmodel.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/assets_manager.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class ChatBotMainView extends StatefulWidget {
  const ChatBotMainView({super.key});

  @override
  State<ChatBotMainView> createState() => _ChatBotMainViewState();
}

class _ChatBotMainViewState extends State<ChatBotMainView> {
  // int _selectedIndex = 0;
  final getIt = GetIt.instance;
  late final MainChatbotViewModel _viewModel;
  List<AssistantCustom> _assistants = [];
  List<AssistantCustom> _filteredAssistants = [];
  bool _isLoading = false;
  late StreamSubscription<List<AssistantCustom>> _assistantsSubscription;
  late StreamSubscription<bool> _loadingSubscription;
  final TextEditingController _searchController = TextEditingController();
  BuildContext? _scaffoldContext;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<MainChatbotViewModel>();
    _setupStreams();
    _setupSearchController();
    _viewModel.start();
  }

  void _setupSearchController() {
    _searchController.addListener(() {
      _filterAssistants();
    });
  }

  void _filterAssistants() {
    if (_assistants.isEmpty) return;
    
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredAssistants = List.from(_assistants);
      } else {
        _filteredAssistants = _assistants
            .where((assistant) =>
                assistant.assistantName
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()) ||
                (assistant.description ?? '')
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()))
            .toList();
      }
      
      // Sort by creation time (newest first)
      _filteredAssistants.sort((a, b) => 
        DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt))
      );
    });
  }

  void _setupStreams() {
    _assistantsSubscription = _viewModel.outputAssistants.listen((assistants) {
      setState(() {
        _assistants = assistants;
        _filterAssistants();
      });
    });

    _loadingSubscription = _viewModel.outputIsLoading.listen((loading) {
      setState(() {
        _isLoading = loading;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldContext = context;
  }

  @override
  void dispose() {
    // _viewModel.dispose();
    _searchController.dispose();
    _assistantsSubscription.cancel();
    _loadingSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeaderBar(
        centerTitle: true,
        centerWidget: const Text(
          "Bots",
          style: TextStyle(
              fontSize: AppSize.s20, fontWeight: FontWeightManager.semiBold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(AppSize.s6),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorManager.teal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s8, vertical: AppSize.s6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  final result = await Navigator.pushNamed(context, Routes.createBotRoute);
                  if (result == true) {
                    _viewModel.refreshAssistants();
                  }
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.add,
                      size: 14,
                    ),
                    SizedBox(
                      width: 4,
                    ),
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
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search bots...',
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
                          borderSide: const BorderSide(color: Colors.grey),
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
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshAssistants, // Hàm để làm mới dữ liệu
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _filteredAssistants.isEmpty
                        ? const Center(child: Text('No assistants found'))
                        : ListView.builder(
                            itemCount: _filteredAssistants.length,
                            itemBuilder: (context, index) {
                              return _buildAssistantCard(_filteredAssistants[index]);
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(String message) {
    if (_scaffoldContext != null && mounted) {
      ScaffoldMessenger.of(_scaffoldContext!).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  void _showActions(BuildContext context, String assistantId) {
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
                  Navigator.of(context)
                      .pushNamed(
                    Routes.editBotRoute,
                    arguments: assistantId,
                  )
                      .then((updated) {
                    if (updated != null) {
                      _viewModel.refreshAssistants(); // Refresh list
                    }
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.publish),
                title: const Text('Publish'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .pushNamed(
                    Routes.publishBotRoute,
                    arguments: assistantId,
                  )
                      .then((updated) {
                    if (updated != null) {
                      _viewModel.refreshAssistants(); // Refresh list
                    }
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () async {
                  Navigator.pop(context);
                  final success = await _viewModel.deleteAssistant(assistantId);
                  if (mounted) {
                    if (success) {
                      _showMessage('Assistant deleted successfully');
                      _viewModel.refreshAssistants();
                    } else {
                      _showMessage('Failed to delete assistant');
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAssistantCard(AssistantCustom assistant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.previewBotRoute,
          arguments: assistant,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: AppSize.s6, horizontal: AppSize.s8),
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
            radius: AppSize.s24,
            backgroundImage: AssetImage(ImageAssets.botIc),
          ),
          title: Text(assistant.assistantName),
          subtitle: Text(assistant.description ?? ''),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showActions(context, assistant.id),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshAssistants() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _viewModel.refreshAssistants();
    } catch (e) {
      debugPrint('Error refreshing assistants: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

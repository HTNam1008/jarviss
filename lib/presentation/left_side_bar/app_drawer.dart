import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart'; // Đảm bảo import get_it
import 'package:jarvis/app/di/di.dart';
import 'package:jarvis/data/responses/ai_chat/get_conversations_response.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/presentation/left_side_bar/app_drawer_viewmodel.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';
import 'package:timeago/timeago.dart' as timeago;

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late final AppDrawerViewModel _viewModel;
  bool _isSearching = false;
  String _searchText = '';
  final _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<AppDrawerViewModel>();
    
    _viewModel.getConversations();

    _viewModel.errorStream.listen((errorMessage) {
      if (errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      if (_viewModel.hasMore && !_viewModel.isLoadingMore && !_isSearching) {
        _fetchMoreConversations();
      }
    }
  }

  Future<void> _fetchMoreConversations() async {
    if (_viewModel.cursor == null) return;
    _viewModel.isLoadingMore = true;
    _viewModel.getConversations();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        controller: _scrollController, 
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorManager.teal, 
            ),
            child: Align(
              alignment: Alignment.topLeft, 
              child: Text(
                'CyneAI',
                style: TextStyle(
                  color: ColorManager.white,
                  fontSize: AppSize.s24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.profileRoute);
            },
          ),
          ListTile(
            leading: const Icon(Icons.upgrade),
            title: const Text('Upgrade Pro'),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.upgradeProRoute);
            },
          ),
          ListTile(
            title: _isSearching
                ? TextField(
                    focusNode: _focusNode,
                    onChanged: (text) {
                      setState(() {
                        _searchText = text; 
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search chats...',
                      border: OutlineInputBorder(),
                    ),
                  )
                : const Text('All Chats',
                    style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                    )),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching; 
                  if (!_isSearching) {
                    _searchText = ''; 
                  }
                });
              },
              icon: const Icon(Icons.search),
            ),
          ),
          StreamBuilder<Conversations>(
            stream: _viewModel.conversationsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  _viewModel.chatHistory.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final chatHistory = _viewModel.chatHistory;

                final filteredChatHistory = _isSearching && _searchText.isNotEmpty
                    ? chatHistory
                        .where((conversation) =>
                            conversation.title
                                ?.toLowerCase()
                                .contains(_searchText.toLowerCase()) ??
                            false)
                        .toList()
                    : chatHistory;

                if (filteredChatHistory.isEmpty) {
                  return const Center(child: Text('No chats found.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 0.0),
                  shrinkWrap: true, 
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredChatHistory.length + 1,
                  itemBuilder: (context, index) {
                    if (index < filteredChatHistory.length) {
                      final conversation = filteredChatHistory[index];
                      return Column(
                        children: [
                          ListTile(
                            trailing: IconButton(
                              icon: const Icon(Icons.more_horiz),
                              onPressed: () {
                                _showOptions(context, conversation);
                              },
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  conversation.title ?? 'No Title',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatTimeAgo(conversation.createdAt),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                            },
                          ),
                          const Divider(height: 1),
                        ],
                      );
                    } else {
                      return _viewModel.hasMore
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(child: CircularProgressIndicator()),
                              // child: Center(child: Text("No data 2")),
                            )
                          : const SizedBox.shrink();
                    }
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(int? timestamp) {
    if (timestamp == null) return '';
    final DateTime messageDate =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return timeago.format(messageDate, locale: 'en'); // Sử dụng locale phù hợp
  }

  void _showOptions(BuildContext context, ItemConversation conversation) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete Chat'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.pin_drop),
                title: const Text('Pin Chat'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share Chat'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

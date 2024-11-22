import 'package:flutter/material.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _isSearching = false;
  String _searchText = '';
  final _focusNode = FocusNode();
  final List<String> _chatHistoryTitle = [
    'Chat with Alice',
    'Chat with Bob',
    'Chat with Charlie',
    'Chat with David',
    'Chat with Eve',
    'Chat with Frank',
    'Chat with Grace',
    'Chat with Heidi',
    'Chat with Ivan',
    'Chat with Judy',
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorManager.teal,
            ),
            child: Text(
              'CyneAI',
              style: TextStyle(
                color: ColorManager.white,
                fontSize: AppSize.s24,
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
                        _searchText = text; // Update search text
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
                  _isSearching = !_isSearching; // Toggle search bar
                  if (!_isSearching) {
                    _searchText = ''; // Clear search text when closing
                  }
                });
              },
              icon: const Icon(Icons.search),
            ),
          ),
          // ListView for chat history
          ListView.builder(
            padding: const EdgeInsets.only(top: 0),
            shrinkWrap: true, // Important for nested ListView
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _chatHistoryTitle.length,
            itemBuilder: (context, index) {
              // Filter chat history based on search text
              // if (_isSearching && !_chatHistory[index].toLowerCase().contains(_searchText.toLowerCase())) {
              //   return Container(); // Skip this item
              // }
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.model_training, size: 16),
                            const SizedBox(width: 4),
                            Container(
                                child: const Text('Model',
                                    style: TextStyle(fontSize: 12))),
                          ],
                        ),
                        const Text("October 11, 2024"),
                      ],
                    ),
                    Container(
                      constraints:
                          const BoxConstraints(maxWidth: double.infinity),
                      child: Text(
                        _chatHistoryTitle[index],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    const Icon(Icons.message, size: 16),
                    const SizedBox(width: 4),
                    const Flexible(
                      child: Text(
                        'Last message or additional info',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_horiz))
                  ],
                ),
                onTap: () {
                  // Add action on tap, e.g., navigate to chat details
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

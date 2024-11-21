import 'package:flutter/material.dart';
import 'package:jarvis/presentation/chat/chat_view.dart';
import 'package:jarvis/presentation/chatbot/main_chatbot_view.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/knowledge/knowledge_view.dart';
import 'package:jarvis/presentation/prompt/main_prompt_view.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  bool _isSearching = false;
  String _searchText = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode _focusNode = FocusNode(); // FocusNode to manage focus

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

  List<Widget> body = [
    const ChatView(),
    const ChatBotMainView(),
    const PromptView(),
     KnowledgeView(),
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _isSearching = false; // Close search bar when focus is lost
          // _searchText = ''; // Optionally clear the search text
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
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
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pushNamed(Routes.profileRoute);
              },
            ),
            ListTile(
              leading: Icon(Icons.upgrade),
              title: Text('Upgrade Pro'),
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
                      decoration: InputDecoration(
                        hintText: 'Search chats...',
                        border: OutlineInputBorder(),
                      ),
                    )
                  : Text('All Chats',
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
                icon: Icon(Icons.search),
              ),
            ),
            // ListView for chat history
            ListView.builder(
              padding: EdgeInsets.only(top: 0),
              shrinkWrap: true, // Important for nested ListView
              physics: NeverScrollableScrollPhysics(),
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
                              Icon(Icons.model_training, size: 16),
                              SizedBox(width: 4),
                              Container(child: Text('Model', style: TextStyle(fontSize: 12))),
                            ],
                          ),
                          Text("October 11, 2024"),
                        ],
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: double.infinity),
                        child: Text(
                          _chatHistoryTitle[index],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.message, size: 16),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'Last message or additional info',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
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
      ),
      appBar: _currentIndex == 0
          ? CustomHeaderBar(
              centerWidget: DropdownButton<String>(
                value: 'GPT-4.0',
                dropdownColor: ColorManager.teal,
                style: TextStyle(color: ColorManager.white),
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  
                },
                items: <String>['GPT-4.0', 'GPT-3.5', 'Gemini'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              leading: IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.upgradeProRoute);
                    },
                    child: Text(
                      "Upgrade",
                      style: TextStyle(color: Colors.blue.shade100, fontSize: AppSize.s16),
                    )),
                Container(
                  margin: EdgeInsets.only(right: AppSize.s8),
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s12, vertical: AppSize.s6),
                  decoration: BoxDecoration(
                    color: Colors.teal[400],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: [
                      Text('50', style: TextStyle(color: ColorManager.white, fontSize: AppSize.s16)),
                      SizedBox(width: AppSize.s4),
                      Icon(Icons.star, color: ColorManager.white, size: AppSize.s16),
                    ],
                  ),
                ),
              ],
            )
          : null,
      body: body[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

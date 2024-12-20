import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/app/di/di.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/presentation/chatbot/main_chatbot_viewmodel.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
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
  int _selectedIndex = 0;
  final getIt = GetIt.instance;
  late final MainChatbotViewModel _viewModel;
  // final TextEditingController _searchController = TextEditingController();
  // Danh sách dữ liệu cho các tab
  final List<List<String>> _botData = [
    ['Bot A1', 'Bot A2', 'Bot A3','Bot A1', 'Bot A2', 'Bot A3','Bot A1', 'Bot A2', 'Bot A3','Bot A1', 'Bot A2', 'Bot A3','Bot A1', 'Bot A2', 'Bot A3'],
    ['Bot B1', 'Bot B2', 'Bot B3'],
    ['Bot C1', 'Bot C2', 'Bot C3'],
    ['Bot D1', 'Bot D2', 'Bot D3'],
    ['Bot E1', 'Bot E2', 'Bot E3'],
    ['Bot A1', 'Bot A2', 'Bot A3'],
    ['Bot B1', 'Bot B2', 'Bot B3'],
    ['Bot C1', 'Bot C2', 'Bot C3'],
    ['Bot D1', 'Bot D2', 'Bot D3'],
    ['Bot E1', 'Bot E2', 'Bot E3'],
    ['Bot A1', 'Bot A2', 'Bot A3'],
    ['Bot B1', 'Bot B2', 'Bot B3'],
    ['Bot C1', 'Bot C2', 'Bot C3'],
    ['Bot D1', 'Bot D2', 'Bot D3'],
    ['Bot E1', 'Bot E2', 'Bot E3'], 
  ];

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<MainChatbotViewModel>();
    _viewModel.start();
    // _searchController.addListener(() {
    //   _viewModel.getAssistants(searchQuery: _searchController.text);
    // });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    // _searchController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeaderBar(
        centerTitle: true,
        centerWidget: const Text(
          "Bots",
          style: TextStyle(fontSize: AppSize.s20, fontWeight: FontWeightManager.semiBold),
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
                  Navigator.of(context).pushNamed(Routes.createBotRoute);
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
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.mic),
                          onPressed: () {
                          },
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
            Container(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(_botData.length, (index) {
                  final bool isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
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
                        'Tab ${index + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child: StreamBuilder<bool>(
                stream: _viewModel.outputIsLoading,
                builder: (context, loadingSnapshot) {
                  if (loadingSnapshot.data ?? false) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  return StreamBuilder<List<AssistantData>>(
                    stream: _viewModel.outputAssistants,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text('No assistants found'));
                      }

                      final assistants = snapshot.data!;
                      return ListView.builder(
                        itemCount: assistants.length,
                        itemBuilder: (context, index) {
                          final assistant = assistants[index];
                          return _buildAssistantCard(assistant);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            /* Expanded(
              child: ListView.builder(
                itemCount: _botData[_selectedIndex].length,
                itemBuilder: (context, index) {
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
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: AppSize.s24,
                          backgroundImage: AssetImage('assets/images/avatar.png'),
                        ),
                        const SizedBox(width: AppSize.s12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _botData[_selectedIndex][index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSize.s16,
                                ),
                              ),
                              const SizedBox(height: AppSize.s4),
                              const Text(
                                'A brief description or tagline for the bot.',
                                style: TextStyle(
                                  fontSize: AppSize.s14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: AppSize.s8),
                              const Row(
                                children: [
                                  Text(
                                    'By Monica Team',
                                    style: TextStyle(
                                      fontSize: AppSize.s12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: AppSize.s8),
                                  Icon(
                                    Icons.public,
                                    color: Colors.grey,
                                    size: AppSize.s12,
                                  ),
                                  SizedBox(width: AppSize.s4),
                                  Text(
                                    '9.2k',
                                    style: TextStyle(
                                      fontSize: AppSize.s12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            _showActions(context, _botData[_selectedIndex][index]);
                          },
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ), */
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
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(Routes.editBotRoute);
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

  Widget _buildAssistantCard(AssistantData assistant) {
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
          radius: AppSize.s24,
          backgroundImage: AssetImage('assets/images/avatar.png'),
        ),
        title: Text(assistant.assistantName),
        subtitle: Text(assistant.description ?? ''),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showActions(context, assistant.assistantName),
        ),
      ),
    );
  }
}
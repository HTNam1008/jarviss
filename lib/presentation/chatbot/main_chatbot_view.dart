import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeaderBar(
        centerTitle: true,
        centerWidget: Text(
          "Bots",
          style: TextStyle(fontSize: AppSize.s20, fontWeight: FontWeightManager.semiBold),
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
                  Navigator.of(context).pushNamed(Routes.createBotRoute);
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
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.mic),
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
              child: ListView.builder(
                itemCount: _botData[_selectedIndex].length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: AppSize.s6, horizontal: AppSize.s8),
                    padding: EdgeInsets.all(AppSize.s8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2), // hiệu ứng bóng đổ
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: AppSize.s24,
                          backgroundImage: AssetImage('assets/images/avatar.png'),
                        ),
                        SizedBox(width: AppSize.s12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _botData[_selectedIndex][index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSize.s16,
                                ),
                              ),
                              SizedBox(height: AppSize.s4),
                              Text(
                                'A brief description or tagline for the bot.',
                                style: TextStyle(
                                  fontSize: AppSize.s14,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: AppSize.s8),
                              Row(
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
                          icon: Icon(Icons.more_vert),
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(Routes.editBotRoute);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
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
}
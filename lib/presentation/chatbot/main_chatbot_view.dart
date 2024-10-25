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
            padding: EdgeInsets.all(AppSize.s4),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Define the action for the button press
                  Navigator.of(context).pushNamed(Routes.createBotRoute);
                },
                icon: Icon(Icons.add), // Add your desired icon here
                label: Text('Create'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorManager.teal, // Text color
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s8, vertical: AppSize.s4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0), // Đặt borderRadius cho trạng thái bình thường
                        borderSide: BorderSide(color: Colors.grey), // Màu viền khi không focus
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0), // Đặt borderRadius cho trạng thái focus
                        borderSide: BorderSide(color: ColorManager.teal), // Màu viền khi focus
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(_botData.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Tab ${index + 1}', // Đổi tên tab nếu cần
                      style: TextStyle(
                        fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                        color: _selectedIndex == index ? Colors.blue : Colors.black,
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
                  margin: EdgeInsets.symmetric(vertical: AppSize.s4, horizontal: AppSize.s4),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.teal), // Set border color and width
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  child: ListTile(
                    minTileHeight: AppSize.s40,
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(_botData[_selectedIndex][index]),
                    subtitle: Text('Description for ${_botData[_selectedIndex][index]}'),
                    trailing: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        _showActions(context, _botData[_selectedIndex][index]);
                      },
                    ),
                    contentPadding: EdgeInsets.only(left: AppSize.s8),
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.chatbotRoute);
                    },
                  ),
                );
              },
            ),
          ),
        ],
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
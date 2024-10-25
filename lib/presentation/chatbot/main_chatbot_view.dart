import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class ChatbotView extends StatefulWidget {
  const ChatbotView({super.key});

  @override
  State<ChatbotView> createState() => _ChatbotViewState();
}

class _ChatbotViewState extends State<ChatbotView> {
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
        centerWidget: Text("Bots"),
        actions: [
          Padding(
            padding: EdgeInsets.all(AppSize.s4),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Define the action for the button press
                },
                icon: Icon(Icons.add), // Add your desired icon here
                label: Text('Create'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorManager.teal, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    // Hành động khi nhấn vào biểu tượng microphone
                    print('Microphone button pressed');
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 50, // Chiều cao của danh sách tab
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(_botData.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index; // Cập nhật chỉ số tab được chọn
                    });
                  },
                  child: Padding(
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
          // Danh sách các item theo tab đã chọn
          Expanded(
            child: ListView.builder(
              itemCount: _botData[_selectedIndex].length,
              itemBuilder: (context, index) {
                return ListTile(
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
                  onTap: () {
                    // Khi nhấn vào item, chuyển đến một trang mới
                  },
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
                  Navigator.pop(context); // Đóng menu
                  // Xử lý sửa bot tại đây
                  print('Edit $botName');
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  Navigator.pop(context); // Đóng menu
                  // Xử lý xóa bot tại đây
                  print('Delete $botName');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
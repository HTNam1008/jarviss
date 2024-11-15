import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/animated_toggle_tab/animated_toggle_tab.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/prompt/create_prompt/create_prompt_view.dart';
import 'package:jarvis/presentation/prompt/edit_prompt/edit_prompt_view.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class PromptView extends StatefulWidget {
  const PromptView({super.key});

  @override
  State<PromptView> createState() => _PromptViewState();
}

class _PromptViewState extends State<PromptView> {
  int _selectedIndexTab = 0;
  bool _isFavourite = false;
  bool _isPublicPrompts = false;

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
          Padding(
            padding: const EdgeInsets.all(AppSize.s4),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CreatePromptView();
                    },
                  );
                },
                icon: const Icon(Icons.add), 
                label: const Text('Create'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorManager.teal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s8, vertical: AppSize.s4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), 
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
            padding: const EdgeInsets.only(top: AppSize.s8),
            child: AppinioAnimatedToggleTab(
              callback: (int i) {
                setState(() {
                  _isPublicPrompts = !_isPublicPrompts;
                  _selectedIndexTab = 0;
                });
              },
              tabTexts: const [
                'My Prompts',
                'Public Prompts',
              ],
              height: 40,
              width: 300,
              boxDecoration: BoxDecoration(
                color: ColorManager.primary,
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
                color: ColorManager.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSize.s8),
                ),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              activeStyle: const TextStyle(
                color: Colors.blue,
              ),
              inactiveStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.mic),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0), // Đặt borderRadius cho trạng thái bình thường
                        borderSide: const BorderSide(color: Colors.grey), // Màu viền khi không focus
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
          SizedBox(
            height: 50, // Chiều cao của danh sách tab
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _generateListTab(_isPublicPrompts ? _publicPromptDataTab : _myPromptDataTab),
            ),
          ),
          Expanded(
            child: _generateListData(_isPublicPrompts ? _publicPromptDataTab : _myPromptDataTab),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  showDialog(context: context, builder: (builder) => const EditPromptView());
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

  List<Widget> _generateListTab(List<List<String>> promptData) {
    return List.generate(promptData.length, (index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndexTab = index; 
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'Tab ${index + 1}', 
            style: TextStyle(
              fontWeight: _selectedIndexTab == index ? FontWeight.bold : FontWeight.normal,
              color: _selectedIndexTab == index ? Colors.blue : Colors.black,
            ),
          ),
        ),
      );
    });
  }

  Widget _generateListData(List<List<String>> promptData) {
    return ListView.builder(
      itemCount: promptData[_selectedIndexTab].length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: AppSize.s4, horizontal: AppSize.s4),
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.teal), 
            borderRadius: BorderRadius.circular(AppSize.s8), 
          ),
          child: ListTile(
            minTileHeight: AppSize.s40,
            title: Text(promptData[_selectedIndexTab][index]),
            subtitle: Text('Description for ${promptData[_selectedIndexTab][index]}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isFavourite = !_isFavourite;
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color: _isFavourite ? Colors.yellow : Colors.grey,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    _showActions(context, promptData[_selectedIndexTab][index]);
                  },
                ),
              ],
            ),
            contentPadding: const EdgeInsets.only(left: AppSize.s8),
            onTap: () {
              // Khi nhấn vào item, chuyển đến một trang mới
            },
          ),
        );
      },
    );
  }
}
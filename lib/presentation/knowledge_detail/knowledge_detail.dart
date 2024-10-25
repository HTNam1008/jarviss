import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class KnowledgeDetail extends StatefulWidget {
  @override
  State<KnowledgeDetail> createState() => _KnowledgeDetailState();
}

class _KnowledgeDetailState extends State<KnowledgeDetail> {
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;
  final TextEditingController _chatController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Thực hiện logic điều hướng theo index (ví dụ: chuyển màn hình)
  }

  void _sendMessage() {
    String message = _chatController.text;
    if (message.isNotEmpty) {
      print('User message: $message');
      _chatController.clear();
    }
  }

  final List<KnowledgeUnit> units = [
    KnowledgeUnit(name: 'bai1.docx', size: '15KB', isEnabled: true),
    KnowledgeUnit(name: 'bai1.docx', size: '15KB', isEnabled: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomHeaderBar(
        centerWidget: const Text(
          'Knowledge',
          style: TextStyle(
            color: Colors.white,
            fontSize: AppSize.s20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildKnowledgeHeader(),
          _buildUnitsHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: units.length,
              itemBuilder: (context, index) {
                return _buildUnitItem(units[index]);
              },
            ),
          ),
          BottomNavigation(
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
          ),
        ],
      ),
    );
  }

  Widget _buildKnowledgeHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Row(
        children: [
          Container(
            width: AppSize.s40,
            height: AppSize.s40,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(AppSize.s8),
            ),
            child: const Icon(Icons.article_outlined),
          ),
          const SizedBox(width: AppSize.s16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name of knowledge',
                  style: TextStyle(
                    fontSize: AppSize.s18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p8,
                        vertical: AppSize.s4,  // Changed to use AppSize instead
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                      child: const Text(
                        '3 units',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const SizedBox(width: AppSize.s8),
                    Text(
                      '15KB',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: AppSize.s40,
            height: AppSize.s40,
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.purple,
                size: AppSize.s20,
              ),
              onPressed: () {
                // Handle edit action
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Units',
            style: TextStyle(
              fontSize: AppSize.s16,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle add action
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s20),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p16,
                vertical: AppPadding.p8,
              ),
            ),
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitItem(KnowledgeUnit unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p8,
      ),
      child: Row(
        children: [
          const Icon(Icons.attachment, color: Colors.grey),
          const SizedBox(width: AppSize.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  unit.name,
                  style: const TextStyle(
                    fontSize: AppSize.s16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  unit.size,
                  style: TextStyle(
                    fontSize: AppSize.s14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: unit.isEnabled,
            onChanged: (value) {
              setState(() {
                unit.isEnabled = value;
              });
            },
            activeColor: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('Title', false),
          _buildNavItem('Title', true),
          _buildNavItem('Title', false),
          _buildNavItem('Title', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppSize.s8,
          height: AppSize.s8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.purple : Colors.transparent,
          ),
        ),
        const SizedBox(height: AppSize.s4),
        Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.purple : Colors.grey,
            fontSize: AppSize.s12,
          ),
        ),
      ],
    );
  }
}

class KnowledgeUnit {
  final String name;
  final String size;
  bool isEnabled;

  KnowledgeUnit({
    required this.name,
    required this.size,
    required this.isEnabled,
  });
}

import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class KnowledgeView extends StatefulWidget {
  @override
  State<KnowledgeView> createState() => _KnowledgeViewState();
}

class _KnowledgeViewState extends State<KnowledgeView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: CustomHeaderBar(
        centerWidget: const Text(
          'Knowledge',
          style: TextStyle(
            color: Colors.white,
            fontSize: AppSize.s20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.white),
            onPressed: () {
              // Handle add action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.mic),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s28),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return _buildKnowledgeItem(
                  title: 'Title',
                  caption: 'Caption',
                );
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

  Widget _buildKnowledgeItem({required String title, required String caption}) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Row(
        children: [
          Container(
            width: AppSize.s40,
            height: AppSize.s40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(AppSize.s8),
            ),
            child: const Icon(Icons.article_outlined),
          ),
          const SizedBox(width: AppSize.s16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppSize.s16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  caption,
                  style: TextStyle(
                    fontSize: AppSize.s14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              // Handle delete action
            },
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
          _buildNavItem('Title', false),
          _buildNavItem('Title', false),
          _buildNavItem('Title', true),
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
            color: isSelected ? ColorManager.primary : Colors.transparent,
          ),
        ),
        const SizedBox(height: AppSize.s4),
        Text(
          title,
          style: TextStyle(
            color: isSelected ? ColorManager.primary : Colors.grey,
            fontSize: AppSize.s12,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        // Logic khi nhấn nút upload
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSize.s16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: AppSize.s40),
            SizedBox(height: AppSize.s8),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestion(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSize.s8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        tileColor: Colors.teal.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSize.s16, vertical: AppSize.s8),
      ),
    );
  }
}

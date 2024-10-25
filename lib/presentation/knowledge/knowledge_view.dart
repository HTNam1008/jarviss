import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/knowledge/knowledge_create/knowledge_create.dart';
import 'package:jarvis/presentation/knowledge/knowledge_delete/knowledge_delete.dart';
import 'package:jarvis/presentation/knowledge/knowledge_detail/knowledge_detail.dart';
import 'package:jarvis/presentation/knowledge/knowledge_edit/knowledge_edit.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class KnowledgeView extends StatefulWidget {
  @override
  State<KnowledgeView> createState() => _KnowledgeViewState();
}

class _KnowledgeViewState extends State<KnowledgeView> {
  final TextEditingController _searchController = TextEditingController();

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
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(AppSize.s4),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(context: context, builder: (builder) => CreateKnowledgeView());
                },
                icon: Icon(Icons.add),
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
        centerTitle: true,
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
          Expanded(
            child: ListView.builder(
              itemCount: 4,
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
                      child: Icon(Icons.article_outlined),
                    ),
                    title: Text("Title"),
                    subtitle: Text('Description'),
                    trailing: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        _showActions(context);
                      },
                    ),
                    contentPadding: EdgeInsets.only(left: AppSize.s8),
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.detailKnowledgeRoute);
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

  void _showActions(BuildContext context) {
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
                  showDialog(context: context, builder: (builder) => EditKnowledgeView());
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(context: context, builder: (builder) => DeleteKnowledgeView());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

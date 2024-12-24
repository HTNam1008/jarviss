import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/knowledge/knowledge_edit/knowledge_edit.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';
import 'package:jarvis/presentation/unit_add/unit_add.dart';
import 'package:jarvis/presentation/unit_add/unit_view_model.dart';

import '../../../data/responses/ai_bot/get_assistants_response.dart';

class DetailKnowledgeView extends StatefulWidget {
  final KnowledgeData knowledge;

  const DetailKnowledgeView({super.key, required this.knowledge});
  @override
  State<DetailKnowledgeView> createState() => _DetailKnowledgeViewState();
}

class _DetailKnowledgeViewState extends State<DetailKnowledgeView> {
  late UnitViewModel _viewModel;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.instance<UnitViewModel>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _viewModel.getUnits(widget.knowledge.index, null, 0, null, null, null); // Initial fetch
      _isInitialized = true;
    }
  }

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
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildKnowledgeHeader(),
          _buildUnitsHeader(),
          Expanded(
            child: StreamBuilder<List<UnitData>>(
              stream: _viewModel.unitStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No units available.'));
                }

                final unitsList = snapshot.data!;
                return ListView.builder(
                  itemCount: unitsList.length,
                  itemBuilder: (context, index) {
                    final unit = unitsList[index];
                    return _buildUnitItem(unit);
                  },
                );
              },
            ),
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
                Text(
                  widget.knowledge.knowledgeName,
                  style: const TextStyle(
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
                      child:  Text(widget.knowledge.numUnits.toString()+' units',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const SizedBox(width: AppSize.s8),
                    Text(
                      widget.knowledge.totalSize.toString()+' KB',
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
              color: Colors.blue.shade100.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.edit_outlined,
                color: ColorManager.teal,
                size: AppSize.s20,
              ),
              onPressed: () {
                showDialog(context: context, builder: (builder) => EditKnowledgeView(knowledge:widget.knowledge));
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
              showDialog(context: context, builder: (builder) => UnitAdd(knowledgeId: widget.knowledge.index));
            },
            style: TextButton.styleFrom(
              backgroundColor: ColorManager.teal,
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

  Widget _buildUnitItem(UnitData unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p8,
      ),
      child: Row(
        children: [
          // Icon for the unit
          const Icon(Icons.attachment, color: Colors.grey),
          const SizedBox(width: AppSize.s12),

          // Unit details (name and size)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  unit.name ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: AppSize.s16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  unit.size.toString()+ 'KB' ?? '0 KB',
                  style: TextStyle(
                    fontSize: AppSize.s14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

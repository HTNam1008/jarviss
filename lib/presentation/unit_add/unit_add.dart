import 'package:flutter/material.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';
import 'package:jarvis/presentation/unit_add/unit_add_confluence.dart';
import 'package:jarvis/presentation/unit_add/unit_add_ggdrive.dart';
import 'package:jarvis/presentation/unit_add/unit_add_localfile.dart';
import 'package:jarvis/presentation/unit_add/unit_add_slack.dart';
import 'package:jarvis/presentation/unit_add/unit_add_website.dart';

class UnitAdd extends StatefulWidget {
  @override
  State<UnitAdd> createState() => _UnitAddState();
}

class _UnitAddState extends State<UnitAdd> {
  int _selectedIndex = 0;

  final List<UnitOption> _unitOptions = [
    UnitOption(
      icon: Icons.upload_file_outlined,
      title: 'Local File',
      description: 'Upload .docx, .pdf, .txt file',
    ),
    UnitOption(
      icon: Icons.link_outlined,
      title: 'Website',
      description: 'Add website URL',
    ),
    UnitOption(
      icon: Icons.link_outlined,
      title: 'Confluence',
      description: 'Add Confluence link',
    ),
    UnitOption(
      icon: Icons.link_outlined,
      title: 'Slack',
      description: 'Add Slack link',
    ),UnitOption(
      icon: Icons.link_outlined,
      title: 'Google Drive',
      description: 'Add Google Drive link',
    )

  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add unit',
              style: TextStyle(
                fontSize: AppSize.s20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSize.s20),
            Container(
              width: AppSize.s60,
              height: AppSize.s60,
              decoration: BoxDecoration(
                color: ColorManager.teal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              child: Icon(
                Icons.add_box_outlined,
                size: AppSize.s32,
                color: ColorManager.teal,
              ),
            ),
            const SizedBox(height: AppSize.s20),
            ..._unitOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              return _buildOptionTile(index, option);
            }),
            const SizedBox(height: AppSize.s24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                      backgroundColor: ColorManager.teal.withOpacity(0.1),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: ColorManager.teal,
                        fontSize: AppSize.s16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSize.s16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(context: context, builder: (builder) => _handleAddUnit(_selectedIndex));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                      backgroundColor: ColorManager.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppSize.s16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(int index, UnitOption option) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSize.s12),
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.teal.withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(AppSize.s12),
          border: Border.all(
            color: isSelected ? ColorManager.teal : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: AppSize.s40,
              height: AppSize.s40,
              decoration: BoxDecoration(
                color: isSelected ? ColorManager.teal.withOpacity(0.2) : Colors.white,
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
              child: Icon(
                option.icon,
                color: isSelected ? ColorManager.teal : Colors.grey,
                size: AppSize.s24,
              ),
            ),
            const SizedBox(width: AppSize.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: TextStyle(
                      fontSize: AppSize.s16,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? ColorManager.teal : Colors.black,
                    ),
                  ),
                  Text(
                    option.description,
                    style: TextStyle(
                      fontSize: AppSize.s14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Radio(
              value: index,
              groupValue: _selectedIndex,
              activeColor: ColorManager.teal,
              onChanged: (int? value) {
                if (value != null) {
                  setState(() {
                    _selectedIndex = value;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _handleAddUnit(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return UnitAddLocalfile();
      case 1:
        return UnitAddWebsite();
      case 2:
        return UnitAddConfluence();
      case 3:
        return UnitAddSlack();
      case 4:
        return UnitAddGoogleDrive();
      default:
        return Container();
    }
  }
}

class UnitOption {
  final IconData icon;
  final String title;
  final String description;

  UnitOption({
    required this.icon,
    required this.title,
    required this.description,
  });
}

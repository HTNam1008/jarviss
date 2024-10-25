import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class EditBotView extends StatelessWidget {
  const EditBotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomHeaderBar(
        centerWidget: const Text(
          'Edit Bot',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/images/avt.png'),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              _buildInputField('Bot name', 'Super bot', context),
              _buildInputField('Description', 'The bot is an experienced science fiction writer...', context, maxLines: 5),
              _buildInputField('Persona & Prompt', 'Answer in 2 sentences', context, maxLines: 3),
              _buildKnowledgeField(),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(double.infinity, 50), // Full width button
                  ),
                  onPressed: () {
                    // Logic to preview bot
                    _previewBot(context);
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  void _previewBot(BuildContext context) {
    // Logic to handle preview action
    // You can show a dialog, navigate to another screen, etc.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Preview Bot'),
          content: Text('This is a preview of the bot.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputField(String label, String preFilledText, BuildContext context, {int maxLines = 1}) {
    TextEditingController controller = TextEditingController(text: preFilledText);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: InputDecorationTheme(
            floatingLabelStyle: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelStyle: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.teal,
                width: 1.0,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          ),
        ),
      ),
    );
  }


  Widget _buildKnowledgeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Knowledge',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.teal), // Set border color and width
                      borderRadius: BorderRadius.circular(AppSize.s8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Text(
                      '4 units',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    ),
                    onPressed: () {
                      // Add knowledge logic
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

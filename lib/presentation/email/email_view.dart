import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../data/request/email/create_email_reply_request.dart';
import '../../domain/usecase/create_email_reply_usecase.dart';
import '../../domain/usecase/create_response_email_usecase.dart';
import '../base/baseviewmodel.dart';
import '../common/chat_input_box.dart';
import '../knowledge/knowledge_view.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import 'package:provider/provider.dart';
import '../resources/values_manager.dart';

class EmailView extends StatefulWidget {
  @override
  _EmailViewState createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> with SingleTickerProviderStateMixin {
  final FocusNode _chatFocusNode = FocusNode(); // FocusNode for the TextField
  bool _isSuggestionVisible = false; // Tracks visibility of suggestion list
  final TextEditingController _chatController = TextEditingController();
  final TextEditingController _senderController = TextEditingController();
  final TextEditingController _receiverController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  String selectedLanguage = 'English';
  String _selectedLength = 'Long';  // Default value for length
  String _selectedFormality = 'Neutral';  // Default value for formality
  String _selectedTone = 'Friendly';  // Default selected tone(s)
  String emailContent = "";
  String emailSubject = "";
  String emailSender = "";
  String emailReceiver = "";

  @override
  void initState() {
    log(emailContent);
    // Add a listener to the FocusNode to handle focus changes
    _chatFocusNode.addListener(() {
      log('click to fcus');
      setState(() {
        _isSuggestionVisible = _chatFocusNode.hasFocus; // Show suggestions when focused
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _chatFocusNode.dispose();
    // Resetting values when leaving the page
    _chatController.clear(); // Clears the text field
    emailSubject = "";
    emailSender = "";
    emailReceiver = "";
    emailContent = "";
    _selectedLength = 'Long'; // Reset to default value
    _selectedFormality = 'Neutral'; // Reset to default value
    _selectedTone = 'Friendly'; // Reset to default value
    super.dispose();
  }

  void _showInputEmailDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Input Email'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _subjectController,
                  onChanged: (value) {
                    emailSubject = value;
                  },
                  decoration: InputDecoration(hintText: 'Subject'),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _senderController,
                  onChanged: (value) {
                    emailSender = value;
                  },
                  decoration: InputDecoration(hintText: 'Sender'),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _receiverController,
                  onChanged: (value) {
                    emailReceiver = value;
                  },
                  decoration: InputDecoration(hintText: 'Receiver'),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _contentController,
                  onChanged: (value) {
                    emailContent = value;
                  },
                  decoration: InputDecoration(hintText: 'Content'),
                  maxLines: 5,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Check if any of the fields are null or empty
                if (_subjectController.text == null || _subjectController.text!.isEmpty ||
                    _senderController.text == null || _senderController.text!.isEmpty ||
                    _receiverController.text == null || _receiverController.text!.isEmpty ||
                    _contentController.text == null || _contentController.text!.isEmpty) {
                  // Show an alert dialog to notify the user to fill all fields
                  _showErrorDialog('Please fill in all fields before submitting.');
                } else {
                  // Handle the email content submission here
                  print("Email Subject: $emailSubject");
                  print("Email Sender: $emailSender");
                  print("Email Receiver: $emailReceiver");
                  print("Email Content: $emailContent");
                  Navigator.of(context).pop();
                  _showSuccessDialog('Add email success!');
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
  void _showEmailStyleDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Email Style'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Length'),
                Row(
                  children: ['Short', 'Medium', 'Long'].map((lengthOption) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(lengthOption),
                        selected: _selectedLength == lengthOption,
                        selectedColor: Colors.cyanAccent, // Customize the selected color
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedLength = lengthOption; // Update the selected length
                            }
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                Text('Formality'),
                Row(
                  children: ['Casual', 'Neutral', 'Formal'].map((formalityOption) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(formalityOption),
                        selected: _selectedFormality == formalityOption,
                        selectedColor: Colors.cyanAccent, // Customize the selected color
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedFormality = formalityOption; // Update the selected formality
                            }
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                Text('Tone'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['Witty', 'Empathetic', 'Personable', 'Concerned', 'Friendly', 'Direct', 'Sincere', 'Optimistic', 'Confident', 'Informational', 'Enthusiastic']
                      .map((tone) {
                    return ChoiceChip(
                      label: Text(tone),
                      selected: _selectedTone == tone, // Check if this tone is the selected one
                      selectedColor: Colors.cyanAccent, // Customize the selected color
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedTone = tone; // Update the selected tone
                          } else {
                            _selectedTone = ''; // Deselect tone by clearing the selection
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            // Removed Apply button since we don't need it anymore.
            // The changes now take effect immediately upon selection.
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSuccessDialog('Apply style successful!');
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the success dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmailViewModel>(
      create: (_) => EmailViewModel(GetIt.instance.get<CreateEmailReplyUsecase>(),GetIt.instance.get<CreateResponseEmailUsecase>()),
      child: Consumer<EmailViewModel>(
        builder: (context, emailViewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Email Response'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: emailViewModel.replyIdeasList.isNotEmpty
                            ? emailViewModel.replyIdeasList.map((idea) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 200,
                                height: 70,// Adjust this value to decrease/increase the width of the button
                                child: MouseRegion(
                                   onEnter: (event) {},
                                   onExit: (event) {},
                                  child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                                      if (states.contains(MaterialState.hovered)) {
                                        return Colors.white54; // Change color on hover
                                      }
                                      return Colors.cyan; // Default color
                                    }),
                                    overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                      if (states.contains(MaterialState.hovered)) {
                                        return Colors.white54.withOpacity(0.5); // Optional hover overlay effect
                                      }
                                      return null; // Default overlay
                                    }),
                                  ),
                                  onPressed: () {
                                    emailViewModel.createResponseEmail(
                                      idea,
                                      _chatController.text,
                                      emailContent,
                                      emailSubject,
                                      emailSender,
                                      emailReceiver,
                                      selectedLanguage,
                                      _selectedLength,
                                      _selectedFormality,
                                      _selectedTone,
                                    );
                                  },
                                  child: Text(idea, style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppSize.s12,
                                    fontWeight: FontWeightManager.semiBold,
                                  )),
                                ),
                                 ),
                              ),
                            );
                          }).toList() : [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Add email to create reply ideas',
                                style: TextStyle(
                                  fontSize: AppSize.s14,
                                  fontWeight: FontWeightManager.semiBold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (emailViewModel.emailResponse.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight: 310, // Limit the height of the response display
                            ),
                            child: SingleChildScrollView(
                              child: Text(
                                emailViewModel.emailResponse,
                                style: TextStyle(
                                  fontSize: AppSize.s14,
                                  fontWeight: FontWeightManager.semiBold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: _showInputEmailDialog,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,  // Align content to the end (right)
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppSize.s14,
                                fontWeight: FontWeightManager.semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => _showEmailStyleDialog(),
                        child: Row(
                          children: [
                            Icon(Icons.style, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Style',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppSize.s14,
                                fontWeight: FontWeightManager.semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      DropdownButton<String>(
                        value: selectedLanguage,
                        items: [
                          DropdownMenuItem(
                            value: 'English',
                            child: Text('English'),
                          ),
                          DropdownMenuItem(
                            value: 'Vietnamese',
                            child: Text('Vietnamese'),
                          ),
                        ],
                        onChanged: (value) {
                          selectedLanguage = value!;
                        },
                      )
                    ],
                  ),
                ),
                if (_isSuggestionVisible)
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Suggestions',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _isSuggestionVisible = false; // Hide suggestions
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 4.0,
                                  children: [
                                    'Thanks',
                                    'Sorry',
                                    'Yes',
                                    'No',
                                    'Follow Up',
                                    'Request for more information',
                                  ].map((action) {
                                    return ChoiceChip(
                                      label: Text(action),
                                      selected: false,
                                      onSelected: (_) {
                                        _chatController.text = action; // Populate the TextField
                                        _chatController.selection = TextSelection.fromPosition(
                                          TextPosition(offset: _chatController.text.length),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _chatController,
                      focusNode: _chatFocusNode, // Attach the FocusNode to the TextField
                      decoration: InputDecoration(
                        hintText: 'Input action',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10
                        ), // Optional, for better padding inside the TextField
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Add space between the TextField and the ElevatedButton
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isSuggestionVisible = false; // Hide suggestions
                      });
                      if (emailContent == null || emailContent.isEmpty ||
                          emailSubject == null || emailSubject.isEmpty ||
                          emailSender == null || emailSender.isEmpty ||
                          emailReceiver == null || emailReceiver.isEmpty) {
                        // Show an error message
                        _showErrorDialog('Please add email before sending.');
                      } else {
                        // If all fields are valid, send the email reply
                        emailViewModel.sendEmailReply(
                          _chatController.text, // Use input from the TextField
                          emailContent,
                          emailSubject,
                          emailSender,
                          emailReceiver,
                          selectedLanguage,
                        );
                      }
                    },
                    child: Icon(Icons.send, color: Colors.white,),
                  ),
                ],
              ),
            ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EmailViewModel  extends ChangeNotifier {
  final CreateEmailReplyUsecase _createEmailReplyUsecase;
  final CreateResponseEmailUsecase _createResponseEmailUsecase;

  List<String> replyIdeasList = [];
  String emailResponse = "";

  EmailViewModel(this._createEmailReplyUsecase, this._createResponseEmailUsecase);

  final StreamController<String> _errorStreamController = StreamController<String>.broadcast();

  void resetState() {
    replyIdeasList = [];
    emailResponse = "";
    notifyListeners();  // Notify UI of state changes
  }

  Future<void> sendEmailReply(String action, String email, String subject, String sender, String receiver, String language) async {
    final metaData = Metadata(
      context: [],
      subject: subject,
      sender: sender,
      receiver: receiver,
      language: language
    );
    final input = CreateEmailReplyRequest(
        action: action,
        email: email,
        metadata: metaData
    );
    (await _createEmailReplyUsecase.execute(input)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (response) {
          replyIdeasList = response.ideas;
          emailResponse = "";
          notifyListeners(); // Notify UI of state changes
          log(replyIdeasList.toString());
        }
    );
  }

  Future<void> createResponseEmail(String mainIdea, String action, String email, String subject, String sender, String receiver, String language, String length, String formality, String tone) async {
    final input = CreateResponseEmailParams(
        mainIdea: mainIdea,
        action: action,
        email: email,
        subject: subject,
        sender: sender,
        receiver: receiver,
        language: language,
        length: length,
        tone: tone,
        formality: formality,
    );
    (await _createResponseEmailUsecase.execute(input)).fold(
            (failure) => _errorStreamController.add(failure.message),
            (response) {
          emailResponse = response.email;
          notifyListeners(); // Notify UI of state changes
          log(emailResponse.toString());
        }
    );
  }

  @override
  void dispose() {
    resetState();
    _errorStreamController.close();
    super.dispose();
  }

}

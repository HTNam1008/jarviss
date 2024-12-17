import 'package:flutter/material.dart';
import 'package:jarvis/presentation/authencation/sign_out/sign_out.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';

class DetailProfileView extends StatelessWidget {
  const DetailProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: CustomHeaderBar(
        centerWidget: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage('assets/images/avt.png'),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Click to change avatar',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              _buildEditableField('Name', 'Hoang Thanh Nam', context),
              _buildEditableField('Email', 'htn1515@gmail.com', context),
              _buildEditableField('User ID', 'abdju39rjfmks9wu', context, editable: false),
              _buildEditableField('Delete Account', '', context, isDelete: true),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade100,
            foregroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SignOutView()));
          },
          child: const Text('Log out',style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),),
        ),
      ),
    );
  }

  Widget _buildEditableField(String title, String value, BuildContext context, {bool editable = true, bool isDelete = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            if (!isDelete) ...[
              Row(
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  editable
                      ? const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.0,
                      color: Colors.grey,
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      icon: const Icon(Icons.copy, size: 20.0, color: Colors.grey),
                      onPressed: () {
                        // Copy User ID to clipboard
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$title copied to clipboard')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}

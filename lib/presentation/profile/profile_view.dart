import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: CustomHeaderBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage('assets/images/avt.png'),
                    ),
                    SizedBox(height: 10.0),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.detailProfileRoute);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hoang Thanh Nam',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'htn15151@gmail.com',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              _buildSectionTitle('General'),
              _buildListTile('Chat settings', Icons.chat),
              _buildListTile('Color scheme', Icons.color_lens),
              _buildListTile('Language', Icons.language),
              _buildSectionTitle('Other'),
              _buildListTile('Memory', Icons.memory),
              _buildListTile('Browser settings', Icons.public),
              _buildSectionTitle('About'),
              _buildListTile('Rate us', Icons.star_rate),
              _buildListTile('Share', Icons.share),
              _buildListTile('Contact us', Icons.contact_phone),
              _buildListTile('About', Icons.info),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0), // Padding cho ListTile
            leading: Icon(icon, color: Colors.black),
            title: Text(title),
            trailing:
            Icon(
              Icons.arrow_forward_ios,
              size: 18.0,
              color: Colors.grey,
            )
        ),
      ),
    );
  }
}


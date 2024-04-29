import 'package:flutter/material.dart';
import 'package:koko_chat/components/my_drawer.dart';
import 'package:koko_chat/components/user_tile.dart';
import 'package:koko_chat/pages/chat_page.dart';
import 'package:koko_chat/services/auth/auth_service.dart';
import 'package:koko_chat/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // get chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  // build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        //  error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        // loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        // return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          // tapped on a user -> go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  recieverEmail: userData["email"],
                  recieverID: userData["uid"],
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}

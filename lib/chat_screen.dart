import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_cubit.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessages()), // Message List
          _buildMessageInput(context), // Input Field to send message
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return BlocBuilder<ChatCubit, List<String>>(builder: (context, messages) {
      if (messages.isEmpty) {
        return const Center(child: Text("No messages yet..."));
      }

      return ListView.builder(
        reverse: true, // Show newest messages at the bottom
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(messages[index]),
          );
        },
      );
    });
  }

  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(labelText: 'Send a message...'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (messageController.text.trim().isNotEmpty) {
                context.read<ChatCubit>().sendMessage(messageController.text);
                messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

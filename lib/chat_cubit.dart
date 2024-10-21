import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatCubit extends Cubit<List<String>> {
  ChatCubit() : super([]);

  // Fetch real-time messages from Firestore
  void fetchMessages() {
    FirebaseFirestore.instance
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      List<String> messages =
          snapshot.docs.map((doc) => doc['content'] as String).toList();
      emit(messages); // Update the state with new messages
    });
  }

  // Send a new message to Firestore
  void sendMessage(String messageContent) {
    FirebaseFirestore.instance.collection('chats').add({
      'content': messageContent,
      'senderId': 'user123', // Replace with real user ID from FirebaseAuth
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

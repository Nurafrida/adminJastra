import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LiveChatAdmin(name: 'Admin', message: 'Hello', imageUrl: '',),
    );
  }
}

class LiveChatAdmin extends StatefulWidget {
  final String name;
  final String message;

  const LiveChatAdmin({super.key, required this.name, required this.message, required String imageUrl});

  @override
  _LiveChatAdminState createState() => _LiveChatAdminState();
}

class _LiveChatAdminState extends State<LiveChatAdmin> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    FirebaseFirestore.instance.collection('chats').add({
      'text': _controller.text,
      'createdAt': Timestamp.now(),
      'userId': 'admin',
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://drive.google.com/uc?id=1uaufhX5ePKLOevVGuT_5Hk0hCWllPCPE'),
              radius: 20,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(width: 16),
            Text('Chat'),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
                  if (chatSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final chatDocs = chatSnapshot.data!.docs;
                  return ListView.builder(
                    reverse: true,
                    itemCount: chatDocs.length,
                    itemBuilder: (ctx, index) => MessageBubble(
                      chatDocs[index]['text'],
                      chatDocs[index]['userId'] == 'admin',
                      key: ValueKey(chatDocs[index].id),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.orange[300],
                      ),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              print('Add file button pressed');
                            },
                          ),
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: TextField(
                                  controller: _controller,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    hintText: 'Kirim Pesan',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send, color: Colors.white),
                            onPressed: _sendMessage,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const MessageBubble(this.message, this.isMe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isMe ? const Color.fromARGB(210, 226, 129, 10) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.only(
            top: 8.0,
            bottom: 4.0,
            left: isMe ? 8.0 : 0.0,
            right: isMe ? 0.0 : 8.0,
          ),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                message,
                style: TextStyle(
                  color: isMe ? const Color.fromARGB(255, 44, 22, 22) : Colors.black,
                ),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

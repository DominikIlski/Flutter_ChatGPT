import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
class ChatScreen extends StatefulWidget {
  const ChatScreen({required Key key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> chatMessages = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 400, 300, 100];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<String> callOpenAIFunction() async {
    try {
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sayHello');
      final HttpsCallableResult result = await callable.call({'test': 'test'});
      print(result.data);
      return result.data['data'];
    } on FirebaseFunctionsException catch (e) {
      print('Firebase function error: ${e.code}\n${e.message}');
      throw e;
    }
  }

  void _sendMessage() async {
    String message = _textEditingController.text;
    setState(() {
      chatMessages.add(message);
    });
    _textEditingController.clear();
    String response = await callOpenAIFunction();
    setState(() {
    chatMessages.add(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask me anything'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/profile'),
            icon: const Icon(Icons.person_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: chatMessages.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: Colors.amber[colorCodes[index % colorCodes.length]],
                  child: Center(child: Text(chatMessages[index])),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Flexible(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _textEditingController,
                    ),
                  ),
                ),
                Flexible(
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
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

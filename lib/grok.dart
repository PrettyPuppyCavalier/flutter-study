import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './config/grok.dart';
import 'dart:convert';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grok Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<String> _getGrokResponseStream(String message) async {
    final request = http.Request(
      'POST',
      Uri.parse(GrokConfig.apiUrl),
    );

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GrokConfig.apiKey}',
    });

    request.body = jsonEncode({
      'messages': [
        {'role': 'system', 'content': 'You are a test assistant.'},
        {'role': 'user', 'content': message},
      ],
      'model': GrokConfig.model,
      'stream': GrokConfig.isStream,
      'temperature': 0,
    });

    final streamedResponse = await request.send();

    if (streamedResponse.statusCode != 200) {
      final errorBody = await streamedResponse.stream.bytesToString();
      throw Exception('API Error (${streamedResponse.statusCode}): $errorBody');
    }

    String fullResponse = '';

    // 处理流式数据
    await for (final chunk in streamedResponse.stream.transform(utf8.decoder)) {
      // 清理空行和无效数据
      final lines = chunk.split('\n').where((line) => line.trim().isNotEmpty);

      for (final line in lines) {
        if (line.startsWith('data: ')) {
          final jsonString = line.substring(6); // 移除 "data: " 前缀
          try {
            final jsonData = jsonDecode(jsonString);
            final content = jsonData['choices']?[0]?['delta']?['content'];
            if (content != null) {
              fullResponse += content;
              setState(() {
                _messages.last = Message(text: fullResponse, isUser: false);
              });
            }
          } catch (e) {
            print('解析错误: $e, chunk: $jsonString');
            // 忽略解析错误，继续处理下一块
          }
        }
      }
    }

    return fullResponse;
  }

  // 修改 _sendMessage 方法，添加加载状态
  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(Message(text: text, isUser: true));
      _messages.add(Message(text: '正在生成...', isUser: false));
    });
    _controller.clear();

    try {
      await _getGrokResponseStream(text);
    } catch (e) {
      setState(() {
        _messages.last = Message(text: '错误: $e', isUser: false);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grok Chat'), elevation: 0),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: _messages[index]);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: '输入消息...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            onPressed: () => _sendMessage(_controller.text),
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}

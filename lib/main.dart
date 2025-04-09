import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './config/grok.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/github.dart';
import 'package:flutter_highlighter/themes/monokai-sublime.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/markdown_widget.dart';

// 主题配置类
class ChatThemeConfig {
  final Color userBubbleColor;
  final Color grokBubbleColor;
  final Color codeBlockBackground;
  final Color textColor;
  final Color secondaryTextColor;
  final Color borderColor;
  final Color listMarkerColor;
  final Color quoteSideColor;
  final Color inputBackground;
  final Color scaffoldBackground;
  final Map<String, TextStyle> codeHighlightTheme;

  ChatThemeConfig.light()
      : userBubbleColor = Colors.grey.shade300,
        grokBubbleColor = Colors.grey.shade100,
        codeBlockBackground = Colors.grey.shade200,
        textColor = Colors.black87,
        secondaryTextColor = Colors.grey.shade600,
        borderColor = Colors.grey.shade300,
        listMarkerColor = Colors.grey.shade700,
        quoteSideColor = Colors.grey.shade400,
        inputBackground = Colors.grey.shade100,
        scaffoldBackground = Colors.white,
        codeHighlightTheme = githubTheme;

  ChatThemeConfig.dark()
      : userBubbleColor = Colors.grey.shade600, // 调浅，从 800 到 600
        grokBubbleColor = Colors.grey.shade700, // 调浅，从 900 到 700，与背景区分
        codeBlockBackground = Colors.grey.shade600, // 调浅，从 700 到 600
        textColor = Colors.white,
        secondaryTextColor = Colors.grey.shade300, // 调浅，从 400 到 300
        borderColor = Colors.grey.shade500, // 调浅，从 600 到 500
        listMarkerColor = Colors.grey.shade400, // 调浅，从 300 到 400
        quoteSideColor = Colors.grey.shade400, // 调浅，从 500 到 400
        inputBackground = Colors.grey.shade700, // 调浅，从 800 到 700
        scaffoldBackground = Colors.grey.shade800, // 调浅，从 900 到 800
        codeHighlightTheme = monokaiSublimeTheme;

  factory ChatThemeConfig.fromBrightness(Brightness brightness) {
    return brightness == Brightness.dark
        ? ChatThemeConfig.dark()
        : ChatThemeConfig.light();
  }
}

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grok Chat',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: ChatThemeConfig.light().scaffoldBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
        colorScheme: ColorScheme.light(
          primary: Colors.grey.shade800,
          secondary: Colors.grey.shade600,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ChatThemeConfig.dark().scaffoldBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        colorScheme: ColorScheme.dark(
          primary: Colors.grey.shade300,
          secondary: Colors.grey.shade500,
        ),
      ),
      themeMode: ThemeMode.light, // 手动切换为暗黑模式，便于测试
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
    final request = http.Request('POST', Uri.parse(GrokConfig.apiUrl));
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
    await for (final chunk in streamedResponse.stream.transform(utf8.decoder)) {
      final lines = chunk.split('\n').where((line) => line.trim().isNotEmpty);
      for (final line in lines) {
        if (line.startsWith('data: ')) {
          final jsonString = line.substring(6);
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
          }
        }
      }
    }
    return fullResponse;
  }

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
    final themeConfig = ChatThemeConfig.fromBrightness(Theme.of(context).brightness);
    return Scaffold(
      appBar: AppBar(
        title: Text('Grok Chat'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: _messages[index], themeConfig: themeConfig);
              },
            ),
          ),
          _buildInputArea(themeConfig),
        ],
      ),
    );
  }

  Widget _buildInputArea(ChatThemeConfig themeConfig) {
    return Container(
      padding: EdgeInsets.all(12),
      color: themeConfig.inputBackground,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: '输入消息...',
                hintStyle: TextStyle(color: themeConfig.secondaryTextColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: themeConfig.grokBubbleColor,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              style: TextStyle(fontSize: 15, color: themeConfig.textColor),
            ),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            backgroundColor: themeConfig.userBubbleColor,
            onPressed: () => _sendMessage(_controller.text),
            child: Icon(Icons.send, color: themeConfig.textColor, size: 20),
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
  final ChatThemeConfig themeConfig;

  const MessageBubble({required this.message, required this.themeConfig});

  Widget _buildContent(BuildContext context) {
    if (message.isUser) {
      return Text(
        message.text,
        style: TextStyle(
          color: themeConfig.textColor,
          fontSize: 15,
          height: 1.4,
        ),
      );
    }

    final codeBlockRegExp = RegExp(r'```(\w+)?\n([\s\S]*?)```', multiLine: true);
    if (!codeBlockRegExp.hasMatch(message.text)) {
      return MarkdownWidget(
        data: message.text,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        config: MarkdownConfig(configs: _markdownConfigs()),
      );
    }

    final parts = <Widget>[];
    int lastEnd = 0;
    for (final match in codeBlockRegExp.allMatches(message.text)) {
      if (match.start > lastEnd) {
        parts.add(
          MarkdownWidget(
            data: message.text.substring(lastEnd, match.start),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            config: MarkdownConfig(configs: _markdownConfigs()),
          ),
        );
      }

      String language = match.group(1) ?? 'plaintext';
      String code = match.group(2)!.trim();
      parts.add(_buildCodeBlock(context, code, language));
      lastEnd = match.end;
    }

    if (lastEnd < message.text.length) {
      parts.add(
        MarkdownWidget(
          data: message.text.substring(lastEnd),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          config: MarkdownConfig(configs: _markdownConfigs()),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: parts,
    );
  }

  Widget _buildCodeBlock(BuildContext context, String code, String language) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(12, 0, 12, 8),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // 统一垂直内边距
      decoration: BoxDecoration(
        color: themeConfig.codeBlockBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: themeConfig.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      constraints: BoxConstraints(minWidth: double.infinity),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  language.toUpperCase(),
                  style: TextStyle(
                    color: themeConfig.secondaryTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.copy, size: 16, color: themeConfig.secondaryTextColor),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('代码已复制', style: TextStyle(color: themeConfig.textColor)),
                      backgroundColor: themeConfig.userBubbleColor,
                    ),
                  );
                },
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.85 - 48),
                child: HighlightView(
                  code,
                  language: language,
                  theme: themeConfig.codeHighlightTheme,
                  padding: EdgeInsets.all(12),
                  textStyle: GoogleFonts.robotoMono(
                    fontSize: 13,
                    height: 1.5,
                    color: themeConfig.textColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<WidgetConfig> _markdownConfigs() => [
    PConfig(textStyle: _defaultTextStyle()),
    H1Config(style: _h1Style()),
    H2Config(style: _h2Style()),
    ListConfig(
      marginLeft: 12.0,
      marginBottom: 6.0,
      marker: (index, type, isDone) => _listMarker(),
    ),
    BlockquoteConfig(
      textColor: themeConfig.secondaryTextColor,
      sideColor: themeConfig.quoteSideColor,
      sideWith: 3.0,
      padding: EdgeInsets.fromLTRB(12, 6, 6, 6),
      margin: EdgeInsets.symmetric(vertical: 6),
    ),
  ];

  TextStyle _defaultTextStyle() => TextStyle(
    color: themeConfig.textColor,
    fontSize: 15,
    height: 1.5,
  );

  TextStyle _h1Style() => TextStyle(
    color: themeConfig.textColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  TextStyle _h2Style() => TextStyle(
    color: themeConfig.textColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  Container _listMarker() => Container(
    width: 5,
    height: 5,
    margin: EdgeInsets.only(right: 6, top: 6),
    decoration: BoxDecoration(
      color: themeConfig.listMarkerColor,
      shape: BoxShape.circle,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isUser ? themeConfig.userBubbleColor : themeConfig.grokBubbleColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: _buildContent(context),
      ),
    );
  }
}
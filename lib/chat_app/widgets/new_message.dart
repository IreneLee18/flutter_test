import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  void _onSubmit() {
    final message = _messageController.text;
    if (message.isEmpty || message.trim().isEmpty) return;
    // send message

    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 1, 14),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              decoration: InputDecoration(labelText: 'Send a message...'),
            ),
          ),
          IconButton(
            onPressed: _onSubmit,
            icon: const Icon(Icons.send),
            color: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
    );
  }
}

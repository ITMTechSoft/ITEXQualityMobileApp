import 'package:flutter/material.dart';

final TextEditingController _sampleTicketController = TextEditingController();
final TextEditingController _controlResultController = TextEditingController();

Future<void> showSampleDialog({
  context,
  String? initialSampleTicket,
  String? initialControlResult,
  required void Function(String sampleTicket, String controlResult) onSave,
}) async {
  // Set initial values if editing
  _sampleTicketController.text = initialSampleTicket ?? '';
  _controlResultController.text = initialControlResult ?? '';

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Sample Control'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _sampleTicketController,
                decoration: InputDecoration(labelText: 'Sample Ticket'),
              ),
              TextField(
                controller: _controlResultController,
                decoration: InputDecoration(labelText: 'Control Result'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel')),
          ElevatedButton(
              onPressed: () {
                onSave(
                  _sampleTicketController.text,
                  _controlResultController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'))
        ],
      );
    },
  );
}

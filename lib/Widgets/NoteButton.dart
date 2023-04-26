import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class NoteButton extends StatefulWidget {
  final Function(String) onNoteSaved;
  final double width;
  final double height;

  NoteButton({
    required this.onNoteSaved,
    this.width = 56.0,
    this.height = 56.0,
  });

  @override
  _NoteButtonState createState() => _NoteButtonState();
}

class _NoteButtonState extends State<NoteButton> {
  String _noteText = '';

  void _showNoteDialog(BuildContext context,PersonalProvider PersonalCase) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(PersonalCase.GetLable(ResourceKey.Note)),
          content: TextField(
            onChanged: (value) {
              _noteText = value;
            },
            minLines: 10,
            maxLines: null,// Allows multi-line input
            decoration: InputDecoration(hintText: PersonalCase.GetLable(ResourceKey.EnterManditoryData)),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save,size: 20,color: ArgonColors.myLightBlue),
              onPressed: () {
                widget.onNoteSaved(_noteText);
                Navigator.of(context).pop();
                _noteText ='';
              },
            ),
            IconButton(
              icon: Icon(Icons.cancel,size: 20,color: ArgonColors.myLightRed),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final PersonalCase = Provider.of<PersonalProvider>(context);
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: FloatingActionButton(
        backgroundColor: ArgonColors.myNote,
        onPressed: () {
          _showNoteDialog(context,PersonalCase);
        },
        child: Icon(Icons.note_alt_rounded,size: 20,color: ArgonColors.white),
      ),
    );
  }
}

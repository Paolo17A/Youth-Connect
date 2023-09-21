import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/skill_development_model.dart';
import 'package:ywda/utils/instruction_dialogue_util.dart';
import 'package:ywda/widgets/custom_textfield_widget.dart';

class SelectedSubskillScreen extends StatefulWidget {
  final SubSkillModel selectedSubskill;
  const SelectedSubskillScreen({super.key, required this.selectedSubskill});

  @override
  State<SelectedSubskillScreen> createState() => _SelectedSubskillScreenState();
}

class _SelectedSubskillScreenState extends State<SelectedSubskillScreen> {
  bool isLoading = false;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _urlController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(widget.selectedSubskill.subSkillName,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)))),
        actions: [
          IconButton(
              onPressed: () {
                displayInstructionDialogue(
                    context,
                    widget.selectedSubskill.taskName,
                    widget.selectedSubskill.taskDescription);
              },
              icon: Icon(Icons.help_outline_rounded))
        ],
      ),
      body: Stack(children: [
        if (widget.selectedSubskill.requiredTaskType == TaskType.VIDEO)
          videoUploadScreen(context)
        else if (widget.selectedSubskill.requiredTaskType == TaskType.ESSAY)
          essayUploadScreen(context)
        else
          quizScreen(context),
        if (isLoading)
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.5),
              child: Center(child: CircularProgressIndicator()))
      ]),
    );
  }

  Widget videoUploadScreen(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(children: [
              Text('Video Title'),
            ]),
            customTextField(
                'Video Title', _titleController, TextInputType.text),
            Row(children: [
              Text('Video URL'),
            ]),
            customTextField('Video URL', _urlController, TextInputType.url),
            const SizedBox(height: 50),
            ElevatedButton(onPressed: () {}, child: Text('SUBMIT ENTRY'))
          ],
        )));
  }

  Widget essayUploadScreen(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(child: Column()));
  }

  Widget quizScreen(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(child: Column()));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/skill_development_model.dart';
import 'package:ywda/screens/selected_skill_screen.dart';
import 'package:ywda/utils/instruction_dialogue_util.dart';
import 'package:ywda/widgets/custom_textfield_widget.dart';

class SelectedSubskillScreen extends StatefulWidget {
  final SkillDevelopmentModel selectedSkill;
  final SubSkillModel selectedSubskill;
  const SelectedSubskillScreen(
      {super.key, required this.selectedSkill, required this.selectedSubskill});

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

  void _submitVideoContent() async {
    if (_titleController.text.isEmpty || _urlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill up all fields')));
      return;
    } else if (_titleController.text.length < 5 ||
        _titleController.text.length > 50) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Title should be 5 - 50 characters long.')));
      return;
    }
    if (!Uri.tryParse(_urlController.text.trim())!.hasAbsolutePath) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('enter a valid URL')));
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      Map<dynamic, dynamic> skillsDeveloped =
          currentUserData.data()!['skillsDeveloped'];
      if (skillsDeveloped.containsKey(widget.selectedSkill.skillName)) {
        skillsDeveloped[widget.selectedSkill.skillName]
            [widget.selectedSubskill.subSkillName] = {
          'status': 'PENDING',
          'grade': 0,
          'videoTitle': _titleController.text.trim(),
          'videoURL': _urlController.text.trim(),
          'remarks': ''
        };
      } else {
        skillsDeveloped[widget.selectedSkill.skillName] = {
          widget.selectedSubskill.subSkillName: {
            'status': 'PENDING',
            'grade': 0,
            'videoTitle': _titleController.text.trim(),
            'videoURL': _urlController.text.trim(),
            'remarks': ''
          }
        };
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'skillsDeveloped': skillsDeveloped});

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully sent entry!')));
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              SelectedSkillScreen(selectedSkill: widget.selectedSkill)));
    } catch (error) {
      {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error submitting video content: $error')));
      }
    }
  }

  void _submitEssayContent() async {
    if (_titleController.text.isEmpty || _urlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill up all fields')));
      return;
    } else if (_titleController.text.length < 5 ||
        _titleController.text.length > 50) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Title should be 5 - 50 characters long.')));
      return;
    }
    if (_urlController.text.length < 50) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Essay should be at least 50 characters long.')));
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      Map<dynamic, dynamic> skillsDeveloped =
          currentUserData.data()!['skillsDeveloped'];

      if (skillsDeveloped.containsKey(widget.selectedSkill.skillName)) {
        skillsDeveloped[widget.selectedSkill.skillName]
            [widget.selectedSubskill.subSkillName] = {
          'status': 'PENDING',
          'grade': 0.0,
          'essayTitle': _titleController.text.trim(),
          'essayContent': _urlController.text.trim(),
          'remarks': ''
        };
      } else {
        skillsDeveloped[widget.selectedSkill.skillName] = {
          widget.selectedSubskill.subSkillName: {
            'status': 'PENDING',
            'grade': 0.0,
            'essayTitle': _titleController.text.trim(),
            'essayContent': _urlController.text.trim(),
            'remarks': ''
          }
        };
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'skillsDeveloped': skillsDeveloped});

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully sent entry!')));
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              SelectedSkillScreen(selectedSkill: widget.selectedSkill)));
    } catch (error) {
      {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error submitting essay content: $error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_titleController.text.isEmpty || _urlController.text.isEmpty) {
          return true;
        }
        final shouldQuit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text(
                'Are you sure you want to leave? You haven\'t finished submitting your content yet.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Back'),
              ),
            ],
          ),
        );

        if (shouldQuit == true) {
          Navigator.of(context).pop();
        }
        FocusScope.of(context).unfocus();
        return shouldQuit;
      },
      child: Scaffold(
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Stack(children: [
              if (widget.selectedSubskill.requiredTaskType == TaskType.VIDEO)
                videoUploadScreen(context)
              else if (widget.selectedSubskill.requiredTaskType ==
                  TaskType.ESSAY)
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
          ),
        ),
      ),
    );
  }

  Widget videoUploadScreen(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(children: [
              Text('Video Title'),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: customTextField(
                  'Video Title', _titleController, TextInputType.text),
            ),
            const SizedBox(height: 30),
            Row(children: [
              Text('Video URL'),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: customTextField(
                  'Video URL', _urlController, TextInputType.url),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: 125,
                      child: ElevatedButton(
                          onPressed: _submitVideoContent,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: Text('SUBMIT'))),
                ],
              ),
            )
          ],
        ));
  }

  Widget essayUploadScreen(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(children: [
              Text('Essay Title'),
            ]),
            customTextField(
                'Essay Title', _titleController, TextInputType.text),
            const SizedBox(height: 50),
            Row(children: [
              Text('Essay Content'),
            ]),
            customTextField('Write Your Essay Here', _urlController,
                TextInputType.multiline),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: 125,
                      child: ElevatedButton(
                          onPressed: _submitEssayContent,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: Text('SUBMIT'))),
                ],
              ),
            )
          ],
        ));
  }

  Widget quizScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(child: Column())),
    );
  }
}

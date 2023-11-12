import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ywda/widgets/app_drawer_widget.dart';
import 'package:ywda/widgets/custom_containers_widget.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';

class AllFAQsScreen extends StatefulWidget {
  const AllFAQsScreen({super.key});

  @override
  State<AllFAQsScreen> createState() => _AllFAQsScreenState();
}

class _AllFAQsScreenState extends State<AllFAQsScreen> {
  bool _isLoading = true;
  List<DocumentSnapshot> allFAQs = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllFAQs();
  }

  Future getAllFAQs() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final FAQs = await FirebaseFirestore.instance.collection('faqs').get();
      allFAQs = FAQs.docs;
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error getting all FAQs: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Frequently Asked Questions',
            style: TextStyle(color: Color.fromARGB(255, 21, 57, 119))),
      ),
      drawer: appDrawer(context),
      body: SafeArea(
          child: switchedLoadingContainer(
              _isLoading,
              allFAQs.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: allFAQs.length,
                      itemBuilder: (context, index) {
                        final faqData =
                            allFAQs[index].data() as Map<dynamic, dynamic>;
                        String question = faqData['question'];
                        String answer = faqData['answer'];
                        return _FAQEntry(question, answer);
                      })
                  : Text('NO FAQS FOUND'))),
    );
  }

  Widget _FAQEntry(String question, String answer) {
    return allPadding8Pix(ExpansionTile(
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      collapsedBackgroundColor: Color.fromARGB(255, 98, 135, 170),
      backgroundColor: Color.fromARGB(255, 98, 135, 170),
      textColor: Colors.white,
      collapsedTextColor: Colors.white,
      title: Text(question, style: TextStyle(fontWeight: FontWeight.bold)),
      children: <Widget>[
        ListTile(
            title: Text(
          answer,
          style: TextStyle(color: Colors.white),
        )),
      ],
    ));
  }
}

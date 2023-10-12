import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';

import '../widgets/app_bottom_navbar_widget.dart';

class AllProjectsScreen extends StatefulWidget {
  const AllProjectsScreen({super.key});

  @override
  State<AllProjectsScreen> createState() => _AllProjectsScreenState();
}

class _AllProjectsScreenState extends State<AllProjectsScreen> {
  bool _isLoading = true;
  List<DocumentSnapshot> allProjects = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllAnnouncements();
  }

  void getAllAnnouncements() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final projects =
          await FirebaseFirestore.instance.collection('projects').get();
      allProjects = projects.docs;
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error getting all announcements: $error')));
    }
  }

  void toggleJoinState(String projectID, bool isJoining) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      setState(() {
        _isLoading = true;
      });
      final project = await FirebaseFirestore.instance
          .collection('projects')
          .doc(projectID)
          .get();
      List<dynamic> participants =
          (project.data() as Map<dynamic, dynamic>)['participants'];

      if (isJoining) {
        participants.add(FirebaseAuth.instance.currentUser!.uid);
      } else {
        participants.remove(FirebaseAuth.instance.currentUser!.uid);
      }

      await FirebaseFirestore.instance
          .collection('projects')
          .doc(projectID)
          .update({'participants': participants});

      getAllAnnouncements();
      scaffoldMessenger.showSnackBar(SnackBar(
          content: Text(
              'Successfully ${isJoining ? 'joined' : 'left'} this project')));
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error joining project: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/home'));
        return false;
      },
      child: Scaffold(
          bottomNavigationBar: bottomNavigationBar(context, 1),
          body: SafeArea(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.all(10),
                      child: allProjects.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: allProjects.length,
                              itemBuilder: (context, index) {
                                //  Local variables for better readability
                                Map<dynamic, dynamic> project =
                                    allProjects[index].data()
                                        as Map<dynamic, dynamic>;
                                String title = project['title'];
                                String content = project['content'];
                                Timestamp projectDate = project['projectDate'];
                                DateTime dateAnnounced = projectDate.toDate();
                                String formattedDateAnnounced =
                                    DateFormat('dd MMM yyyy')
                                        .format(dateAnnounced);
                                List<dynamic> imageURLs = project['imageURLs'];
                                List<dynamic> participants =
                                    project['participants'];
                                return GestureDetector(
                                    onTap: () {},
                                    child: announcementEntryContainer(
                                        allProjects[index].id,
                                        imageURLs,
                                        formattedDateAnnounced,
                                        title,
                                        content,
                                        participants));
                              })
                          : Center(
                              child: Text('No PROJECTS YET',
                                  style: noEntryTextStyle()))))),
    );
  }

  Widget announcementEntryContainer(
      String projectID,
      List<dynamic> imageURLs,
      String formattedDateAnnounced,
      String title,
      String content,
      List<dynamic> participants) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
            width: double.infinity,
            decoration: projectDecoration(),
            child: Column(
              children: [
                _projectDateWidget(formattedDateAnnounced),
                _projectTitleWidget(title),
                _projectContentWidget(content),
                if (imageURLs.isNotEmpty)
                  _projectImagesContainerWidget(imageURLs),
                _projectJoinButtonWidget(projectID, participants)
              ],
            )));
  }

  Widget _projectDateWidget(String formattedDateAnnounced) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(formattedDateAnnounced,
              style: GoogleFonts.inter(
                  textStyle: TextStyle(color: Colors.black, fontSize: 15))),
        ),
      ],
    );
  }

  Widget _projectTitleWidget(String title) {
    return Padding(
        padding: EdgeInsets.all(11),
        child: Text(title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 23))));
  }

  Widget _projectContentWidget(String content) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Text(content,
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 13))));
  }

  Widget _projectImagesContainerWidget(List<dynamic> imageURLs) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Center(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: imageURLs.length,
              itemBuilder: (context, index) {
                return Container(
                    decoration: BoxDecoration(
                        color: Colors.black, border: Border.all()),
                    child: Image.network(imageURLs[index]));
              }),
        ),
      ),
    );
  }

  Widget _projectJoinButtonWidget(
      String projectID, List<dynamic> participants) {
    String myUID = FirebaseAuth.instance.currentUser!.uid;
    bool isParticipating = participants.contains(myUID);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
              onPressed: () {
                if (isParticipating) {
                  toggleJoinState(projectID, false);
                } else {
                  toggleJoinState(projectID, true);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 156, 183, 209),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10))),
              child: Text(isParticipating ? 'LEAVE' : 'JOIN',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18)))),
        ],
      ),
    );
  }
}

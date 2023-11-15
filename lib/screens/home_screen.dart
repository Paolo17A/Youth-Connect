import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ywda/widgets/app_drawer_widget.dart';
import 'package:ywda/widgets/custom_containers_widget.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';
import 'package:ywda/utils/quit_dialogue_util.dart';
import 'package:ywda/widgets/app_bottom_navbar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  List<dynamic> videos = [];
  bool _viewingAllProjects = true;
  List<DocumentSnapshot> allProjects = [];
  List<DocumentSnapshot> filteredProjects = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllProjects();
  }

  void getAllProjects() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final projects =
          await FirebaseFirestore.instance.collection('projects').get();
      allProjects = projects.docs;
      allProjects = allProjects.reversed.where((project) {
        final projectData = project.data() as Map<dynamic, dynamic>;
        Timestamp dateEnd = projectData['projectDateEnd'];
        DateTime projectDateEnd = dateEnd.toDate();
        return projectDateEnd.isAfter(DateTime.now());
      }).toList();
      filteredProjects = allProjects.where((project) {
        final projectData = project.data() as Map<dynamic, dynamic>;
        List<dynamic> participants = projectData['participants'];
        return participants.contains(FirebaseAuth.instance.currentUser!.uid);
      }).toList();
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

      getAllProjects();
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
      onWillPop: () => displayQuitDialogue(context),
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _isLoading = true;
            getAllProjects();
          });
        },
        child: Scaffold(
            bottomNavigationBar: bottomNavigationBar(context, 1),
            drawer: appDrawer(context),
            appBar: AppBar(
              elevation: 0,
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _viewingAllProjects = !_viewingAllProjects;
                      });
                    },
                    child: Text(
                        _viewingAllProjects
                            ? 'View\nJoined Projects'
                            : 'View\nAll Projects',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)))
              ],
            ),
            body: SafeArea(
                child: switchedLoadingContainer(
                    _isLoading,
                    _viewingAllProjects
                        ? allProjectsContainer()
                        : joinedProjectsContainer()))),
      ),
    );
  }

  Widget allProjectsContainer() {
    return allProjects.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: allProjects.length,
            itemBuilder: (context, index) {
              //  Local variables for better readability
              Map<dynamic, dynamic> project =
                  allProjects[index].data() as Map<dynamic, dynamic>;
              String title = project['title'];
              String content = project['content'];
              Timestamp dateAnnounced = project['dateAdded'];
              String formattedDateAnnounced =
                  DateFormat('dd MMM yyyy').format(dateAnnounced.toDate());
              Timestamp dateStart = project['projectDate'];
              String formattedDateStart =
                  DateFormat('dd MMM yyyy').format(dateStart.toDate());
              Timestamp dateEnd = project['projectDateEnd'];
              String formattedDateEnd =
                  DateFormat('dd MMM yyyy').format(dateEnd.toDate());
              List<dynamic> imageURLs = project['imageURLs'];
              List<dynamic> participants = project['participants'];
              return GestureDetector(
                  onTap: () {},
                  child: projectEntryContainer(
                      allProjects[index].id,
                      imageURLs,
                      formattedDateAnnounced,
                      formattedDateStart,
                      formattedDateEnd,
                      title,
                      content,
                      participants));
            })
        : Center(
            child: Text('NO PROJECTS YET',
                textAlign: TextAlign.center, style: noEntryTextStyle()));
  }

  Widget joinedProjectsContainer() {
    return filteredProjects.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: filteredProjects.length,
            itemBuilder: (context, index) {
              //  Local variables for better readability
              Map<dynamic, dynamic> project =
                  filteredProjects[index].data() as Map<dynamic, dynamic>;
              String title = project['title'];
              String content = project['content'];
              Timestamp dateAnnounced = project['dateAdded'];

              String formattedDateAnnounced =
                  DateFormat('dd MMM yyyy').format(dateAnnounced.toDate());
              Timestamp dateStart = project['projectDate'];
              String formattedDateStart =
                  DateFormat('dd MMM yyyy').format(dateStart.toDate());
              Timestamp dateEnd = project['projectDateEnd'];
              String formattedDateEnd =
                  DateFormat('dd MMM yyyy').format(dateEnd.toDate());
              List<dynamic> imageURLs = project['imageURLs'];
              List<dynamic> participants = project['participants'];
              return GestureDetector(
                  onTap: () {},
                  child: projectEntryContainer(
                      filteredProjects[index].id,
                      imageURLs,
                      formattedDateAnnounced,
                      formattedDateStart,
                      formattedDateEnd,
                      title,
                      content,
                      participants));
            })
        : Center(
            child: Text('YOU HAVE NOT JOINED ANY PROJECTS YET',
                textAlign: TextAlign.center, style: noEntryTextStyle()));
  }

  Widget projectEntryContainer(
      String projectID,
      List<dynamic> imageURLs,
      String formattedDateAnnounced,
      String formattedDateStart,
      String formattedDateEnd,
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
                _projectJoinButtonWidget(projectID, participants,
                    formattedDateStart, formattedDateEnd)
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
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: Image.network(imageURLs[index])),
                );
              }),
        ),
      ),
    );
  }

  Widget _projectJoinButtonWidget(String projectID, List<dynamic> participants,
      String formattedDateStart, String formattedDateEnd) {
    String myUID = FirebaseAuth.instance.currentUser!.uid;
    bool isParticipating = participants.contains(myUID);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date Start: $formattedDateStart',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(color: Colors.black, fontSize: 15))),
              Text('Date End: $formattedDateEnd',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(color: Colors.black, fontSize: 15)))
            ],
          ),
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

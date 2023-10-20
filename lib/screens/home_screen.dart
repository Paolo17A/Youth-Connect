import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:ywda/screens/view_announcement_screen.dart';
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
  List<DocumentSnapshot> allAnnouncements = [];
  List<DocumentSnapshot> allProjects = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllAnnouncementsAndProjects();
  }

  void getAllAnnouncementsAndProjects() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final articles =
          await FirebaseFirestore.instance.collection('announcements').get();
      allAnnouncements = articles.docs;

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

  Future<Uint8List> generateThumbnail(String videoPath) async {
    final uint8list = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        maxWidth:
            128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 25);
    return uint8list!;
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

      getAllAnnouncementsAndProjects();
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
      child: Scaffold(
          bottomNavigationBar: bottomNavigationBar(context, 1),
          body: SafeArea(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [articlesContainer(), projectsContainer()],
                      ),
                    ))),
    );
  }

  Widget articlesContainer() {
    return Column(
      children: [
        Text('Announcements',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(fontWeight: FontWeight.bold))),
        _halfedHomeContainer(allAnnouncements.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: allAnnouncements.length,
                itemBuilder: (context, index) {
                  //  Local variables for better readability
                  Map<dynamic, dynamic> announcement =
                      allAnnouncements[index].data() as Map<dynamic, dynamic>;
                  String title = announcement['title'];
                  String content = announcement['content'];
                  Timestamp dateAdded = announcement['dateAdded'];
                  DateTime dateAnnounced = dateAdded.toDate();
                  String formattedDateAnnounced =
                      DateFormat('dd MMM yyyy').format(dateAnnounced);
                  List<dynamic> imageURLs = announcement['imageURLs'];
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewAnnouncementScreen(
                                announcement: allAnnouncements[index])));
                      },
                      child: announcementEntryContainer(
                          imageURLs, formattedDateAnnounced, title, content));
                })
            : Center(
                child:
                    Text('No ANNOUNCEMENTS YET', style: noEntryTextStyle()))),
      ],
    );
  }

  Widget projectsContainer() {
    return Column(
      children: [
        Text('Projects',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(fontWeight: FontWeight.bold))),
        _halfedHomeContainer(allProjects.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: allProjects.length,
                itemBuilder: (context, index) {
                  //  Local variables for better readability
                  Map<dynamic, dynamic> project =
                      allProjects[index].data() as Map<dynamic, dynamic>;
                  String title = project['title'];
                  String content = project['content'];
                  Timestamp projectDate = project['projectDate'];
                  DateTime dateAnnounced = projectDate.toDate();
                  String formattedDateAnnounced =
                      DateFormat('dd MMM yyyy').format(dateAnnounced);
                  List<dynamic> imageURLs = project['imageURLs'];
                  List<dynamic> participants = project['participants'];
                  return GestureDetector(
                      onTap: () {},
                      child: projectEntryContainer(
                          allProjects[index].id,
                          imageURLs,
                          formattedDateAnnounced,
                          title,
                          content,
                          participants));
                })
            : Center(
                child: Text('No PROJECTS YET', style: noEntryTextStyle()))),
      ],
    );
  }

  Widget _halfedHomeContainer(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 98, 135, 170).withOpacity(0.3),
              borderRadius: BorderRadius.circular(10)),
          child: child),
    );
  }

  Widget announcementEntryContainer(List<dynamic> imageURLs,
      String formattedDateAnnounced, String title, String content) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
            width: double.infinity,
            height: 90,
            decoration: decorationWithShadow(),
            child: Row(
              children: [
                if (imageURLs.isNotEmpty)
                  allPadding4pix(_miniNetworkImage(imageURLs[0])),
                announcementEntryTextContainer(
                    imageURLs, formattedDateAnnounced, title, content)
              ],
            )));
  }

  Widget announcementEntryTextContainer(List<dynamic> imageURLs,
      String formattedDateAnnounced, String title, String content) {
    return SizedBox(
      width:
          imageURLs.isNotEmpty ? MediaQuery.of(context).size.width * 0.6 : 300,
      child: Column(
        children: [
          allPadding4pix(Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(formattedDateAnnounced,
                  textAlign: TextAlign.right, style: TextStyle(fontSize: 14)),
            ],
          )),
          horizontalPadding5pix(Text(title, style: titleTextStyle())),
          horizontalPadding5pix(SizedBox(
            width: 220,
            height: 40,
            child: Text(content, softWrap: true, style: contentTextStyle()),
          ))
        ],
      ),
    );
  }

  Widget projectEntryContainer(
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

  Widget _miniNetworkImage(String src) {
    return Container(
      width: 80,
      height: 80,
      child: Image.network(src),
    );
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:ywda/screens/view_announcement_screen.dart';
import 'package:ywda/utils/custom_styling_util.dart';
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

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllAnnouncements();
  }

  Future<void> readJson() async {
    String response = await rootBundle.loadString('lib/data/videos.json');
    Map<dynamic, dynamic> data = await json.decode(response);
    videos = data['videos'];

    setState(() {
      _isLoading = false;
    });
  }

  void getAllAnnouncements() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final articles =
          await FirebaseFirestore.instance.collection('announcements').get();
      allAnnouncements = articles.docs;
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

  _launchURL(String _url) async {
    final url = Uri.parse(_url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Handle the case where the URL cannot be launched
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => displayQuitDialogue(context),
      child: Scaffold(
          bottomNavigationBar: bottomNavigationBar(context, 2),
          body: SafeArea(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        articlesContainer(),
                        //videosContainer()
                      ],
                    ))),
    );
  }

  Widget articlesContainer() {
    return _halfedHomeContainer(allAnnouncements.isNotEmpty
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
            child: Text('No ANNOUNCEMENTS YET', style: noEntryTextStyle())));
  }

  Widget videosContainer() {
    return _halfedHomeContainer(
      videos.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _launchURL(videos[index]['videoURL']),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        width: double.infinity,
                        height: 80,
                        decoration: decorationWithShadow(),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                width: 80,
                                height: 80,
                                color: Colors.black,
                                child: FutureBuilder(
                                    future: generateThumbnail(
                                        videos[index]['videoURL']),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Image.memory(snapshot.data!);
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    }),
                              ),
                            ),
                            horizontalPadding5pix(Text(
                                videos[index]['videoTitle'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)))
                          ],
                        )),
                  ),
                );
              })
          : Center(
              child: Text('No VIDEOS POSTED YET', style: noEntryTextStyle())),
    );
  }

  Widget _halfedHomeContainer(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(15),
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

  Widget _miniNetworkImage(String src) {
    return Container(
      width: 80,
      height: 80,
      child: Image.network(src),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:ywda/utils/quit_dialogue_util.dart';
import 'package:ywda/widgets/app_bottom_navbar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  List<dynamic> articles = [];
  List<dynamic> videos = [];
  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    String response = await rootBundle.loadString('lib/data/articles.json');
    Map<dynamic, dynamic> data = await json.decode(response);
    articles = data['articles'];

    response = await rootBundle.loadString('lib/data/videos.json');
    data = await json.decode(response);
    videos = data['videos'];

    setState(() {
      _isLoading = false;
    });
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
                        //  ARTICLES
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 98, 135, 170)
                                    .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10)),
                            child: articles.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: articles.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          print(
                                              'Selected ${articles[index]['articleTitle']}');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                              width: double.infinity,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      blurRadius: 5,
                                                      spreadRadius: 2,
                                                      offset: Offset(0, 5))
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  if ((articles[index]
                                                              ['imageURLs']
                                                          as List<dynamic>)
                                                      .isNotEmpty)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: Container(
                                                        width: 80,
                                                        height: 80,
                                                        child: Image.network(
                                                            (articles[index][
                                                                    'imageURLs']
                                                                as List<
                                                                    dynamic>)[0]),
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    width: (articles[index][
                                                                    'imageURLs']
                                                                as List<
                                                                    dynamic>)
                                                            .isNotEmpty
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6
                                                        : 300,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          child: Text(
                                                              'INSERT DATE HERE',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Text(
                                                              articles[index][
                                                                  'articleTitle'],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      18)),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: SizedBox(
                                                            width: 220,
                                                            height: 40,
                                                            child: Text(
                                                                articles[index][
                                                                    'articleContent'],
                                                                softWrap: true,
                                                                style: TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontSize:
                                                                        15)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      );
                                    })
                                : Center(
                                    child: Text(
                                        'No articles have been written yet',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold))),
                          ),
                        ),
                        //  VIDEOS
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 98, 135, 170)
                                    .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10)),
                            child: articles.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: videos.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () => _launchURL(
                                            videos[index]['videoURL']),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                              width: double.infinity,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      blurRadius: 5,
                                                      spreadRadius: 2,
                                                      offset: Offset(0, 5))
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child: Container(
                                                      width: 80,
                                                      height: 80,
                                                      color: Colors.black,
                                                      child: FutureBuilder(
                                                          future:
                                                              generateThumbnail(
                                                                  videos[index][
                                                                      'videoURL']),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .done) {
                                                              return Image.memory(
                                                                  snapshot
                                                                      .data!);
                                                            } else {
                                                              return CircularProgressIndicator();
                                                            }
                                                          }),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5),
                                                    child: Text(
                                                        videos[index]
                                                            ['videoTitle'],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18)),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      );
                                    })
                                : Center(
                                    child: Text('No videos posted yet',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold))),
                          ),
                        )
                      ],
                    ))),
    );
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
}

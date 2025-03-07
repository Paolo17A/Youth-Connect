import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAnnouncementScreen extends StatelessWidget {
  final dynamic announcement;
  const ViewAnnouncementScreen({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(announcement['title'],
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontWeight: FontWeight.bold)))),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 21, 57, 119)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(announcement['title'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25))),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(announcement['content'],
                      style: GoogleFonts.poppins()),
                ),
              ),
              if ((announcement['imageURLs'] as List<dynamic>).isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.4,
                    color: Colors.blueAccent.withOpacity(0.25),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            (announcement['imageURLs'] as List<dynamic>).length,
                        itemBuilder: (context, index) {
                          List<dynamic> images =
                              (announcement['imageURLs'] as List<dynamic>);
                          return Container(
                              color: Colors.black,
                              child: Image.network(images[index]));
                        }),
                  ),
                )
            ],
          )),
        ));
  }
}

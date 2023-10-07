import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/self_identification_model.dart';

class SelfIdentificationScreen extends StatefulWidget {
  const SelfIdentificationScreen({super.key});

  @override
  State<SelfIdentificationScreen> createState() =>
      _SelfIdentificationScreenState();
}

class _SelfIdentificationScreenState extends State<SelfIdentificationScreen> {
  bool _isLoading = true;
  Map<dynamic, dynamic> selfIdentity = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getSelfIdentificationData();
  }

  void getSelfIdentificationData() async {
    try {
      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (currentUserData.data()!.containsKey('selfIdentification')) {
        selfIdentity = currentUserData.data()!['selfIdentification'];
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'selfIdentification': selfIdentity});
      }
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error getting self identification data: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 171, 207),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Self-Identification',
                            style: GoogleFonts.notoSansBengali(
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'lib/assets/images/icons/si_bg-portrait.jpg'),
                                  fit: BoxFit.cover)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                      'Answer the questions before we start.',
                                      style: GoogleFonts.notoSansBengali(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))),
                                ),
                                Container(
                                  color: Colors.green,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: allSelfIdentification[0]
                                          .questions
                                          .length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                height: 70,
                                                color: Colors.red,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Text('#${index + 1}',
                                                        style: GoogleFonts.novaScript(
                                                            textStyle: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 23))),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.55,
                                                        child: Text(
                                                          allSelfIdentification[
                                                                  0]
                                                              .questions[index],
                                                          style: GoogleFonts
                                                              .notoSerif(),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 34, 52, 189),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Text('START',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30))),
                                )))
                      ],
                    ),
                  ),
                )));
  }
}

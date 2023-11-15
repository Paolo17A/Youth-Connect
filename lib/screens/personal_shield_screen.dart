import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:widget_mask/widget_mask.dart';
import 'package:ywda/widgets/custom_containers_widget.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';

import '../utils/instruction_dialogue_util.dart';

class PersonalShieldScreen extends StatefulWidget {
  const PersonalShieldScreen({super.key});

  @override
  State<PersonalShieldScreen> createState() => _PersonalShieldScreenState();
}

class _PersonalShieldScreenState extends State<PersonalShieldScreen> {
  bool _isLoading = false;
  Map<dynamic, dynamic> personalShieldEntries = {};
  File? _imageFile;
  late ImagePicker imagePicker;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getPersonalShield();
  }

  Future getPersonalShield() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = user.data() as Map<dynamic, dynamic>;
      personalShieldEntries = userData['personalShield'];
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error getting personal shield: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future _uploadEntry(String _personalShieldParameter) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      setState(() {
        _isLoading = true;
      });
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('shieldEntries')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(_personalShieldParameter);

      final uploadTask = storageRef.putFile(_imageFile!);
      final taskSnapshot = await uploadTask.whenComplete(() {});
      final downloadURL = await taskSnapshot.ref.getDownloadURL();

      // Update the user's data in Firestore with the image URL
      personalShieldEntries[_personalShieldParameter] = {
        'imageURL': downloadURL
      };
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'personalShield': personalShieldEntries,
      });
      getPersonalShield();
    } catch (error) {
      scaffoldMessenger.showSnackBar(SnackBar(
          content: Text('Error uploading personal shield entry: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: stackedLoadingContainer(
              context,
              _isLoading,
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        image: AssetImage('lib/assets/images/icons/si_bg.jpg'),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(Icons.arrow_back)),
                        Text('My Personal Shield',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.satisfy(
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))),
                        IconButton(
                            onPressed: () {
                              selfAssessmentInstructionDialogue(
                                  context,
                                  'Create your own personal shield',
                                  'Press the circle in the middle of the shiled to upload an entry.',
                                  height:
                                      MediaQuery.of(context).size.height * 0.4);
                            },
                            icon: Icon(Icons.help_outline_rounded))
                      ],
                    ),
                    Gap(10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.2),
                          borderRadius: BorderRadius.circular(25),
                          color: Color.fromARGB(255, 219, 219, 219)),
                      child: Center(
                        child: Stack(
                          children: [
                            Image.asset(
                                'lib/assets/images/shield/PersonalShield.png'),
                            _somethingIDoWell(),
                            _greatestCharacterStrength(),
                            _bestCompliment(),
                            _worstCharacterFlaw(),
                            _whatMakesMeUnique(),
                            _favoritePeople(),
                            _viewEntriesCenterShield()
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
              ))),
    );
  }

  Widget _somethingIDoWell() {
    if (!personalShieldEntries.containsKey('somethingIDoWell')) {
      return Image.asset('lib/assets/images/shield/somethingIDoWell.png');
    } else {
      return WidgetMask(
          blendMode: BlendMode.srcATop,
          childSaveLayer: true,
          mask: Stack(
            children: [
              Positioned(
                  bottom: -10,
                  left: -150,
                  child: Image.network(
                      personalShieldEntries['somethingIDoWell']['imageURL'])),
            ],
          ),
          child: Image.asset('lib/assets/images/shield/upperleft.png'));
    }
  }

  Widget _greatestCharacterStrength() {
    if (!personalShieldEntries.containsKey('myGreatestCharacterStrength')) {
      return Image.asset(
          'lib/assets/images/shield/myGreatestCharacterStrength.png');
    } else {
      return WidgetMask(
          blendMode: BlendMode.srcATop,
          childSaveLayer: true,
          mask: Stack(
            children: [
              Positioned(
                  bottom: -10,
                  right: -150,
                  child: Image.network(
                      personalShieldEntries['myGreatestCharacterStrength']
                          ['imageURL'])),
            ],
          ),
          child: Image.asset('lib/assets/images/shield/upperright.png'));
    }
  }

  Widget _bestCompliment() {
    if (!personalShieldEntries.containsKey('bestCompliment')) {
      return Image.asset('lib/assets/images/shield/bestCompliment.png');
    } else {
      return WidgetMask(
          blendMode: BlendMode.srcATop,
          childSaveLayer: true,
          mask: Stack(
            children: [
              Positioned(
                  bottom: -100,
                  left: -175,
                  child: Image.network(
                      personalShieldEntries['bestCompliment']['imageURL'])),
            ],
          ),
          child: Image.asset('lib/assets/images/shield/left.png'));
    }
  }

  Widget _worstCharacterFlaw() {
    if (!personalShieldEntries.containsKey('worstCharacterFlaw')) {
      return Image.asset('lib/assets/images/shield/worstCharacterFlaw.png');
    } else {
      return WidgetMask(
          blendMode: BlendMode.srcATop,
          childSaveLayer: true,
          mask: Stack(
            children: [
              Positioned(
                  bottom: -100,
                  right: -175,
                  child: Image.network(
                      personalShieldEntries['worstCharacterFlaw']['imageURL'])),
            ],
          ),
          child: Image.asset('lib/assets/images/shield/right.png'));
    }
  }

  Widget _whatMakesMeUnique() {
    if (!personalShieldEntries.containsKey('whatMakesMeUnique')) {
      return Image.asset('lib/assets/images/shield/whatMakesMeUnique.png');
    } else {
      return WidgetMask(
          blendMode: BlendMode.srcATop,
          childSaveLayer: true,
          mask: Stack(
            children: [
              Positioned(
                  bottom: -200,
                  left: -115,
                  child: Image.network(
                      personalShieldEntries['whatMakesMeUnique']['imageURL'])),
            ],
          ),
          child: Image.asset('lib/assets/images/shield/lowerleft.png'));
    }
  }

  Widget _favoritePeople() {
    if (!personalShieldEntries.containsKey('favoritePeople')) {
      return Image.asset('lib/assets/images/shield/favoritePeople.png');
    } else {
      return WidgetMask(
          blendMode: BlendMode.srcATop,
          childSaveLayer: true,
          mask: Stack(
            children: [
              Positioned(
                  bottom: -200,
                  right: -115,
                  child: Image.network(
                      personalShieldEntries['favoritePeople']['imageURL'])),
            ],
          ),
          child: Image.asset('lib/assets/images/shield/lowerright.png'));
    }
  }

  Widget _viewEntriesCenterShield() {
    return Positioned(
        left: 110,
        bottom: 122,
        child: GestureDetector(
          onTap: () => showsectionSelectionModal(),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 58,
            child: Text('View Entries',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: Colors.black)),
          ),
        ));
  }

  void showsectionSelectionModal() {
    showModalBottomSheet(
        context: context,
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
        backgroundColor: Colors.transparent,
        builder: (context) => Wrap(
              children: [
                ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    title: Center(child: Text('Something I Do Well')),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (personalShieldEntries
                          .containsKey('somethingIDoWell')) {
                        showUploadedImage('somethingIDoWell');
                      } else {
                        showUploadEntryDialog(
                            'Something I Do Well', 'somethingIDoWell');
                      }
                    }),
                ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(),
                    title: Center(
                      child: Text('Greatest Character Strength'),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (personalShieldEntries
                          .containsKey('myGreatestCharacterStrength')) {
                        showUploadedImage('myGreatestCharacterStrength');
                      } else {
                        showUploadEntryDialog('Greatest Character Strength',
                            'myGreatestCharacterStrength');
                      }
                    }),
                ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(),
                    title: Center(
                      child: Text('Best Compliment'),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (personalShieldEntries.containsKey('bestCompliment')) {
                        showUploadedImage('bestCompliment');
                      } else {
                        showUploadEntryDialog(
                            'Best Compliment', 'bestCompliment');
                      }
                    }),
                ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(),
                    title: Center(
                      child: Text('Worst Character Flaw'),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (personalShieldEntries
                          .containsKey('worstCharacterFlaw')) {
                        showUploadedImage('worstCharacterFlaw');
                      } else {
                        showUploadEntryDialog(
                            'Worst Character Flaw', 'worstCharacterFlaw');
                      }
                    }),
                ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(),
                    title: Center(
                      child: Text('What Makes Me Unique'),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (personalShieldEntries
                          .containsKey('whatMakesMeUnique')) {
                        showUploadedImage('whatMakesMeUnique');
                      } else {
                        showUploadEntryDialog(
                            'What Makes Me Unique', 'whatMakesMeUnique');
                      }
                    }),
                ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(),
                    title: Center(
                      child: Text('Favorite People'),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (personalShieldEntries.containsKey('favoritePeople')) {
                        showUploadedImage('favoritePeople');
                      } else {
                        showUploadEntryDialog(
                            'Favorite People', 'favoritePeople');
                      }
                    }),
              ],
            ));
  }

  void showUploadedImage(String _shieldParameter) {
    showDialog(
        context: context,
        builder: (context) => GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.network(
                      personalShieldEntries[_shieldParameter]['imageURL'])),
            ));
  }

  void showUploadEntryDialog(String _shieldEntry, String _parameterName) {
    setState(() {
      _imageFile = null;
    });
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                content: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: allPadding4pix(Column(
                      children: [
                        Text(
                          'Upload an Entry for:\n $_shieldEntry',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(border: Border.all()),
                          child: Center(
                            child: _imageFile == null
                                ? Text('No Image Selected')
                                : Image.file(_imageFile!),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await _pickImage();
                              setState(() {});
                            },
                            child: Text('Select an Image')),
                        Gap(40),
                        if (_imageFile != null)
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _uploadEntry(_parameterName);
                              },
                              child: Text('Upload Image'))
                      ],
                    ))),
              ),
            ));
  }
}

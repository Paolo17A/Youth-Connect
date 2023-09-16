import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/organization_model.dart';
import 'package:ywda/widgets/custom_textfield_widget.dart';
import 'package:ywda/widgets/dropdown_widget.dart';

class RegisterSecondPageScreen extends StatefulWidget {
  final String fullName;
  final String gender;
  final String civilStatus;
  final DateTime birthday;
  final String city;
  const RegisterSecondPageScreen(
      {super.key,
      required this.fullName,
      required this.gender,
      required this.civilStatus,
      required this.birthday,
      required this.city});

  @override
  State<RegisterSecondPageScreen> createState() =>
      _RegisterSecondPageScreenState();
}

class _RegisterSecondPageScreenState extends State<RegisterSecondPageScreen> {
  bool _isLoading = false;
  String? _selectedOrg = '';
  String? _selectedNature;
  String? _selectedStatus = '';

  final TextEditingController _orgController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _orgController.dispose();
    _schoolController.dispose();
    _positionController.dispose();
  }

  void _submitRegistrationData() async {
    try {
      setState(() {
        _isLoading = true;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      _orgController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text('Registration', style: GoogleFonts.poppins()))),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                bottom: -40,
                right: -30,
                child: Transform.scale(
                  scaleY: -1,
                  child: Image.asset('lib/assets/images/icons/Design.png',
                      scale: 2.75),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: dropdownWidget(
                              _selectedOrg != null ? _selectedOrg! : '',
                              (selected) {
                            setState(() {
                              if (selected != null) {
                                _selectedOrg = selected;
                                setState(() {
                                  _selectedNature =
                                      getOrganizationByName(_selectedOrg!)
                                          .nature;
                                });
                              }
                            });
                          }, getOrganizationNames(), 'Organization', true)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                              _selectedNature != null
                                  ? _selectedNature!
                                  : 'Nature of Organization',
                              style: GoogleFonts.poppins()),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 120,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 34, 52, 189),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                onPressed: _submitRegistrationData,
                                child: Text('SUBMIT',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: 14))),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (_isLoading)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

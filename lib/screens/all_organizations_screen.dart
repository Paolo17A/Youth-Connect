import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/screens/selected_organization_screen.dart';
import 'package:ywda/widgets/custom_textfield_widget.dart';

import '../models/organization_model.dart';
import '../widgets/app_bottom_navbar_widget.dart';

class AllOrganizationsScreen extends StatefulWidget {
  const AllOrganizationsScreen({super.key});

  @override
  State<AllOrganizationsScreen> createState() => _AllOrganizationsScreenState();
}

class _AllOrganizationsScreenState extends State<AllOrganizationsScreen> {
  //String? _selectedOrg = '';
  bool _isLoading = true;

  final TextEditingController _searchController = TextEditingController();
  List<OrganizationModel> allNetworkOrgs = [];
  List<OrganizationModel> filteredNetworkOrgs = [];
  //List<OrganizationModel> filteredOrganizations = List.from(allOrganizations);

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    getAllOrgs();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void _onSearchChanged() {
    final searchText = _searchController.text.toLowerCase().trim();
    setState(() {
      filteredNetworkOrgs = allNetworkOrgs.where((org) {
        final name = org.name.toLowerCase().trim();
        return name.contains(searchText);
      }).toList();
    });
  }

  Future getAllOrgs() async {
    try {
      final orgs = await FirebaseFirestore.instance.collection('orgs').get();
      final allOrgs = orgs.docs;
      for (var org in allOrgs) {
        Map<dynamic, dynamic> orgData = org.data();
        allNetworkOrgs.add(OrganizationModel(
            name: orgData['name'],
            nature: orgData['nature'],
            contactDetails: orgData['contactDetails'],
            intro: orgData['intro'],
            socMed: orgData['socMed'],
            logoURL: orgData['logoURL'],
            coverURL: orgData['coverURL']));
      }
      setState(() {
        filteredNetworkOrgs = List.from(allNetworkOrgs);
        _isLoading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting all orgs: $error')));
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
          bottomNavigationBar: bottomNavigationBar(context, 2),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: customTextField(
                            'Search', _searchController, TextInputType.name),
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredNetworkOrgs.length,
                            itemBuilder: (context, index) {
                              return _networkedOrganizationButton(
                                  filteredNetworkOrgs[index]);
                            }),
                      )
                    ]),
            ),
          )),
    );
  }

  Widget _networkedOrganizationButton(OrganizationModel networkedOrg) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        children: [
          //  Button with Name
          Row(
            children: [
              SizedBox(
                  height: 100, width: MediaQuery.of(context).size.width * 0.15),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.83,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectedOrganizationScreen(
                                  selectedOrg: networkedOrg)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Text(networkedOrg.name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700))),
                    )),
              ),
            ],
          ),
          Row(children: [
            SizedBox(
                height: 90,
                width: MediaQuery.of(context).size.width * 0.3,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder()),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectedOrganizationScreen(
                                  selectedOrg: networkedOrg)));
                    },
                    child: networkedOrg.logoURL.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadiusDirectional.circular(45),
                            child: Image.network(networkedOrg.logoURL))
                        : Text('NO IMAGE AVAILABLE',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(color: Colors.black)))),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.5,
            )
          ])
        ],
      ),
    );
  }
}

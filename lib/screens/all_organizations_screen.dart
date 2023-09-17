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

  final TextEditingController _searchController = TextEditingController();
  List<OrganizationModel> filteredOrganizations = List.from(allOrganizations);

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void _onSearchChanged() {
    print('typing');
    final searchText = _searchController.text.toLowerCase().trim();
    setState(() {
      filteredOrganizations = allOrganizations.where((org) {
        final name = org.name.toLowerCase().trim();
        return name.contains(searchText);
      }).toList();
    });
    print('orgs found: ${filteredOrganizations.length}');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/home'));
        return false;
      },
      child: Scaffold(
          bottomNavigationBar: bottomNavigationBar(context, 3),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customTextField(
                      'Search', _searchController, TextInputType.name),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredOrganizations.length,
                      itemBuilder: (context, index) {
                        return _organizationButton(
                            filteredOrganizations[index]);
                      }),
                )
              ]),
            ),
          )),
    );
  }

  Widget _organizationButton(OrganizationModel displayedOrg) {
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
                                  selectedOrg: displayedOrg)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Text(displayedOrg.name,
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
                                  selectedOrg: displayedOrg)));
                    },
                    child: displayedOrg.logoURL.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadiusDirectional.circular(45),
                            child: Image.asset(displayedOrg.logoURL))
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

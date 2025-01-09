import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgainstCrimeScreen extends StatefulWidget {
  const AgainstCrimeScreen({super.key});

  @override
  State<AgainstCrimeScreen> createState() => _AgainstCrimeScreenState();
}

class _AgainstCrimeScreenState extends State<AgainstCrimeScreen> {
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController fatherController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController date_timeController = TextEditingController();

  String? _selectedTehsil;
  // String? _selectedDistric;

  // static const TextStyle textStyle = TextStyle(
  //   fontFamily: 'Barlow',
  //   fontSize: 16.0,
  //   fontWeight: FontWeight.bold,
  //   letterSpacing: 1,
  // );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF2A489E),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: const Color(0xFF2A489E),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: const Color(0xFF2A489E),
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.miscellaneous_services,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.sos,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.settings,
            color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.account_circle_sharp,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 22.0),
              const CircleAvatar(
                  radius: 65.0,
                  backgroundImage: AssetImage('images/Police.png')),
              const SizedBox(height: 14.0),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'PRE FIR AGAINST ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: 3.36,
                      ),
                    ),
                    TextSpan(
                      text: 'CRIME',
                      style: TextStyle(
                        color: Color(0xFFE22128),
                        fontSize: 16,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: 3.36,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              Expanded(
                child: Container(
                  width: 390,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text('Fill Compliant Form',
                              style: TextStyle(
                                  color: Color(0xFF2A489E),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          const SizedBox(height: 10),
                          _buildTextField(subjectController, 'Subject'),
                          const SizedBox(height: 10),
                          _buildTextField(provinceController, 'Province'),
                          const SizedBox(height: 10),
                          _buildDistricDropdown(),
                          const SizedBox(height: 10),
                          _buildTehsilDropdown(),
                          const SizedBox(height: 10),
                          // _buildStationDropdown(),
                          _buildTextField(nameController, 'Full Name'),
                          const SizedBox(height: 10),
                          _buildTextField(fatherController, 'Father Name'),
                          const SizedBox(height: 10),
                          _buildTextField(cnicController, 'CNIC'),
                          const SizedBox(height: 10),
                          _buildTextField(phoneController, 'Contact Number'),
                          const SizedBox(height: 10),
                          _buildTextField(date_timeController, 'Date Of Birth'),
                          const SizedBox(height: 10),
                          _buildTextField(date_timeController, 'Complainer Address'),
                          const SizedBox(height: 10),
                          _buildTextField(date_timeController, 'Incident Location'),
                          const SizedBox(height: 10),
                          _buildTextField(date_timeController, 'Incident Date-Time'),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 1.0,
                            width: 300.0,
                            child: Center(
                              child: Container(
                                margin:const EdgeInsetsDirectional.only(start: 1.0, end: 4.0),
                                height: 5.0,
                                color: const Color(0xFF2A489E).withOpacity(0.5)
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            width: 245.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () => (),
                              child: const Text('Submit'),
                            ),
                          ),
                          const SizedBox(height: 60),
                        ],
                      ),

                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return SizedBox(
      width: 300.0,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 15.0, color: Color(0xFF203982)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF203982), width: 0.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF203982), width: 1.0),
          ),
        ),
      ),
    );
  }

  Widget _buildTehsilDropdown() {
    return SizedBox(
      width: 300.0, // Match the width of TextField
      child: DropdownButtonFormField<String>(
        value: _selectedTehsil,
        decoration: const InputDecoration(
          labelText: 'Select your Tehsil',
          border: OutlineInputBorder(),
          labelStyle: TextStyle(fontSize: 15.0, color: Color(0xFF203982)),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF203982), width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF203982), width: 1.0),
          ),
        ),
        onChanged: (String? newValue) {
          setState(() {
            _selectedTehsil = newValue;
          });
        },
        items: <String>['Abc', 'abc', 'acb']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                  color: Color(0xFF203982), fontWeight: FontWeight.w400),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDistricDropdown() {
    return SizedBox(
      width: 300.0, // Match the width of TextField
      child: DropdownButtonFormField<String>(
        value: _selectedTehsil,
        decoration: const InputDecoration(
          labelText: 'Select your Tehsil',
          border: OutlineInputBorder(),
          labelStyle: TextStyle(fontSize: 15.0, color: Color(0xFF203982)),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF203982), width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF203982), width: 1.0),
          ),
        ),
        onChanged: (String? newValue) {
          setState(() {
            _selectedTehsil = newValue;
          });
        },
        items: <String>['Abc', 'abc', 'acb']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                  color: Color(0xFF203982), fontWeight: FontWeight.w400),
            ),
          );
        }).toList(),
      ),
    );
  }
}

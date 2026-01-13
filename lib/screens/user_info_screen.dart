import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_localizations.dart';
import '../services/firebase_service.dart';
import 'loading_screen.dart';

class UserInfoScreen extends StatefulWidget {
  final Map<String, int> characterScores;

  const UserInfoScreen({super.key, required this.characterScores});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  String? selectedGender;
  String? selectedAge;
  String? selectedNationality;
  bool _isSubmitting = false;

  final List<String> genders = [
    AppLocalizations.female,
    AppLocalizations.male,
    AppLocalizations.others,
  ];

  final List<String> ageGroups = ['18-24', '25-34', '35-44', '45-54', '55+'];

  final List<String> nationalities = [
    'Afghan',
    'Albanian',
    'Algerian',
    'American',
    'Andorran',
    'Angolan',
    'Antiguans',
    'Argentinean',
    'Armenian',
    'Australian',
    'Austrian',
    'Azerbaijani',
    'Bahamian',
    'Bahraini',
    'Bangladeshi',
    'Barbadian',
    'Barbudans',
    'Batswana',
    'Belarusian',
    'Belgian',
    'Belizean',
    'Beninese',
    'Bhutanese',
    'Bolivian',
    'Bosnian',
    'Brazilian',
    'British',
    'Bruneian',
    'Bulgarian',
    'Burkinabe',
    'Burmese',
    'Burundian',
    'Cambodian',
    'Cameroonian',
    'Canadian',
    'Cape Verdean',
    'Central African',
    'Chadian',
    'Chilean',
    'Chinese',
    'Colombian',
    'Comoran',
    'Congolese',
    'Costa Rican',
    'Croatian',
    'Cuban',
    'Cypriot',
    'Czech',
    'Danish',
    'Djibouti',
    'Dominican',
    'Dutch',
    'East Timorese',
    'Ecuadorean',
    'Egyptian',
    'Emirian',
    'Equatorial Guinean',
    'Eritrean',
    'Estonian',
    'Ethiopian',
    'Fijian',
    'Filipino',
    'Finnish',
    'French',
    'Gabonese',
    'Gambian',
    'Georgian',
    'German',
    'Ghanaian',
    'Greek',
    'Grenadian',
    'Guatemalan',
    'Guinea-Bissauan',
    'Guinean',
    'Guyanese',
    'Haitian',
    'Herzegovinian',
    'Honduran',
    'Hungarian',
    'Icelander',
    'Indian',
    'Indonesian',
    'Iranian',
    'Iraqi',
    'Irish',
    'Israeli',
    'Italian',
    'Ivorian',
    'Jamaican',
    'Japanese',
    'Jordanian',
    'Kazakhstani',
    'Kenyan',
    'Kittian and Nevisian',
    'Kuwaiti',
    'Kyrgyz',
    'Laotian',
    'Latvian',
    'Lebanese',
    'Liberian',
    'Libyan',
    'Liechtensteiner',
    'Lithuanian',
    'Luxembourger',
    'Macedonian',
    'Malagasy',
    'Malawian',
    'Malaysian',
    'Maldivian',
    'Malian',
    'Maltese',
    'Marshallese',
    'Mauritanian',
    'Mauritian',
    'Mexican',
    'Micronesian',
    'Moldovan',
    'Monacan',
    'Mongolian',
    'Moroccan',
    'Mosotho',
    'Motswana',
    'Mozambican',
    'Namibian',
    'Nauruan',
    'Nepalese',
    'New Zealander',
    'Nicaraguan',
    'Nigerian',
    'Nigerien',
    'North Korean',
    'Northern Irish',
    'Norwegian',
    'Omani',
    'Pakistani',
    'Palauan',
    'Panamanian',
    'Papua New Guinean',
    'Paraguayan',
    'Peruvian',
    'Polish',
    'Portuguese',
    'Qatari',
    'Romanian',
    'Russian',
    'Rwandan',
    'Saint Lucian',
    'Salvadoran',
    'Samoan',
    'San Marinese',
    'Sao Tomean',
    'Saudi',
    'Scottish',
    'Senegalese',
    'Serbian',
    'Seychellois',
    'Sierra Leonean',
    'Singaporean',
    'Slovakian',
    'Slovenian',
    'Solomon Islander',
    'Somali',
    'South African',
    'South Korean',
    'Spanish',
    'Sri Lankan',
    'Sudanese',
    'Surinamer',
    'Swazi',
    'Swedish',
    'Swiss',
    'Syrian',
    'Taiwanese',
    'Tajik',
    'Tanzanian',
    'Thai',
    'Togolese',
    'Tongan',
    'Trinidadian or Tobagonian',
    'Tunisian',
    'Turkish',
    'Tuvaluan',
    'Ugandan',
    'Ukrainian',
    'Uruguayan',
    'Uzbekistani',
    'Venezuelan',
    'Vietnamese',
    'Welsh',
    'Yemenite',
    'Zambian',
    'Zimbabwean',
  ];

  bool get isFormValid =>
      selectedGender != null &&
      selectedAge != null &&
      selectedNationality != null &&
      !_isSubmitting;

  Future<void> _submitForm() async {
    if (!isFormValid) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Determine the winning character
      String winningCharacter = widget.characterScores.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;

      // Submit data to Firebase
      await _firebaseService.submitQuizData(
        gender: selectedGender!,
        age: selectedAge!,
        nationality: selectedNationality!,
        characterResult: winningCharacter,
        characterScores: widget.characterScores,
      );

      if (mounted) {
        // Navigate to loading screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(
            characterScores: widget.characterScores,
            userAge: selectedAge!,
            userInterest: selectedGender!,
          ),
        ),
      );
      }
    } catch (e) {
      print('Error submitting form: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit data: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBF5),
            border: Border.all(color: const Color(0xFFEB8C1A), width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            hint: Text(
              hint,
              style: const TextStyle(color: Color(0xFFEB8C1A), fontSize: 14),
            ),
            underline: const SizedBox(),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFFEB8C1A),
              size: 18,
            ),
            dropdownColor: const Color(0xFFFFFBF5),
            menuMaxHeight: 300,
            borderRadius: BorderRadius.circular(20),
            style: const TextStyle(
              color: Color(0xFFEB8C1A),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            itemHeight: 56,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(item),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background_Red.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.almostThere,
                    style: GoogleFonts.courgette(
                      fontSize: 36,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.tellUsAboutYou,
                    style: GoogleFonts.courgette(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  _buildDropdown(
                    label: AppLocalizations.gender,
                    hint: AppLocalizations.selectGender,
                    value: selectedGender,
                    items: genders,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  const SizedBox(height: 14),
                  _buildDropdown(
                    label: AppLocalizations.age,
                    hint: AppLocalizations.selectYourAge,
                    value: selectedAge,
                    items: ageGroups,
                    onChanged: (value) {
                      setState(() {
                        selectedAge = value;
                      });
                    },
                  ),
                  const SizedBox(height: 14),
                  _buildDropdown(
                    label: AppLocalizations.nationality,
                    hint: AppLocalizations.selectNationality,
                    value: selectedNationality,
                    items: nationalities,
                    onChanged: (value) {
                      setState(() {
                        selectedNationality = value;
                      });
                    },
                  ),
                  // const Spacer(),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isFormValid
                            ? const Color(
                                0xFFF39C21,
                              ) // Yellow border when active
                            : Colors.grey[500]!, // Grey border when inactive
                        width: 3,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: isFormValid ? _submitForm : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEB521A),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey[400],
                        disabledForegroundColor: Colors.white,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                        AppLocalizations.getMyResult,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  //const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// @dart=2.9
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finpro_max/bloc/authentication/authentication_bloc.dart';
import 'package:finpro_max/bloc/authentication/authentication_event.dart';
import 'package:finpro_max/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:finpro_max/bloc/complete_profile/complete_profile_event.dart';
import 'package:finpro_max/bloc/complete_profile/complete_profile_state.dart';
import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/custom_widgets/custom_radio.dart';
import 'package:finpro_max/custom_widgets/divider.dart';
import 'package:finpro_max/custom_widgets/modal_popup.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/text_radio_field.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:finpro_max/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

// START OF PROFILE SETUP 05 19/41 //
class CompleteProfileForm extends StatefulWidget {
  final UserRepository _userRepository;

  const CompleteProfileForm({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;
  // required as usual

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

// total 33 properties
class _CompleteProfileFormState extends State<CompleteProfileForm>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _currentJobController = TextEditingController();
  final TextEditingController _jobPositionController =
      TextEditingController(); //
  final TextEditingController _hobbyController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  String gender,
      interestedIn,
      sholat,
      sSunnah, //
      fasting,
      fSunnah, //
      pilgrimage,
      quranLevel,
      province,
      education,
      marriageStatus, //
      haveKids, //
      childPreference,
      salaryRange, //
      financials,
      personality,
      pets, //
      smoke, //
      tattoo,
      target;
  DateTime dob;
  int age;
  File photo, photoKtp, photoOtherID;
  CompleteProfileBloc _completeProfileBloc;
  DropdownList _dropdownList;
  bool blurAvatar = false;
  bool _checkValue = false;

  // check if all the field is filled 6+3+9
  bool get isFilled =>
      _nameController.text.isNotEmpty &&
      _locationController.text.isNotEmpty &&
      _nicknameController.text.isNotEmpty &&
      _currentJobController.text.isNotEmpty &&
      _jobPositionController.text.isNotEmpty &&
      _hobbyController.text.isNotEmpty &&
      _aboutController.text.isNotEmpty &&
      gender != null &&
      interestedIn != null &&
      sholat != null &&
      sSunnah != null &&
      fasting != null &&
      fSunnah != null &&
      pilgrimage != null &&
      quranLevel != null &&
      province != null &&
      education != null &&
      marriageStatus != null &&
      haveKids != null &&
      childPreference != null &&
      salaryRange != null &&
      financials != null &&
      personality != null &&
      pets != null &&
      smoke != null &&
      tattoo != null &&
      dob != null &&
      age != null &&
      photo != null &&
      photoKtp != null &&
      photoOtherID != null &&
      target != null &&
      blurAvatar != null &&
      _checkValue == true;

  bool isCompleteButtonEnabled(CompleteProfileState state) {
    return isFilled && !state.isSubmitting;
  }

  // 6+3+9
  _onSubmitted() {
    _completeProfileBloc.add(
      Submitted(
        name: _nameController.text,
        gender: gender,
        interestedIn: interestedIn,
        nickname: _nicknameController.text,
        currentJob: _currentJobController.text,
        jobPosition: _jobPositionController.text,
        hobby: _hobbyController.text,
        aboutMe: _aboutController.text,
        dob: dob,
        age: age,
        location: _locationController.text,
        photo: photo,
        photoKtp: photoKtp,
        photoOtherID: photoOtherID,
        sholat: sholat,
        sSunnah: sSunnah,
        fasting: fasting,
        fSunnah: fSunnah,
        pilgrimage: pilgrimage,
        quranLevel: quranLevel,
        province: province,
        education: education,
        marriageStatus: marriageStatus,
        haveKids: haveKids,
        childPreference: childPreference,
        salaryRange: salaryRange,
        financials: financials,
        personality: personality,
        pets: pets,
        smoke: smoke,
        tattoo: tattoo,
        target: target,
        blurAvatar: blurAvatar,
      ),
    );
  }

  @override
  void initState() {
    // implement initState
    _completeProfileBloc = BlocProvider.of<CompleteProfileBloc>(context);
    _dropdownList = DropdownList();
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(seconds: 0);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _nicknameController.dispose();
    _currentJobController.dispose();
    _jobPositionController.dispose();
    _hobbyController.dispose();
    _aboutController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 5;
    final double itemWidth = size.width;

    final List txtHeaders = [
      "Full Legal Name (as in KTP)",
      "Nickname",
      "Company / Organization Name",
      "Your Job Position",
      "What city do you currently live in?",
      "What is your hobby?",
    ];

    final List txtControllers = [
      _nameController,
      _nicknameController,
      _currentJobController,
      _jobPositionController,
      _locationController,
      _hobbyController,
    ];

    final List txtIcons = [
      const Icon(Icons.person_add_alt_outlined),
      const Icon(Icons.person_add_outlined),
      const Icon(Icons.work_outline_outlined),
      const Icon(Icons.work_outline_outlined),
      const Icon(Icons.location_city_outlined),
      const Icon(Icons.sports_basketball_outlined),
    ];

    final List ddValuesA = [
      sholat,
      sSunnah,
      fasting,
      fSunnah,
      pilgrimage,
      quranLevel,
    ];

    final List ddItemsA = [
      _dropdownList.sholatList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.sSunnahList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.fastingList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.fSunnahList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.pilgrimageList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.quranLevelList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
    ];

    final List ddOnChangedA = [
      (value) => setState(() => sholat = value),
      (value) => setState(() => sSunnah = value),
      (value) => setState(() => fasting = value),
      (value) => setState(() => fSunnah = value),
      (value) => setState(() => pilgrimage = value),
      (value) => setState(() => quranLevel = value),
    ];

    final List ddValuesB = [
      province,
      education,
      marriageStatus,
      haveKids,
      childPreference,
      salaryRange,
      financials,
    ];

    final List ddItemsB = [
      _dropdownList.provinceList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.eduList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.marriageStatusList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.haveKidsList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.childPrefList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.salaryRangeList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.financialsList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
    ];

    final List ddOnChangedB = [
      (value) => setState(() => province = value),
      (value) => setState(() => education = value),
      (value) => setState(() => marriageStatus = value),
      (value) => setState(() => haveKids = value),
      (value) => setState(() => childPreference = value),
      (value) => setState(() => salaryRange = value),
      (value) => setState(() => financials = value),
    ];

    final List ddValuesC = [
      personality,
      pets,
      smoke,
      tattoo,
      target,
    ];

    final List ddItemsC = [
      _dropdownList.personalityList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.petsList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.smokeList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.tattooList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.targetList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
    ];

    final List ddOnChangedC = [
      (value) => setState(() => personality = value),
      (value) => setState(() => pets = value),
      (value) => setState(() => smoke = value),
      (value) => setState(() => tattoo = value),
      (value) => setState(() => target = value),
    ];

    // comment all the presets
    final List headerPreset = [
      "Use preset A", // Jabo-Yvonne, Putin, Will Smith, Jabar-Sasha Song, Eriksen, BidenBike
      "Use preset B", // Jabo-Dasha, Waterford, Donald, Jabar-Astrid S, Erik10Hag, Haaland
      "Use preset C", // Jabo-Adele, Ronaldo, Obama, Jabar-Kendall, RaheemSterling, ZinedineZidane
      "Use preset D", // Jabo-Offred, Musk, Fred MU, Jabar-ChelseaIslan, Lewa, Zidane Iqbal
      "Use preset E", // Jabo-Kate Middleton, M Salah, De Gea, Jabar-Taylor, Mou, ChrisEvans
      "Use preset F", // Jabo-Kate Bush, Neymar, Maguire, Jabar-Britney, Fabrizio, Son HeungMin
      "Use preset G", // Jabo-Lana, Jesus, Volodymyr, Jabar-Selena Gomez, ChrisMartin, AlanWalker
      "Use preset H", // Jabo-Olivia, Mbappe, BoJo, Jabar-Dua Lipa, HarryStyles, Pogba
    ];

    final List onPressedPreset = [
      () => presetA(),
      () => presetB(),
      () => presetC(),
      () => presetD(),
      () => presetE(),
      () => presetF(),
      () => presetG(),
      () => presetH(),
    ];

    return BlocListener<CompleteProfileBloc, CompleteProfileState>(
      listener: (context, state) {
        if (state.isFailure) {
          debugPrint("Complete Profile Failed");
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackbar(
              text: "Failed to complete profile. (404)",
              duration: 3,
              background: primary2,
            ),
          );
        }
        if (state.isSubmitting) {
          debugPrint("Completing Profile");
          ScaffoldMessenger.of(context).showSnackBar(
            myLoadingSnackbar(
              text: "Completing profile...",
              duration: 40,
              background: primaryBlack,
            ),
          );
        }
        if (state.isSuccess) {
          debugPrint("Success!");
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackbar(
              text: "Profile has been completed!",
              duration: 3,
              background: primaryBlack,
            ),
          );
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<CompleteProfileBloc, CompleteProfileState>(
        builder: (context, state) {
          return DefaultTabController(
            initialIndex: 0,
            animationDuration: Duration.zero,
            length: 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primary1, appBarColor],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          // tab 1
                          SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Step 1 with presets
                                  GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: itemWidth / itemHeight,
                                    ),
                                    itemCount: headerPreset.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: BigWideButton(
                                          labelText: headerPreset[
                                              index], // Most Perfect
                                          onPressedTo: onPressedPreset[index],
                                          textColor: pureWhite,
                                          btnColor: primary5,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  // Step 1 without presets
                                  const CompleteStepHeader(
                                    stepNumber: 1,
                                    header: "Complete your basic details",
                                    description:
                                        "Please use your real personal information to make sure that you'll get your match.",
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: txtHeaders.length,
                                    itemBuilder: (context, index) {
                                      return LoginTextFieldWidget(
                                        text: txtHeaders[index],
                                        controller: txtControllers[index],
                                        color: pureWhite,
                                        obscureText: false,
                                        prefixIcon: txtIcons[index],
                                        textInputType: TextInputType.name,
                                        textAction: TextInputAction.next,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        maxLines: 1,
                                      );
                                    },
                                  ),
                                  LoginTextFieldWidget(
                                    text:
                                        "Describe a bit about yourself, so the others can know you better.",
                                    color: pureWhite,
                                    obscureText: false,
                                    textInputType: TextInputType.multiline,
                                    textAction: TextInputAction.newline,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controller: _aboutController,
                                    maxLines: null,
                                    maxLength: 180,
                                    prefixIcon:
                                        const Icon(Icons.notes_outlined),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          HeaderFourText(
                                            text: "Specify your date of birth:",
                                            color: pureWhite,
                                          ),
                                          // display age from dob
                                          DescText(
                                            text: dob != null
                                                ? "${dob.day}/${dob.month}/${dob.year} (" +
                                                    age.toString() +
                                                    " years old)"
                                                : "Click the calendar icon.",
                                            color: pureWhite,
                                            align: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          DatePicker.showDatePicker(context,
                                              locale: LocaleType.id,
                                              showTitleActions: true,
                                              minTime: DateTime(1940, 1, 1),
                                              // must be atleast 18 yo
                                              maxTime: DateTime(
                                                  DateTime.now().year - 18,
                                                  1,
                                                  1), onConfirm: (date) {
                                            setState(() {
                                              dob = date;
                                              // set age from dob
                                              age = (DateTime.now().year -
                                                  dob.year);
                                            });
                                          });
                                        },
                                        child: Icon(
                                          Icons.calendar_month_outlined,
                                          size: 30,
                                          color: pureWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  HeaderFourText(
                                    text: "Choose your gender:",
                                    color: pureWhite,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        flex: 7,
                                        child: CustomRadio(
                                          text: "Male (M)",
                                          color: secondBlack,
                                          radioColor: gender == "gentleman"
                                              ? gold
                                              : pureWhite,
                                          onRadioTap: () {
                                            setState(() {
                                              gender = "gentleman";
                                              interestedIn = "lady";
                                            });
                                          },
                                        ),
                                      ),
                                      Flexible(
                                          flex: 1,
                                          child: SizedBox(
                                              width: size.width * 0.01)),
                                      Flexible(
                                        flex: 7,
                                        child: CustomRadio(
                                          text: "Female (F)",
                                          color: secondBlack,
                                          radioColor: gender == "lady"
                                              ? gold
                                              : pureWhite,
                                          onRadioTap: () {
                                            setState(() {
                                              gender = "lady";
                                              interestedIn = "gentleman";
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CompleteStepHeader(
                                    stepNumber: 2,
                                    header: "Fill in your details on religion",
                                    description:
                                        "Please use your real personal information to make sure that you'll get your match.",
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: _dropdownList.ddHeadersA.length,
                                    itemBuilder: (context, index) {
                                      return dropdownField(
                                          _dropdownList.ddHeadersA[index],
                                          _dropdownList.ddIconsA[index],
                                          _dropdownList.ddHintsA[index],
                                          ddValuesA[index],
                                          ddItemsA[index],
                                          ddOnChangedA[index],
                                          pureWhite);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Tab 3
                          SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Step 3
                                  const CompleteStepHeader(
                                    stepNumber: 3,
                                    header: "Fill in your additional details",
                                    description:
                                        "Please use your real personal information to make sure that you'll get your match.",
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: _dropdownList.ddHeadersB.length,
                                    itemBuilder: (context, index) {
                                      return dropdownField(
                                        _dropdownList.ddHeadersB[index],
                                        _dropdownList.ddIconsB[index],
                                        _dropdownList.ddHintsB[index],
                                        ddValuesB[index],
                                        ddItemsB[index],
                                        ddOnChangedB[index],
                                        pureWhite,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Tab 4
                          SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Step 4
                                  const CompleteStepHeader(
                                    stepNumber: 4,
                                    header: "Almost there...",
                                    description:
                                        "We would like to know you better while using this app.",
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: _dropdownList.ddHeadersC.length,
                                    itemBuilder: (context, index) {
                                      return dropdownField(
                                        _dropdownList.ddHeadersC[index],
                                        _dropdownList.ddIconsC[index],
                                        _dropdownList.ddHintsC[index],
                                        ddValuesC[index],
                                        ddItemsC[index],
                                        ddOnChangedC[index],
                                        pureWhite,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Tab 5
                          SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Step 5
                                  const CompleteStepHeader(
                                    stepNumber: 5,
                                    header: "Let's verify yourself!",
                                    description:
                                        "This makes sure that the one who is signing up is a real person.",
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // KTP Container
                                      GestureDetector(
                                        child: Container(
                                          width: size.width,
                                          height: size.width * 0.6,
                                          decoration: BoxDecoration(
                                            color: pureWhite,
                                            borderRadius: BorderRadius.circular(
                                                size.width * 0.03),
                                          ),
                                          child: photoKtp == null
                                              ? const UploadPlaceholder(
                                                  iconData: Icons
                                                      .credit_card_outlined,
                                                  text: "Capture KTP",
                                                )
                                              : Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    Container(
                                                      width: size.width,
                                                      height: size.width * 0.6,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: FileImage(
                                                              photoKtp),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    size.width *
                                                                        0.03),
                                                      ),
                                                    ),
                                                    MiniPill(
                                                        size: size,
                                                        text: "KTP"),
                                                  ],
                                                ),
                                        ),
                                        onTap: () async {
                                          PickedFile getKtp =
                                              await ImagePicker().getImage(
                                            source: ImageSource.camera,
                                            maxWidth: 1800,
                                            maxHeight: 1800,
                                          );
                                          if (getKtp != null) {
                                            setState(() =>
                                                photoKtp = File(getKtp.path));
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      // Other Docs
                                      GestureDetector(
                                        child: Container(
                                          width: size.width,
                                          height: size.width * 0.6,
                                          decoration: BoxDecoration(
                                            color: pureWhite,
                                            borderRadius: BorderRadius.circular(
                                                size.width * 0.03),
                                          ),
                                          child: photoOtherID == null
                                              ? const UploadPlaceholder(
                                                  iconData: Icons
                                                      .upload_file_outlined,
                                                  text:
                                                      "Capture a Supporting Document",
                                                )
                                              : Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    Container(
                                                      width: size.width,
                                                      height: size.width * 0.6,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: FileImage(
                                                              photoOtherID),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    size.width *
                                                                        0.03),
                                                      ),
                                                    ),
                                                    MiniPill(
                                                        size: size,
                                                        text: "Document"),
                                                  ],
                                                ),
                                        ),
                                        onTap: () async {
                                          PickedFile getOtherID =
                                              await ImagePicker().getImage(
                                            source: ImageSource.camera,
                                            maxWidth: 1800,
                                            maxHeight: 1800,
                                          );
                                          if (getOtherID != null) {
                                            setState(() => photoOtherID =
                                                File(getOtherID.path));
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              width: size.width * 0.43,
                                              height: size.width * 0.43,
                                              decoration: BoxDecoration(
                                                color: pureWhite,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.width * 0.03),
                                              ),
                                              child: photo == null
                                                  ? const UploadPlaceholder(
                                                      iconData: Icons
                                                          .account_circle_outlined,
                                                      text: "Upload Avatar",
                                                    )
                                                  : Stack(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.width * 0.43,
                                                          height:
                                                              size.width * 0.43,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: FileImage(
                                                                  photo),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    size.width *
                                                                        0.03),
                                                          ),
                                                        ),
                                                        MiniPill(
                                                            size: size,
                                                            text: "Avatar"),
                                                      ],
                                                    ),
                                            ),
                                            onTap: () async {
                                              try {
                                                // File getAvatar =
                                                //     await FilePicker(
                                                //         type: FileType.image);
                                                // if (getAvatar != null) {
                                                //   setState(() {
                                                //     photo = getAvatar;
                                                //   });
                                                // }
                                                FilePickerResult getAvatar =
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                            type:
                                                                FileType.image);
                                                if (getAvatar != null) {
                                                  File file = File(getAvatar
                                                      .files.single.path);
                                                  setState(() {
                                                    photo = file;
                                                  });
                                                }
                                              } catch (e) {
                                                showModalBottomSheet(
                                                  transitionAnimationController:
                                                      _animationController,
                                                  context: context,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  builder: (context) {
                                                    return ModalPopupOneButton(
                                                      size: size,
                                                      title:
                                                          "Storage Permission Denied",
                                                      image:
                                                          "assets/images/404.png",
                                                      description:
                                                          "To upload pictures and documents, please enable permission to read external storage.",
                                                      onPressed: () =>
                                                          AppSettings
                                                              .openAppSettings(),
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                          Container(
                                            width: size.width * 0.43,
                                            height: size.width * 0.43,
                                            decoration: BoxDecoration(
                                              color: pureWhite,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size.width * 0.03),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const UploadPlaceholder(
                                                  iconData: Icons
                                                      .blur_circular_outlined,
                                                  text: "Blur avatar?",
                                                ),
                                                Switch(
                                                    value: blurAvatar,
                                                    onChanged: (value) {
                                                      setState(() =>
                                                          blurAvatar = value);
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  PaddingDivider(color: pureWhite),
                                  CheckboxListTile(
                                    title: HeaderFourText(
                                        text: "Confirmation", color: pureWhite),
                                    subtitle: SmallText(
                                      text:
                                          "By proceeding, you agree to let MusliMatch save your personal data according to the current law.",
                                      color: pureWhite,
                                    ),
                                    secondary: Icon(Icons.save_outlined,
                                        color: pureWhite),
                                    activeColor: pureWhite,
                                    checkColor: primary1,
                                    value: _checkValue,
                                    onChanged: (bool value) {
                                      setState(() => _checkValue = value);
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      PaddingDivider(color: pureWhite),
                                      BigWideButton(
                                        labelText: "Complete Profile",
                                        onPressedTo:
                                            isCompleteButtonEnabled(state)
                                                ? _onSubmitted
                                                : null,
                                        textColor:
                                            isCompleteButtonEnabled(state)
                                                ? secondBlack
                                                : pureWhite,
                                        btnColor: isCompleteButtonEnabled(state)
                                            ? Colors.amber
                                            : Colors.black54,
                                      ),
                                      const SizedBox(height: 10),
                                      logOutButton(size, context),
                                      const SizedBox(height: 25),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: primary1,
                      child: TabBar(
                        indicatorColor: gold,
                        labelColor: gold,
                        unselectedLabelColor: pureWhite,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: const EdgeInsets.all(5.0),
                        tabs: const [
                          Tab(text: "Step 1"),
                          Tab(text: "Step 2"),
                          Tab(text: "Step 3"),
                          Tab(text: "Step 4"),
                          Tab(text: "Step 5"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void presetH() {
    return setState(() {
      _currentJobController.text = "Company H";
      _jobPositionController.text = "Job Position H";
      _hobbyController.text = "Hobby H";
      _aboutController.text = _dropdownList.lipsum;
      sholat = _dropdownList.sholatList[4];
      sSunnah = _dropdownList.sSunnahList[2];
      fasting = _dropdownList.fastingList[2];
      fSunnah = _dropdownList.fSunnahList[2];
      pilgrimage = _dropdownList.pilgrimageList[5];
      quranLevel = _dropdownList.quranLevelList[0];
      province = _dropdownList.provinceList[1];
      education = _dropdownList.eduList[3];
      marriageStatus = _dropdownList.marriageStatusList[3];
      haveKids = _dropdownList.haveKidsList[1];
      childPreference = _dropdownList.childPrefList[2];
      salaryRange = _dropdownList.salaryRangeList[3];
      financials = _dropdownList.financialsList[1];
      personality = _dropdownList.personalityList[0];
      pets = _dropdownList.petsList[4];
      smoke = _dropdownList.smokeList[2];
      tattoo = _dropdownList.tattooList[1];
      target = _dropdownList.targetList[0];
    });
  }

  void presetG() {
    return setState(() {
      _currentJobController.text = "Company G";
      _jobPositionController.text = "Job Position G";
      _hobbyController.text = "Hobby G";
      _aboutController.text = _dropdownList.lipsum;
      sholat = _dropdownList.sholatList[1];
      sSunnah = _dropdownList.sSunnahList[1];
      fasting = _dropdownList.fastingList[0];
      fSunnah = _dropdownList.fSunnahList[2];
      pilgrimage = _dropdownList.pilgrimageList[1];
      quranLevel = _dropdownList.quranLevelList[3];
      province = _dropdownList.provinceList[1];
      education = _dropdownList.eduList[4];
      marriageStatus = _dropdownList.marriageStatusList[3];
      haveKids = _dropdownList.haveKidsList[1];
      childPreference = _dropdownList.childPrefList[0];
      salaryRange = _dropdownList.salaryRangeList[4];
      financials = _dropdownList.financialsList[2];
      personality = _dropdownList.personalityList[2];
      pets = _dropdownList.petsList[0];
      smoke = _dropdownList.smokeList[2];
      tattoo = _dropdownList.tattooList[1];
      target = _dropdownList.targetList[1];
    });
  }

  void presetF() {
    return setState(() {
      _currentJobController.text = "Company F";
      _jobPositionController.text = "Job Position F";
      _hobbyController.text = "Hobby F";
      _aboutController.text = _dropdownList.lipsum;
      sholat = _dropdownList.sholatList[2];
      sSunnah = _dropdownList.sSunnahList[1];
      fasting = _dropdownList.fastingList[1];
      fSunnah = _dropdownList.fSunnahList[1];
      pilgrimage = _dropdownList.pilgrimageList[3];
      quranLevel = _dropdownList.quranLevelList[1];
      province = _dropdownList.provinceList[1];
      education = _dropdownList.eduList[5];
      marriageStatus = _dropdownList.marriageStatusList[3];
      haveKids = _dropdownList.haveKidsList[0];
      childPreference = _dropdownList.childPrefList[1];
      salaryRange = _dropdownList.salaryRangeList[5];
      financials = _dropdownList.financialsList[0];
      personality = _dropdownList.personalityList[0];
      pets = _dropdownList.petsList[1];
      smoke = _dropdownList.smokeList[2];
      tattoo = _dropdownList.tattooList[1];
      target = _dropdownList.targetList[1];
    });
  }

  void presetE() {
    return setState(() {
      _currentJobController.text = "Company E";
      _jobPositionController.text = "Job Position E";
      _hobbyController.text = "Hobby E";
      _aboutController.text = _dropdownList.lipsum;
      sholat = _dropdownList.sholatList[3];
      sSunnah = _dropdownList.sSunnahList[2];
      fasting = _dropdownList.fastingList[1];
      fSunnah = _dropdownList.fSunnahList[2];
      pilgrimage = _dropdownList.pilgrimageList[4];
      quranLevel = _dropdownList.quranLevelList[0];
      province = _dropdownList.provinceList[1];
      education = _dropdownList.eduList[4];
      marriageStatus = _dropdownList.marriageStatusList[0];
      haveKids = _dropdownList.haveKidsList[1];
      childPreference = _dropdownList.childPrefList[0];
      salaryRange = _dropdownList.salaryRangeList[2];
      financials = _dropdownList.financialsList[2];
      personality = _dropdownList.personalityList[2];
      pets = _dropdownList.petsList[3];
      smoke = _dropdownList.smokeList[2];
      tattoo = _dropdownList.tattooList[1];
      target = _dropdownList.targetList[1];
    });
  }

  void presetD() {
    return setState(() {
      _currentJobController.text = "Company D";
      _jobPositionController.text = "Job Position D";
      _hobbyController.text = "Hobby D";
      _aboutController.text = _dropdownList.lipsum;
      sholat = _dropdownList.sholatList[4];
      sSunnah = _dropdownList.sSunnahList[2];
      fasting = _dropdownList.fastingList[2];
      fSunnah = _dropdownList.fSunnahList[2];
      pilgrimage = _dropdownList.pilgrimageList[5];
      quranLevel = _dropdownList.quranLevelList[1];
      province = _dropdownList.provinceList[1];
      education = _dropdownList.eduList[3];
      marriageStatus = _dropdownList.marriageStatusList[0];
      haveKids = _dropdownList.haveKidsList[2];
      childPreference = _dropdownList.childPrefList[3];
      salaryRange = _dropdownList.salaryRangeList[3];
      financials = _dropdownList.financialsList[3];
      personality = _dropdownList.personalityList[1];
      pets = _dropdownList.petsList[1];
      smoke = _dropdownList.smokeList[2];
      tattoo = _dropdownList.tattooList[1];
      target = _dropdownList.targetList[0];
    });
  }

  void presetC() {
    return setState(() {
      _currentJobController.text = "Company C";
      _jobPositionController.text = "Job Position C";
      _hobbyController.text = "Hobby C";
      _aboutController.text = _dropdownList.lipsum;
      sholat = _dropdownList.sholatList[2];
      sSunnah = _dropdownList.sSunnahList[2];
      fasting = _dropdownList.fastingList[1];
      fSunnah = _dropdownList.fSunnahList[2];
      pilgrimage = _dropdownList.pilgrimageList[4];
      quranLevel = _dropdownList.quranLevelList[2];
      province = _dropdownList.provinceList[1];
      education = _dropdownList.eduList[4];
      marriageStatus = _dropdownList.marriageStatusList[0];
      haveKids = _dropdownList.haveKidsList[2];
      childPreference = _dropdownList.childPrefList[1];
      salaryRange = _dropdownList.salaryRangeList[5];
      financials = _dropdownList.financialsList[2];
      personality = _dropdownList.personalityList[1];
      pets = _dropdownList.petsList[2];
      smoke = _dropdownList.smokeList[2];
      tattoo = _dropdownList.tattooList[1];
      target = _dropdownList.targetList[1];
    });
  }

  void presetB() {
    return setState(() {
      _currentJobController.text = "Company B";
      _jobPositionController.text = "Job Position B";
      _hobbyController.text = "Hobby B";
      _aboutController.text = _dropdownList.lipsum;
      sholat = _dropdownList.sholatList[1]; // random hours
      sSunnah = _dropdownList.sSunnahList[1]; // sometimes
      fasting = _dropdownList.fastingList[0]; // no skips
      fSunnah = _dropdownList.fSunnahList[1]; // sometimes
      pilgrimage = _dropdownList.pilgrimageList[3]; // umroh
      quranLevel = _dropdownList.quranLevelList[3]; // interemediate
      province = _dropdownList.provinceList[1]; // jabo
      education = _dropdownList.eduList[4]; //
      marriageStatus = _dropdownList.marriageStatusList[0];
      haveKids = _dropdownList.haveKidsList[2];
      childPreference = _dropdownList.childPrefList[0];
      salaryRange = _dropdownList.salaryRangeList[4];
      financials = _dropdownList.financialsList[1];
      personality = _dropdownList.personalityList[2];
      pets = _dropdownList.petsList[0];
      smoke = _dropdownList.smokeList[2];
      tattoo = _dropdownList.tattooList[1];
      target = _dropdownList.targetList[1];
    });
  }

  void presetA() {
    return setState(() {
      _currentJobController.text = "Company A";
      _jobPositionController.text = "Job Position A";
      _hobbyController.text = "Hobby A";
      _aboutController.text = _dropdownList.lipsum;
      sholat = _dropdownList.sholatList[0]; // punctual
      sSunnah = _dropdownList.sSunnahList[0]; // always
      fasting = _dropdownList.fastingList[0]; // no skips
      fSunnah = _dropdownList.fSunnahList[0]; // always
      pilgrimage = _dropdownList.pilgrimageList[0]; // many times
      quranLevel = _dropdownList.quranLevelList[4]; // hafidz
      province = _dropdownList.provinceList[1]; // jabo
      education = _dropdownList.eduList[5]; // s2 s3
      marriageStatus = _dropdownList.marriageStatusList[0]; // single
      haveKids = _dropdownList.haveKidsList[2]; // none
      childPreference = _dropdownList.childPrefList[3]; // nokids
      salaryRange = _dropdownList.salaryRangeList[6]; //above 50 jt
      financials = _dropdownList.financialsList[0]; //highrisk
      personality = _dropdownList.personalityList[0]; // extro
      pets = _dropdownList.petsList[0]; // cats
      smoke = _dropdownList.smokeList[2]; // no smoke
      tattoo = _dropdownList.tattooList[1]; // no tattoo
      target = _dropdownList.targetList[1]; // 3 weeks
    });
  }

  BigWideButton logOutButton(Size size, BuildContext context) {
    return BigWideButton(
      labelText: "Log Out",
      onPressedTo: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Confirmation"),
            content: const Text("Are you sure you want to log out?"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => Home(
                        userRepository: widget._userRepository,
                      ),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                    (route) => false,
                  );
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
      textColor: pureWhite,
      btnColor: primary2,
    );
  }
}

class MiniPill extends StatelessWidget {
  const MiniPill({
    Key key,
    @required this.size,
    @required this.text,
  }) : super(key: key);

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
        decoration: BoxDecoration(
          color: pureWhite,
          borderRadius: BorderRadius.circular(size.width * 0.03),
        ),
        child: MiniText(text: "Change $text", color: secondBlack),
      ),
    );
  }
}

class UploadPlaceholder extends StatelessWidget {
  final IconData iconData;
  final String text;
  const UploadPlaceholder({
    Key key,
    @required this.iconData,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData, color: secondBlack),
        const SizedBox(height: 5),
        ChatText(text: text, color: secondBlack),
      ],
    );
  }
}

class CompleteStepHeader extends StatelessWidget {
  final int stepNumber;
  final String header, description;

  const CompleteStepHeader({
    Key key,
    @required this.stepNumber,
    @required this.header,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MiniText(text: "Step $stepNumber", color: pureWhite),
        const SizedBox(height: 15),
        HeaderTwoText(text: header, color: pureWhite),
        const SizedBox(height: 6),
        ChatText(
          text: description,
          color: pureWhite,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// END OF PROFILE SETUP 05 19/41 //

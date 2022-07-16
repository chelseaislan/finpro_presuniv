// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// all the details of the user model
class User {
  // main
  String uid;
  String name; // only for this account's profile
  String gender; // no need to be shown
  String interestedIn; // no need to be shown
  String photo;
  String photoKtp;
  String photoOtherID;
  Timestamp dob;
  int age;
  String location;
  String nickname;
  String currentJob;
  String jobPosition;
  String hobby;
  String aboutMe;
  // religion
  String sholat;
  String sSunnah;
  String fasting;
  String fSunnah;
  String pilgrimage;
  String quranLevel;
  // status
  String province;
  String education;
  String marriageStatus;
  String haveKids;
  String childPreference;
  String salaryRange;
  String financials;
  // personal
  String personality;
  String pets;
  String smoke;
  String tattoo;
  String target;
  // 4 marriage checklist dates
  Timestamp marriageA; // Parents 1
  Timestamp marriageB; // Parents 2
  Timestamp marriageC; // lamaran
  Timestamp marriageD; // acara pernikahan
  // others
  String accountType;
  String taarufWith;
  int taarufChecklist;
  bool blurAvatar;
  // ratings
  String ySuggestionRating;
  int yExpRating;
  int yAppRating;
  List<dynamic> userChosen; // for search page
  List<dynamic> userSelected; // for search nickname, prev list dynamic
  List<dynamic> userMatched; // jangan list<string>
  // For search only
  String zNickname,
      zSholat,
      zSSunnah,
      zFasting,
      zFSunnah,
      zPilgrimage,
      zQuranLevel,
      zEducation,
      zMarriageStatus,
      zHaveKids,
      zChildPreference,
      zSalaryRange,
      zFinancials,
      zPersonality,
      zPets,
      zSmoke,
      zTattoo,
      zTarget;

  User({
    // 34 props - 13 main 1 uid
    this.uid,
    this.name, // only for this account's profile
    this.gender, // no need to be shown
    this.interestedIn, // no need to be shown
    this.photo,
    this.photoKtp,
    this.photoOtherID,
    this.dob,
    this.age,
    this.location,
    this.nickname,
    this.currentJob,
    this.jobPosition,
    this.hobby,
    this.aboutMe,
    // 6 religion
    this.sholat,
    this.sSunnah, //
    this.fasting,
    this.fSunnah, //
    this.pilgrimage,
    this.quranLevel,
    // 6 details
    this.province,
    this.education,
    this.marriageStatus, //
    this.haveKids, //
    this.childPreference,
    this.salaryRange, //
    this.financials,
    // 4 personal
    this.personality, //
    this.pets, //
    this.smoke, //
    this.tattoo, //
    this.target,
    // 4 marriage checklists
    this.marriageA,
    this.marriageB,
    this.marriageC,
    this.marriageD,
    // others
    this.accountType,
    this.taarufWith,
    this.taarufChecklist,
    this.blurAvatar,
    this.ySuggestionRating,
    this.yExpRating,
    this.yAppRating,
    this.userChosen,
    this.userSelected,
    this.userMatched,
    // for search only
    this.zNickname,
    this.zSholat,
    this.zSSunnah,
    this.zFasting,
    this.zFSunnah,
    this.zPilgrimage,
    this.zQuranLevel,
    this.zEducation,
    this.zMarriageStatus,
    this.zHaveKids,
    this.zChildPreference,
    this.zSalaryRange,
    this.zFinancials,
    this.zPersonality,
    this.zPets,
    this.zSmoke,
    this.zTattoo,
    this.zTarget,
  });
}

// Move the 9 lists to user model

class DropdownList {
  final String lipsum =
      "Lorem Ipsum dolor sit amet, consectetur adipiscing elit. Nolite te bastardes carborundorum, etiam hendrerit iaculis porttitor, consectetur vitae nunc. Illegitimi non carborundum.";

  final List<String> sholatList = [
    "5 times, punctual",
    "5 times, random hours",
    "Sometimes skips",
    "Mostly skips",
    "Never",
  ];

  final List<String> sSunnahList = [
    "Always do Sunnah Prayer",
    "Sometimes do Sunnah Prayer",
    "Never do Sunnah Prayer",
  ];

  final List<String> fastingList = [
    "Completed without skips",
    "Sometimes skips",
    "Never",
  ];

  final List<String> fSunnahList = [
    "Always do Sunnah Fasting",
    "Sometimes do Sunnah Fasting",
    "Never do Sunnah Fasting",
  ];

  final List<String> pilgrimageList = [
    "Hajj & Umroh, many times",
    "Hajj & Umroh, one time",
    "Hajj only",
    "Umroh only",
    "Planned to do it",
    "Never",
  ];

  final List<String> quranLevelList = [
    "Iqra 1-3",
    "Iqra 4-6",
    "Early Learner",
    "Intermediate",
    "Hafidz",
  ];

  // Part 2

  final List<String> provinceList = [
    "Banten",
    "Jabodetabek",
    "Jawa Barat",
    "Jawa Tengah",
    "DIY",
    "Jawa Timur",
  ];

  final List<String> eduList = [
    "SD",
    "SMP",
    "SMA",
    "Diploma",
    "S1",
    "S2/S3",
  ];

  final List<String> marriageStatusList = [
    //
    "Single",
    "Married with 1 partner",
    "Married with 2 or 3 partners",
    "Widowed",
  ];

  final List<String> haveKidsList = [
    //
    "Yes, more than 2",
    "Yes, 1 or 2",
    "None",
  ];

  final List<String> childPrefList = [
    "1 or 2 kids",
    "3 or 4 kids",
    "More than 4 kids",
    "0 kids",
  ];

  final List<String> salaryRangeList = [
    "Below Rp 3 mio.",
    "Rp 3-6 mio.",
    "Rp 6-10 mio.",
    "Rp 10-20 mio.",
    "Rp 20-30 mio.",
    "Rp 30-50 mio.",
    "Above Rp 50 mio.",
  ];

  final List<String> financialsList = [
    "High-risk debts",
    "Medium-risk debts",
    "Low-risk debts",
    "I'm not in debt",
  ];

  final List<String> personalityList = [
    "Extroverted",
    "Between Both",
    "Introverted",
  ];

  final List<String> petsList = [
    "Cats",
    "Birds",
    "Chickens",
    "Reptiles",
    "No Pets",
  ];

  final List<String> smokeList = [
    "Regular cigarettes",
    "Vape",
    "No Smoke",
  ];

  final List<String> tattooList = [
    "Yes",
    "No Tattoo",
  ];

  final List<String> targetList = [
    "2 weeks from now",
    "3 weeks from now",
    "1 month from now",
    "2 months from now",
  ];

  // headers & hints

  final List ddHeadersA = [
    "How punctual are you in doing prayers?",
    "Do you perform sunnah prayer?",
    "Do you completed your fasting last Ramadan?",
    "Do you perform sunnah fasting?",
    "Have you done pilgrimages?",
    "How proficient are you in reading Quran?",
  ];

  final List ddHintsA = [
    "Prayers List",
    "Sunnah Prayers List",
    "Fasting List",
    "Sunnah Fasting List",
    "Pilgrimage List",
    "Quran Reading Level",
  ];

  final List ddIconsA = [
    const Icon(Icons.star_border_outlined),
    const Icon(Icons.star_border_outlined),
    const Icon(Icons.food_bank_outlined),
    const Icon(Icons.food_bank_outlined),
    const Icon(Icons.airplane_ticket_outlined),
    const Icon(Icons.bookmark_added_outlined),
  ];

  final List ddHeadersB = [
    "Which province do you currently live in?",
    "Choose your latest education:",
    "What is your current marriage status?",
    "Do you already have kids? (Biological or adopted kids)",
    "How many kids do you want after marriage?",
    "How much is your monthly salary during your current job?",
    "Are you currently in debt?",
  ];

  final List ddHintsB = [
    "Current Province",
    "Latest Education",
    "Marriage Status",
    "Number of Kids",
    "Children Preference",
    "Salary Range",
    "Debt Status",
  ];

  final List ddIconsB = [
    const Icon(Icons.location_searching_outlined),
    const Icon(Icons.school_outlined),
    const Icon(Icons.star_border_outlined),
    const Icon(Icons.child_friendly_outlined),
    const Icon(Icons.child_friendly_outlined),
    const Icon(Icons.onetwothree_outlined),
    const Icon(Icons.credit_score_outlined),
  ];

  final List ddHeadersC = [
    "What kind of person are you?",
    "Are you into pets?",
    "Do you smoke?",
    "Do you have your body tattoed?",
    "When is the target of your future marriage?",
  ];

  final List ddHintsC = [
    "Personality Type",
    "Pets List",
    "Smoker or Not",
    "Tattoed or Not",
    "Marriage Target",
  ];

  final List ddIconsC = [
    const Icon(Icons.person_outlined),
    const Icon(Icons.pets_outlined),
    const Icon(Icons.smoking_rooms_outlined),
    const Icon(Icons.bolt_outlined),
    const Icon(Icons.punch_clock_outlined),
  ];

  final List completeHeaders = [
    "Full Legal Name",
    "Nickname",
    "Date of Birth",
    "Gender",
    "Current Company",
    "Job Position",
    "Current Location",
    "Hobby",
    "Prayer Punctuality",
    "Sunnah Prayer Status",
    "Ramadan Fasting Status",
    "Sunnah Fasting Status",
    "Pilgrimage Status",
    "Quran Proficiency",
    "Latest Education",
    "Marriage Status",
    "Number of Previous Kids",
    "Children Preference",
    "Salary Range",
    "Debt Ratio",
    "Personality Type",
    "Pets Status",
    "Smoking Status",
    "Tattoo Status",
    "Marriage Target",
  ];

  final List selectedUserHeaders = [
    "Nickname",
    "Gender",
    "Current Company",
    "Job Position",
    "Current Location",
    "Hobby",
    "Prayer Punctuality",
    "Sunnah Prayer Status",
    "Ramadan Fasting Status",
    "Sunnah Fasting Status",
    "Pilgrimage Status",
    "Quran Proficiency",
    "Latest Education",
    "Marriage Status",
    "Number of Previous Kids",
    "Children Preference",
    "Salary Range",
    "Debt Ratio",
    "Personality Type",
    "Pets Status",
    "Smoking Status",
    "Tattoo Status",
    "Marriage Target",
  ];

  final List searchHeaders = [
    "Nickname",
    "Prayer Punctuality",
    "Sunnah Prayer Status",
    "Ramadan Fasting Status",
    "Sunnah Fasting Status",
    "Pilgrimage Status",
    "Quran Proficiency",
    "Latest Education",
    "Marriage Status",
    "Number of Previous Kids",
    "Children Preference",
    "Salary Range",
    "Debt Ratio",
    "Personality Type",
    "Pets Status",
    "Smoking Status",
    "Tattoo Status",
    "Marriage Target",
  ];

  final List simpleSearchIcons = [
    Icons.person_add_outlined,
    Icons.star_border_outlined,
    Icons.star_border_outlined,
    Icons.food_bank_outlined,
    Icons.food_bank_outlined,
    Icons.airplane_ticket_outlined,
    Icons.bookmark_added_outlined,
    Icons.school_outlined,
    Icons.star_border_outlined,
    Icons.child_friendly_outlined,
    Icons.child_friendly_outlined,
    Icons.onetwothree_outlined,
    Icons.credit_score_outlined,
    Icons.person_outlined,
    Icons.pets_outlined,
    Icons.smoking_rooms_outlined,
    Icons.bolt_outlined,
    Icons.punch_clock_outlined,
  ];

  final List advSearchIcons = [
    Icons.star_border_outlined,
    Icons.star_border_outlined,
    Icons.food_bank_outlined,
    Icons.food_bank_outlined,
    Icons.airplane_ticket_outlined,
    Icons.bookmark_added_outlined,
    Icons.school_outlined,
    Icons.star_border_outlined,
    Icons.child_friendly_outlined,
    Icons.child_friendly_outlined,
    Icons.onetwothree_outlined,
    Icons.credit_score_outlined,
    Icons.person_outlined,
    Icons.pets_outlined,
    Icons.smoking_rooms_outlined,
    Icons.bolt_outlined,
    Icons.punch_clock_outlined,
  ];
}

class TaarufList {
  final List headersA = [
    "1. Visit the first parents",
    "2. Visit the second parents",
    "3. Do the Istikharah Prayer",
    "4. Conduct a Marriage Proposal (Khitbah)",
    "5. Perform the Marriage",
  ];

  final List descriptionsA = [
    "Both of you will decide which parents should be visited first and when. Let them know about the details of you and your partner. You can set the date of the visit below and your partner should too on his/her device.",
    "After visiting the first parents, please arrange the next visit to the second parents.",
    "After both parents have been visited, please do the Istikharah prayer, and let Allah give the best for both of you.",
    "Arrange the time to perform marriage proposal (Khitbah). If both of you are already firm, please do it as soon as possible.",
    "Finally, the most awaited step of it all. Don't make the wedding too lavish, just keep it simple and with humility. Praise be!",
  ];

  final List headersE = [
    "1. Make your house a home",
    "2. Don't forget to learn more about parenting.",
    "3. Keep having adventures.",
  ];

  final List descriptionsE = [
    "Create a space where the two of you actually want to spend time together, because you never want your home to feel like an office or a hotel that the two of you are just passing through.",
    "This is useful, especially if both of you are planning to have kids. Because remember, they didn't ask to be born, and they will eventually become adults, so it's both of your responsibility to raise them properly.",
    "At the end of the day, the most important thing is that your marriage is nothing like anyone else's. What works for someone else may not work for you. Take heed of the advice and counsel of the people you love and trust — then construct your own path. You're in charge of your own happily ever after.",
  ];
}

import 'package:flutter/material.dart';

class AppData {

  // INFORMATIONS PERSONNELLES

  static const fullName = 'Kakule Kayenga Ben';

  static const headline =
      'Étudiant en genie logiciele';

  static const location = 'Goma, Nord-Kivu, RDC';

  static const email = 'benjybenkay@gmail.com';

  static const phone = '+243 977 069 342 ';

  static const address =
      'Goma, République démocratique du Congo';

  static const github =
      'https://github.com/kayengabenjamin';

  static const linkedin =
      'https://www.linkedin.com/in/Ben_kay';


  // PRESENTATION

  static const about =
      "Passionné par les technologies, le développement logiciel "
      "et les réseaux informatiques, motivé et désireux "
      "de mettre mes compétences au service de probleme necessaire.";


  // FORMATION

  static const education = [

    EducationItem(
      period: 'En cours',
      title: 'Sciences informatiques',
      subtitle: 'Genie Logiciele',
      detail: 'Établissement à compléter',
    ),

  ];


  // EXPERIENCES

  static const experiences = [

    ExperienceItem(
      period: '2025-2026',
      title: 'Stage professionnel',
      organization: 'Speed it service ',
      detail:
          'Grace à ce stage j_ai eu des comptences à reseau,deploiement et télécommunication ',
    ),

    ExperienceItem(
      period: 'Octobre  2024- janvier 2025',
      title: 'informatique bureautique',
      organization: 'centre de formation himbi',
      detail:
          'Genieautopsie.page.gd, dbgoma.page.gd, chopeka.com, akothacorp.page.gd',
    ),

  ];


  // COMPETENCES TECHNIQUES

  static const technicalSkills = [

    'Flutter / Dart',
    'HTML / CSS / JavaScript',
    'Python',
    'Réseaux informatiques',
    'Microsoft Word, Excel et PowerPoint',
    'Git et GitHub',

  ];


  // LANGUES

  static const languages = [

    'Français',
    'Swahili',
    'Anglais',

  ];


  // CENTRES D'INTERET

  static const interests = [

    'Développement logiciel',
    'Intelligence artificielle',
    'Réseaux et cybersécurité',
    'Innovation technologique',

  ];


  // FAMILLE

  static const family = [

    FamilyMember(
      name: 'kayenga Roger',
      relationship: 'Père',
      profession: 'Commercant',
      initials: 'P',
      color: Color(0xFF2563EB),
      image : 'assets/images/papa.jpg'
    ),

    FamilyMember(
      name: 'Foibe Masika',
      relationship: 'Mère',
      profession: 'Profession à compléter',
      initials: 'M',
      color: Color(0xFFDB2777),
      image : 'assets/images/maman.jpg'
    ),

    FamilyMember(
      name: 'Keren',
      relationship: 'Sœur',
      profession: 'Etudiante',
      initials: 'F',
      color: Color(0xFF059669),
      image : 'assets/images/soeur.jpg'
    ),

  ];

}


// CLASSE FORMATION

class EducationItem {

  final String period;
  final String title;
  final String subtitle;
  final String detail;

  const EducationItem({
    required this.period,
    required this.title,
    required this.subtitle,
    required this.detail,
  });

}


// CLASSE EXPERIENCE

class ExperienceItem {

  final String period;
  final String title;
  final String organization;
  final String detail;

  const ExperienceItem({
    required this.period,
    required this.title,
    required this.organization,
    required this.detail,
  });

}


// CLASSE MEMBRE DE FAMILLE

class FamilyMember {

  final String name;
  final String relationship;
  final String profession;
  final String initials;
  final String image;
  final Color color;

  const FamilyMember({
    required this.name,
    required this.relationship,
    required this.profession,
    required this.initials,
    required this.image,
    required this.color,
  });

}

///////////////////////////////////////////////////////////////////////////////////////////////////
class ApiFamilyMember {
  final int id;
  final String nom;
  final String postnom;
  final String prenom;
  final String lieuNaissance;
  final String dateNaissance;
  final String parente;
  final String? imageUrl;

  const ApiFamilyMember({
    required this.id,
    required this.nom,
    required this.postnom,
    required this.prenom,
    required this.lieuNaissance,
    required this.dateNaissance,
    required this.parente,
    this.imageUrl,
  });

  String get fullName => '$prenom $postnom $nom'.trim();

  factory ApiFamilyMember.fromJson(Map<String, dynamic> json) {
    return ApiFamilyMember(
      id: int.tryParse(json['id'].toString()) ?? 0,
      nom: json['nom']?.toString() ?? '',
      postnom: json['postnom']?.toString() ?? '',
      prenom: json['prenom']?.toString() ?? '',
      lieuNaissance: json['lieu_naissance']?.toString() ?? '',
      dateNaissance: json['date_naissance']?.toString() ?? '',
      parente: json['parente']?.toString() ?? '',
      imageUrl: json['image_url']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'postnom': postnom,
      'prenom': prenom,
      'lieu_naissance': lieuNaissance,
      'date_naissance': dateNaissance,
      'parente': parente,
    };
  }
}
//////////////////////////////////////////////////////////////////////////////////////////

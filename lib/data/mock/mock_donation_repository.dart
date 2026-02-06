import 'package:hersbruck_together/data/models/donation_project.dart';

class MockDonationRepository {
  static const List<DonationProject> projects = [
    DonationProject(
      id: 'jugend-sport',
      title: 'Jugend & Sport',
      description:
          'Sportausrüstung und Trainingsmöglichkeiten für Kinder und Jugendliche in Hersbruck.',
      currentAmount: 7250,
      goalAmount: 10000,
    ),
    DonationProject(
      id: 'kultur-stadtleben',
      title: 'Kultur & Stadtleben',
      description:
          'Kulturelle Veranstaltungen, Stadtfeste und Kunstprojekte zur Belebung der Innenstadt.',
      currentAmount: 12800,
      goalAmount: 15000,
    ),
    DonationProject(
      id: 'soziales-hilfe',
      title: 'Soziales & Hilfe',
      description:
          'Unterstützung für Bedürftige, Seniorenhilfe und soziale Projekte in der Gemeinde.',
      currentAmount: 4500,
      goalAmount: 8000,
    ),
    DonationProject(
      id: 'umwelt-natur',
      title: 'Umwelt & Natur',
      description:
          'Baumpflanzungen, Naturschutzprojekte und nachhaltige Initiativen für unsere Region.',
      currentAmount: 3200,
      goalAmount: 6000,
    ),
  ];

  List<DonationProject> getProjects() => projects;
}

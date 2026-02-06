class DonationProject {
  final String id;
  final String title;
  final String description;
  final double currentAmount;
  final double goalAmount;

  const DonationProject({
    required this.id,
    required this.title,
    required this.description,
    required this.currentAmount,
    required this.goalAmount,
  });

  double get progress => (currentAmount / goalAmount).clamp(0.0, 1.0);
}

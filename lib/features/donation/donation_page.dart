import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/data/mock/mock_donation_repository.dart';
import 'package:hersbruck_together/data/models/donation_project.dart';
import 'package:hersbruck_together/features/donation/widgets/amount_selector.dart';
import 'package:hersbruck_together/features/donation/widgets/donor_options_section.dart';
import 'package:hersbruck_together/features/donation/widgets/project_card.dart';
import 'package:hersbruck_together/features/donation/widgets/summary_card.dart';
import 'package:hersbruck_together/ui/widgets/elegant_background.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final _donationRepo = MockDonationRepository();
  late final TextEditingController _customAmountController;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  int? _selectedPresetAmount;
  String _customAmount = '';
  DonationProject? _selectedProject;
  bool _isAnonymous = false;
  bool _isMonthly = false;

  @override
  void initState() {
    super.initState();
    _customAmountController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _customAmountController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  int get _effectiveAmount {
    if (_selectedPresetAmount != null) {
      return _selectedPresetAmount!;
    }
    final parsed = int.tryParse(_customAmount);
    return parsed ?? 0;
  }

  String? get _amountError {
    if (_selectedPresetAmount != null) return null;
    if (_customAmount.isEmpty) return null;

    final parsed = int.tryParse(_customAmount);
    if (parsed == null) return 'Bitte eine gültige Zahl eingeben';
    if (parsed < 1) return 'Mindestbetrag: 1 €';
    if (parsed > 500) return 'Maximalbetrag: 500 €';
    return null;
  }

  bool get _isFormValid {
    if (_effectiveAmount < 1 || _effectiveAmount > 500) return false;
    if (_selectedProject == null) return false;
    if (_amountError != null) return false;
    return true;
  }

  void _showConfirmationSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildConfirmationSheet(),
    );
  }

  void _showProjectsInfo() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const _ProjectInfoPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final projects = _donationRepo.getProjects();

    return ElegantBackground(
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                      child: _buildHeader(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                      child: AmountSelector(
                        selectedPresetAmount: _selectedPresetAmount,
                        customAmount: _customAmount,
                        customAmountController: _customAmountController,
                        onPresetSelected: (amount) {
                          setState(() {
                            _selectedPresetAmount = amount;
                            if (amount != null) {
                              _customAmount = '';
                              _customAmountController.clear();
                            }
                          });
                        },
                        onCustomAmountChanged: (value) {
                          setState(() {
                            _customAmount = value;
                            _selectedPresetAmount = null;
                          });
                        },
                        errorText: _amountError,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                      child: _buildProjectsSection(projects),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                      child: DonorOptionsSection(
                        isAnonymous: _isAnonymous,
                        isMonthly: _isMonthly,
                        nameController: _nameController,
                        emailController: _emailController,
                        onAnonymousChanged: (value) {
                          setState(() => _isAnonymous = value);
                        },
                        onMonthlyChanged: (value) {
                          setState(() => _isMonthly = value);
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                      child: SummaryCard(
                        amount: _effectiveAmount,
                        projectTitle: _selectedProject?.title ?? '',
                        isMonthly: _isMonthly,
                        isValid: _isFormValid,
                        onDonate: _showConfirmationSheet,
                        onLearnMore: _showProjectsInfo,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: _buildPartnerSection(),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 120),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Spenden',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Unterstütze Projekte in Hersbruck',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: goldAccent.withValues(alpha: 0.1),
            border: Border.all(
              color: goldAccent.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified_outlined,
                size: 16,
                color: goldAccent.withValues(alpha: 0.8),
              ),
              const SizedBox(width: 8),
              Text(
                '100% für den guten Zweck (abzgl. Zahlungsgebühren)',
                style: TextStyle(
                  fontSize: 12,
                  color: goldAccent.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsSection(List<DonationProject> projects) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projekt auswählen',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 12),
        ...projects.map((project) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ProjectCard(
                project: project,
                isSelected: _selectedProject?.id == project.id,
                onTap: () {
                  setState(() => _selectedProject = project);
                },
              ),
            )),
      ],
    );
  }

  Widget _buildPartnerSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withValues(alpha: 0.03),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: goldAccent.withValues(alpha: 0.15),
            ),
            child: Icon(
              Icons.handshake_outlined,
              size: 20,
              color: goldAccent.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Partner: Rotary Club Hersbruck',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Gemeinsam für die Region',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            child: Text(
              'Mehr erfahren',
              style: TextStyle(
                fontSize: 12,
                color: goldAccent.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationSheet() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1e),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(
            color: goldAccent.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: goldAccent.withValues(alpha: 0.15),
              border: Border.all(
                color: goldAccent.withValues(alpha: 0.4),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.favorite,
              size: 32,
              color: goldAccent,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Vielen Dank!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Deine Spende von $_effectiveAmount € für "${_selectedProject?.title}" wurde erfolgreich übermittelt.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '(Dies ist eine Demo – keine echte Zahlung)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: goldAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Schließen',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectInfoPage extends StatelessWidget {
  const _ProjectInfoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElegantBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Über unsere Projekte',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      _buildInfoSection(
                        'Unsere Mission',
                        'Hersbruck Together bringt Menschen zusammen, um unsere Gemeinschaft zu stärken. Jede Spende fließt direkt in lokale Projekte, die das Leben in Hersbruck bereichern.',
                      ),
                      const SizedBox(height: 24),
                      _buildInfoSection(
                        'Transparenz',
                        'Wir veröffentlichen regelmäßig Berichte über die Verwendung der Spendengelder. So können Sie nachvollziehen, wie Ihre Unterstützung wirkt.',
                      ),
                      const SizedBox(height: 24),
                      _buildInfoSection(
                        'Mitmachen',
                        'Neben finanzieller Unterstützung freuen wir uns auch über ehrenamtliches Engagement. Kontaktieren Sie uns, wenn Sie aktiv werden möchten!',
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: Text(
                          'Demo-Seite – Platzhalter-Inhalt',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: goldAccent.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

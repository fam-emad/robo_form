import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../services/form_status_service.dart';
import '../services/sheets_service.dart';
import '../widgets/widgets.dart';
import 'closed_screen.dart';
import 'refactor/registration/field_keys.dart';
import 'refactor/registration/registration_form.dart';
import 'success_screen.dart';

// ────────────────────────────────────────────────────────────────
// حالات الفورم
// ────────────────────────────────────────────────────────────────
enum _FormStatus { loading, open, closed }

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  // ── حالة الفورم ────────────────────────────────────────────────
  _FormStatus _status = _FormStatus.loading;

  // ── انيميشن الـ loading skeleton ────────────────────────────────
  late final AnimationController _shimmer;

  // ── بيانات الفورم ───────────────────────────────────────────────
  final _formKey = GlobalKey<FormState>();

  final FieldKeys _keys = {
    for (final k in [
      'arName', 'enName', 'nid', 'seat', 'address',
      'phone', 'email', 'discord', 'linkedin',
    ])
      k: GlobalKey<FormFieldState<String>>(),
  };

  final _enName = TextEditingController();
  final _email = TextEditingController();

  String _level = 'Level 1';
  String _dept = 'CS';
  bool _isStudent = true;
  bool _agree = false;
  bool _attempted = false;
  bool _submitting = false;
  final Set<String> _selected = {};

  // ────────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final result = await FormStatusService.check();
    if (!mounted) return;
    setState(() {
      _status = result == FormStatus.closed
          ? _FormStatus.closed
          : _FormStatus.open;
    });
    if (_status != _FormStatus.loading) _shimmer.stop();
  }

  @override
  void dispose() {
    _shimmer.dispose();
    _enName.dispose();
    _email.dispose();
    super.dispose();
  }

  // ────────────────────────────────────────────────────────────────
  // Form helpers
  // ────────────────────────────────────────────────────────────────
  int get _errorCount {
    var n = _keys.values.where((k) => k.currentState?.hasError ?? false).length;
    if (_attempted && _selected.isEmpty) n++;
    if (_attempted && !_agree) n++;
    return n;
  }

  void _refresh() {
    if (_attempted) setState(() {});
  }

  void _toggleCommittee(String name) => setState(() {
        _selected.contains(name) ? _selected.remove(name) : _selected.add(name);
      });

  String _val(String k) => (_keys[k]?.currentState?.value ?? '').trim();

  Future<void> _submit() async {
    if (_submitting) return;
    setState(() => _attempted = true);
    final fieldsOk = _formKey.currentState!.validate();
    final ok = fieldsOk && _selected.isNotEmpty && _agree;
    setState(() {});

    if (!ok) {
      for (final k in _keys.values) {
        if ((k.currentState?.hasError ?? false) && k.currentContext != null) {
          Scrollable.ensureVisible(k.currentContext!,
              alignment: 0.2, duration: const Duration(milliseconds: 300));
          break;
        }
      }
      return;
    }

    final name = _enName.text.trim();
    final ref = (DateTime.now().millisecondsSinceEpoch % 100000)
        .toString()
        .padLeft(5, '0');
    final referenceId = '#RBT-2026-$ref';

    setState(() => _submitting = true);
    try {
      await SheetsService.submit({
        'referenceId': referenceId,
        'arName': _val('arName'),
        'enName': name,
        'nid': _val('nid'),
        'seat': _val('seat'),
        'level': _level,
        'isStudent': _isStudent,
        'address': _val('address'),
        'phone': _val('phone'),
        'email': _email.text.trim(),
        'dept': _dept,
        'discord': _val('discord'),
        'linkedin': _val('linkedin'),
        'committees': _selected.toList(),
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColors.red,
        content: Text(e.toString()),
      ));
      return;
    }
    if (!mounted) return;
    setState(() => _submitting = false);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => SuccessScreen(
        applicantName: name.split(RegExp(r'\s+')).first,
        fullName: name,
        committees: _selected.toList(),
        referenceId: referenceId,
      ),
    ));
  }

  // ────────────────────────────────────────────────────────────────
  // Build
  // ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return switch (_status) {
      _FormStatus.loading => _LoadingShell(shimmer: _shimmer),
      _FormStatus.closed  => const ClosedScreen(),
      _FormStatus.open    => _OpenForm(
          formKey: _formKey,
          fieldKeys: _keys,
          enNameController: _enName,
          emailController: _email,
          level: _level,
          dept: _dept,
          isStudent: _isStudent,
          agreed: _agree,
          attempted: _attempted,
          errorCount: _errorCount,
          selectedCommittees: _selected,
          submitting: _submitting,
          onFieldChanged: _refresh,
          onLevelChanged: (v) => setState(() => _level = v),
          onDeptChanged: (v) => setState(() => _dept = v),
          onStudentChanged: (v) => setState(() => _isStudent = v),
          onCommitteeToggle: _toggleCommittee,
          onAgreeChanged: (v) => setState(() => _agree = v),
          onSubmit: _submit,
        ),
    };
  }
}

// ════════════════════════════════════════════════════════════════
// Loading Shell — skeleton يشبه شكل الفورم الحقيقي
// ════════════════════════════════════════════════════════════════
class _LoadingShell extends StatelessWidget {
  final AnimationController shimmer;

  const _LoadingShell({required this.shimmer});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: PageShell(
        maxWidth: 900,
        child: AnimatedBuilder(
          animation: shimmer,
          builder: (_, _x) {
            final alpha = (0.04 + 0.06 * shimmer.value);
            return AppCard(
              padding: const EdgeInsets.all(28),
              radius: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // شريط العنوان
                  _SkeletonBar(width: 200, height: 18, alpha: alpha),
                  const Gap.v(8),
                  _SkeletonBar(width: 300, height: 12, alpha: alpha),
                  const Gap.v(32),
                  // صفوف الـ skeleton
                  for (var i = 0; i < 5; i++) ...[
                    Row(children: [
                      Expanded(child: _SkeletonBar(height: 48, alpha: alpha)),
                      const Gap.h(16),
                      Expanded(child: _SkeletonBar(height: 48, alpha: alpha)),
                    ]),
                    const Gap.v(20),
                  ],
                  const Gap.v(8),
                  // زرار
                  _SkeletonBar(height: 46, alpha: alpha),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SkeletonBar extends StatelessWidget {
  final double? width;
  final double height;
  final double alpha;

  const _SkeletonBar({this.width, required this.height, required this.alpha});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: alpha),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Open Form — نفس المحتوى الأصلي مع fade-in عند الظهور
// ════════════════════════════════════════════════════════════════
class _OpenForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final FieldKeys fieldKeys;
  final TextEditingController enNameController;
  final TextEditingController emailController;
  final String level;
  final String dept;
  final bool isStudent;
  final bool agreed;
  final bool attempted;
  final int errorCount;
  final Set<String> selectedCommittees;
  final bool submitting;
  final VoidCallback onFieldChanged;
  final ValueChanged<String> onLevelChanged;
  final ValueChanged<String> onDeptChanged;
  final ValueChanged<bool> onStudentChanged;
  final ValueChanged<String> onCommitteeToggle;
  final ValueChanged<bool> onAgreeChanged;
  final VoidCallback onSubmit;

  const _OpenForm({
    required this.formKey,
    required this.fieldKeys,
    required this.enNameController,
    required this.emailController,
    required this.level,
    required this.dept,
    required this.isStudent,
    required this.agreed,
    required this.attempted,
    required this.errorCount,
    required this.selectedCommittees,
    required this.submitting,
    required this.onFieldChanged,
    required this.onLevelChanged,
    required this.onDeptChanged,
    required this.onStudentChanged,
    required this.onCommitteeToggle,
    required this.onAgreeChanged,
    required this.onSubmit,
  });

  @override
  State<_OpenForm> createState() => _OpenFormState();
}

class _OpenFormState extends State<_OpenForm>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Stack(children: [
          PageShell(
            maxWidth: 900,
            child: RegistrationForm(
              formKey: widget.formKey,
              fieldKeys: widget.fieldKeys,
              enNameController: widget.enNameController,
              emailController: widget.emailController,
              level: widget.level,
              dept: widget.dept,
              isStudent: widget.isStudent,
              agreed: widget.agreed,
              attempted: widget.attempted,
              errorCount: widget.errorCount,
              selectedCommittees: widget.selectedCommittees,
              onFieldChanged: widget.onFieldChanged,
              onLevelChanged: widget.onLevelChanged,
              onDeptChanged: widget.onDeptChanged,
              onStudentChanged: widget.onStudentChanged,
              onCommitteeToggle: widget.onCommitteeToggle,
              onAgreeChanged: widget.onAgreeChanged,
              onSubmit: widget.onSubmit,
            ),
          ),
          if (widget.submitting)
            const Positioned.fill(
              child: ColoredBox(
                color: Color(0x99000000),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ]),
      ),
    );
  }
}

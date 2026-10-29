import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../services/sheets_service.dart';
import '../widgets/widgets.dart';
import 'refactor/registration/field_keys.dart';
import 'refactor/registration/registration_form.dart';
import 'success_screen.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // مفاتيح الحقول بالترتيب (عشان العدّ والسكرول لأول خطأ)
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

  @override
  void dispose() {
    _enName.dispose();
    _email.dispose();
    super.dispose();
  }

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
      // سكرول لأول حقل فيه خطأ
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Stack(children: [
        PageShell(
        maxWidth: 900,
        child: RegistrationForm(
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
          onFieldChanged: _refresh,
          onLevelChanged: (v) => setState(() => _level = v),
          onDeptChanged: (v) => setState(() => _dept = v),
          onStudentChanged: (v) => setState(() => _isStudent = v),
          onCommitteeToggle: _toggleCommittee,
          onAgreeChanged: (v) => setState(() => _agree = v),
          onSubmit: _submit,
        ),
      ),
        if (_submitting)
          const Positioned.fill(
            child: ColoredBox(
              color: Color(0x99000000),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ]),
    );
  }
}

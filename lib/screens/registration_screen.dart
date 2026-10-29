import 'package:flutter/material.dart';
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
      'phone', 'email', 'dept', 'discord', 'linkedin',
    ])
      k: GlobalKey<FormFieldState<String>>(),
  };

  final _enName = TextEditingController();
  final _email = TextEditingController();

  String _level = 'Level 1';
  bool _isStudent = true;
  bool _agree = false;
  bool _attempted = false;
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

  void _submit() {
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
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => SuccessScreen(
        applicantName: name.split(RegExp(r'\s+')).first,
        fullName: name,
        committees: _selected.toList(),
        referenceId: '#RBT-2026-$ref',
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return PageShell(
      maxWidth: 900,
      child: RegistrationForm(
        formKey: _formKey,
        fieldKeys: _keys,
        enNameController: _enName,
        emailController: _email,
        level: _level,
        isStudent: _isStudent,
        agreed: _agree,
        attempted: _attempted,
        errorCount: _errorCount,
        selectedCommittees: _selected,
        onFieldChanged: _refresh,
        onLevelChanged: (v) => setState(() => _level = v),
        onStudentChanged: (v) => setState(() => _isStudent = v),
        onCommitteeToggle: _toggleCommittee,
        onAgreeChanged: (v) => setState(() => _agree = v),
        onSubmit: _submit,
      ),
    );
  }
}

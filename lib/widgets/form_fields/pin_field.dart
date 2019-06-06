import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/color.dart';

typedef OnSubmit = Future<void> Function(String value);

class PinField extends StatefulWidget {
  final int fieldsCount;
  final OnSubmit onSubmit;
  final String errorMessage;
  final bool autofocus;

  PinField({
    @required this.fieldsCount,
    this.onSubmit,
    this.errorMessage = '',
    this.autofocus = false,
  }) : assert(fieldsCount > 0);

  @override
  _PinFieldState createState() => _PinFieldState();
}

class _PinFieldState extends State<PinField> {
  static const double _inputFieldWidth = 40.0;
  static const double _inputPadding = 5.0;

  List<FocusNode> _focusNodes;
  List<TextEditingController> _controllers;
  List<String> _values;

  @override
  void initState() {
    super.initState();

    _focusNodes = List.generate(widget.fieldsCount, (int i) => FocusNode());
    _controllers = List.generate(
        widget.fieldsCount, (int i) => TextEditingController(text: ''));
    _values = _defaultValues();
  }

  List<String> _defaultValues() {
    return List.generate(widget.fieldsCount, (_) => '');
  }

  @override
  void dispose() {
    _focusNodes.forEach((FocusNode f) => f.dispose());
    _controllers.forEach((TextEditingController c) => c.dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final children = <Widget>[_generateTextFields(context)];
    if (widget.errorMessage.isNotEmpty) {
      children.add(Text(
        widget.errorMessage,
        style: textTheme.body1.copyWith(color: AppColor.red),
      ));
    }
    return Container(
      width: _getContainerWidth(),
      child: Column(
        children: children,
      ),
    );
  }

  double _getContainerWidth() {
    return _inputPadding * 2 + widget.fieldsCount * _inputFieldWidth;
  }

  Widget _generateTextFields(BuildContext context) {
    final textFields = <Widget>[];
    for (var i = 0; i < widget.fieldsCount; ++i) {
      textFields.add(_buildTextField(i, context));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: textFields,
    );
  }

  Widget _buildTextField(int index, BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final border = _getBorder(index);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _inputPadding),
        child: Theme(
          data: theme.copyWith(splashColor: Colors.transparent),
          child: TextField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            style: textTheme.body1,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  left: 10, right: 10, top: 8.0, bottom: 8.0),
              enabledBorder: border,
              focusedBorder: border,
              counterText: '',
            ),
            textAlign: TextAlign.center,
            maxLength: 1,
            onTap: () => _handleTap(context),
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            onChanged: (_) => _handleChange(context),
            autofocus: widget.autofocus && index == 0,
          ),
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    if (_allFieldsAreFilled()) {
      _unFocusAll();
    } else {
      _focusOnFirstNonEmptyTextField(context);
    }
  }

  void _handleChange(BuildContext context) async {
    setState(() {
      _values = _getValues();
    });
    if (_allFieldsAreFilled()) {
      _unFocusAll();
      await _triggerOnSubmit();
      _clearAll();
    } else {
      _focusOnFirstNonEmptyTextField(context);
    }
  }

  List<String> _getValues() {
    return _controllers.map((TextEditingController c) => c.text).toList();
  }

  Future<void> _triggerOnSubmit() async {
    if (widget.onSubmit != null) {
      await widget.onSubmit(_values.join());
    }
  }

  void _clearAll() {
    _controllers.forEach((TextEditingController c) {
      c.text = '';
    });
    setState(() {
      _values = _defaultValues();
    });
  }

  bool _allFieldsAreFilled() {
    var result = true;
    _values.forEach((String v) {
      if (v.isEmpty) {
        result = false;
      }
    });
    return result;
  }

  void _focusOnFirstNonEmptyTextField(BuildContext context) {
    final firstEmpty = _values.firstWhere((String v) => v.isEmpty);
    final index = _values.indexOf(firstEmpty);
    FocusScope.of(context).requestFocus(_focusNodes[index]);
  }

  void _unFocusAll() {
    _focusNodes.forEach((fn) {
      if (fn.hasFocus) {
        fn.unfocus();
      }
    });
  }

  InputBorder _getBorder(int index) {
    var borderColor = AppColor.grey;
    if (_inputIsFilled(index)) {
      borderColor = AppColor.green;
    }
    if (widget.errorMessage.isNotEmpty) {
      borderColor = AppColor.red;
    }
    return UnderlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: BorderRadius.zero,
    );
  }

  bool _inputIsFilled(int index) {
    return _values[index].isNotEmpty;
  }
}

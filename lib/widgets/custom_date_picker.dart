import 'package:flutter/material.dart';

import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

import 'filled_button.dart';

typedef Callback = void Function(DateTime value);

class CustomDatePicker extends StatelessWidget {

  final _format = 'dd-MM-yyyy';
  final _dayCtrl = TextEditingController();
  final _monthCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();
  final Callback onChange;

  CustomDatePicker({ @required this.onChange});

  static DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            new Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Container(
                        width: 60,
                        child: TextField(
                          focusNode: DisabledFocusNode(),
                          controller: _dayCtrl,
                          key: const Key('day-of-birth'),
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            labelText: 'Day',
                            hintText: 'DD',
                            hintStyle: const TextStyle(color: Colors.white30),
                          ),
                            onTap: () {
                              _showDatePicker(context);
                            }
                        )))),
            new Flexible(
                child: Container(
                    width: 80,
                    child: TextField(
                      focusNode: DisabledFocusNode(),
                      controller: _monthCtrl,
                      key: const Key('month-of-birth'),
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: 'Month',
                        hintText: 'MM',
                        hintStyle: const TextStyle(color: Colors.black26),
                      ),
                      onTap: () {
                        _showDatePicker(context);
                      },
                    ))),
            new Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(right: 30.00),
                    child: TextField(
                      focusNode: DisabledFocusNode(),
                      controller: _yearCtrl,
                      key: const Key('year-of-birth'),
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: 'Year',
                        hintText: 'YYYY',
                        hintStyle: const TextStyle(color: Colors.black26),
                      ),
                      onTap: () {
                        _showDatePicker(context);
                      },
                    )
                )
            )
          ]
          )
      ),
      Padding(
          padding: const EdgeInsets.only(top: 160.00),
          child: FilledButton(
            'Next',
            onPressed: () {
              print('${_dayCtrl.text}-${_monthCtrl.text}-${_yearCtrl.text}');
              onChange(_dateTime);
            },
          ))
    ]);
  }
  void _showDatePicker(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      initialDateTime: DateTime.now(),
      dateFormat: _format,
      onCancel: () {
        updateState(DateTime.now());
      },
      onChange: (dateTime, List<int> index) {
        updateState(dateTime);
      },
      onConfirm: (dateTime, List<int> index) {
        updateState(dateTime);
      },
    );
  }
  void updateState(DateTime dateTime) {
    _dateTime = dateTime;
    _dayCtrl.text = _dateTime.day.toString().padLeft(2, '0');
    _monthCtrl.text = _dateTime.month.toString().padLeft(2, '0');
    _yearCtrl.text = _dateTime.year.toString();
  }
}

class DisabledFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
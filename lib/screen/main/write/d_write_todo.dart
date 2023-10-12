import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/util/app_keyboard_util.dart';
import 'package:fast_app_base/common/widget/constant_widget.dart';
import 'package:fast_app_base/common/widget/scaffold/bottom_dialog_scaffold.dart';
import 'package:fast_app_base/common/widget/w_round_button.dart';
import 'package:fast_app_base/common/widget/w_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:nav/dialog/dialog.dart';
import 'package:after_layout/after_layout.dart';

import 'vo/vo_write_todo.dart';

class WriteTodoDialog extends DialogWidget<WriteTodoResult> {
  WriteTodoDialog({super.key});

  @override
  DialogState<WriteTodoDialog> createState() => _WriteTodoDialogState();
}

class _WriteTodoDialogState extends DialogState<WriteTodoDialog>
    with AfterLayoutMixin {
  DateTime _selectedDate = DateTime.now();
  final textController = TextEditingController();
  final node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BottomDialogScaffold(
        body: RoundedContainer(
      color: context.backgroundColor,
      child: Column(
        children: [
          Row(
            children: [
              '할일을 작성해주세요.'.text.bold.size(18).make(),
              spacer,
              _selectedDate.formattedDate.text.make(),
              IconButton(
                  onPressed: _selectDate,
                  icon: const Icon(Icons.calendar_month)),
            ],
          ),
          height20,
          Row(
            children: [
              Expanded(
                  child: TextField(
                focusNode: node,
                controller: textController,
              )),
              RoundButton(
                text: '추가',
                onTap: () {
                  widget.hide(WriteTodoResult(_selectedDate, textController.text));
                },
              ),
            ],
          )
        ],
      ),
    ));
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    AppKeyboardUtil.show(context, node);
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _selectedDate.subtract(const Duration(days: 365)),
      lastDate: _selectedDate.add(const Duration(days: 365 * 10)),
    );

    if(date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }
}
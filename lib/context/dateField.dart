import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final Function(DateTime?)? onDateTimeSelected; // Callback to parent
  final DateTime? initialDateTime; // Accept initial DateTime

  DatePickerField({this.onDateTimeSelected, this.initialDateTime});

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialDateTime != null) {
      // Format the initial DateTime and set it to the controller
      _controller.text =
          "${widget.initialDateTime!.month}/${widget.initialDateTime!.day}/${widget.initialDateTime!.year} - ${widget.initialDateTime!.hour}:${widget.initialDateTime!.minute.toString().padLeft(2, '0')}";
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: widget.initialDateTime ??
          DateTime.now(), // Use initial value if available
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );

      if (selectedTime != null) {
        final DateTime finalDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        _controller.text =
            "${finalDateTime.month}/${finalDateTime.day}/${finalDateTime.year} - ${finalDateTime.hour}:${finalDateTime.minute.toString().padLeft(2, '0')}";

        if (widget.onDateTimeSelected != null) {
          widget.onDateTimeSelected!(finalDateTime);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Date & Time',
        hintText: 'MM/DD/YY - HH:MM:SS',
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_month),
          onPressed: () {
            _selectDateTime(context);
          },
        ),
      ),
      onTap: () {
        _selectDateTime(context);
      },
    );
  }
}

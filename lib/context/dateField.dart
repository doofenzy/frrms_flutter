import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final Function(DateTime?)? onDateTimeSelected; // Callback to parent

  DatePickerField({this.onDateTimeSelected});

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

  Future<void> _selectDateTime(BuildContext context) async {
    // Show date picker
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      // Show time picker
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final DateTime finalDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // Update the text field
        _controller.text =
            "${finalDateTime.month}/${finalDateTime.day}/${finalDateTime.year} - ${finalDateTime.hour}:${finalDateTime.minute.toString().padLeft(2, '0')}";

        // Notify parent widget of the selected date and time
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
            // Trigger date and time picker
            _selectDateTime(context);
          },
        ),
      ),
      onTap: () {
        // Trigger date and time picker
        _selectDateTime(context);
      },
    );
  }
}

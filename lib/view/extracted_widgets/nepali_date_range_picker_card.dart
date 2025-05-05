import 'package:flutter/material.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as nepali;

class NepaliDateRangePicker {
  /// Shows the picker in a bottom sheet and returns a valid Gregorian range if selected.
  static Future<DateTimeRange?> show(BuildContext context) async {
    final nepaliRange = await showModalBottomSheet<nepali.NepaliDateTimeRange>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const NepaliDatePicker(),
    );
    
    if (nepaliRange != null) {
      // Convert Nepali dates to Gregorian
      final startGregorian = nepaliRange.start.toDateTime();
      final endGregorian = nepaliRange.end.toDateTime();
      return DateTimeRange(start: startGregorian, end: endGregorian);
    }
    return null;
  }
}
class NepaliDatePicker extends StatefulWidget {
  const NepaliDatePicker({super.key});

  @override
  State<NepaliDatePicker> createState() => _NepaliDatePickerState();
}

class _NepaliDatePickerState extends State<NepaliDatePicker> {
  final nepali.NepaliDateTime _today = nepali.NepaliDateTime.now();
  nepali.NepaliDateTimeRange? _range;
  nepali.NepaliDateTime? _tempStart;
  String? _error;
  nepali.NepaliDateTime _currentMonth = nepali.NepaliDateTime.now();

  Map<String, nepali.NepaliDateTime> _getLimits(nepali.NepaliDateTime start) {
    final min = start.subtract(const Duration(days: 90));
    final maxCandidate = start.add(const Duration(days: 90));
    final max = maxCandidate.isAfter(_today) ? _today : maxCandidate;
    return {'min': min, 'max': max};
  }

  void _onDaySelected(nepali.NepaliDateTime selectedDate) {
    setState(() {
      if (_tempStart == null) {
        // Start a new range
        _tempStart = selectedDate;
        _range = null;
        _error = null;
      } else {
        // Complete the range
        final start = _tempStart!;
        final limits = _getLimits(start);

        if (selectedDate.isBefore(limits['min']!) || selectedDate.isAfter(limits['max']!)) {
          _error = 'Select within ±3 months of start date';
        } else {
          if (selectedDate.isBefore(start)) {
            _range = nepali.NepaliDateTimeRange(start: selectedDate, end: start);
          } else {
            _range = nepali.NepaliDateTimeRange(start: start, end: selectedDate);
          }
          _tempStart = null;
          _error = null;
        }
      }
    });
  }
  void _changeMonth(int delta) {
    setState(() {
     final totalMonths= (_currentMonth.year*12)+ _currentMonth.month -1 +delta;
     final newYear= totalMonths~/12;
     final newMonth= (totalMonths%12)+1;

     final newDate= nepali.NepaliDateTime(newYear,newMonth,1);
     if(newDate.isAfter(_today.subtract(const Duration(days: 365*5)))&& newDate.isBefore(_today.add(const Duration(days: 12)))){
      _currentMonth=newDate;
     }
    });
    
  }
  @override
  Widget build(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.dark(
          primary: colorScheme.primary,
          onPrimary: colorScheme.onPrimary,
          surface: colorScheme.surfaceContainer,
          onSurface: colorScheme.onSurface,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => _changeMonth(-1),
                  icon: const Icon(Icons.chevron_left),
                ),
                CustomText(text: '${_currentMonth.format('MMMM yyyy')} ',fontSize: 20,weight: FontWeight.bold,),
                IconButton(
                  onPressed: _currentMonth.isBefore(_today) ? () => _changeMonth(1) : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _NepaliCalendar(
              currentMonth: _currentMonth,
              today: _today,
              range: _range,
              tempStart: _tempStart,
              onDaySelected: _onDaySelected,
            ),
            const SizedBox(height: 8),
            if (_range != null)
              CustomText(
                text:
                    'Selected Date: ${_range!.start.format('yyyy-MM-dd')} to ${_range!.end.format('yyyy-MM-dd')}',
                    color: Theme.of(context).colorScheme.primary
              )
            else if (_tempStart != null)
              CustomText(
                text: 'Selected Date: ${_tempStart!.format('yyyy-MM-dd')} (Select end date)',
              ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child:  CustomText(text: 'Cancel',color: Colors.red),
                  ),
                  const SizedBox(width: 8),
                  TextButton(onPressed: _range != null && _error == null
                        ? () => Navigator.of(context).pop(_range)
                        : null , child: CustomText(text: 'Submit',color:Theme.of(context).colorScheme.primary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _NepaliCalendar extends StatelessWidget {
  final nepali.NepaliDateTime currentMonth;
  final nepali.NepaliDateTime today;
  final nepali.NepaliDateTimeRange? range;
  final nepali.NepaliDateTime? tempStart;
  final Function(nepali.NepaliDateTime) onDaySelected;

  const _NepaliCalendar({
    required this.currentMonth,
    required this.today,
    this.range,
    this.tempStart,
    required this.onDaySelected,
  });

  /// Calculate the number of days in the given Nepali month
  int _getDaysInMonth(nepali.NepaliDateTime month) {
    // Get the first day of the next month
    final nextMonth = month.month < 12
        ? nepali.NepaliDateTime(month.year, month.month + 1, 1)
        : nepali.NepaliDateTime(month.year + 1, 1, 1);
    // Calculate the difference in days
    final difference = nextMonth.difference(month);
    return difference.inDays;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Calculate days in the month
    final firstDayOfMonth = nepali.NepaliDateTime(currentMonth.year, currentMonth.month, 1);
    final daysInMonth = _getDaysInMonth(firstDayOfMonth); // Use helper function
    final firstWeekday = firstDayOfMonth.weekday % 7; // Adjust for Sunday start

    // Generate day widgets
    final List<Widget> dayWidgets = [];
    // Weekday headers
    const weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    for (var day in weekdays) {
      dayWidgets.add(
        Center(
          child: Text(
            day,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    // Empty cells for days before the first day
    for (var i = 0; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    // Days of the month
    for (var day = 1; day <= daysInMonth; day++) {
      final date = nepali.NepaliDateTime(currentMonth.year, currentMonth.month, day);
      final isDisabled = date.isBefore(today.subtract(const Duration(days: 365 * 5))) ||
          date.isAfter(today);
      final isInRange = range != null &&
          date.isAfter(range!.start) &&
          date.isBefore(range!.end);
      final isStartOrEnd = (range != null && (range!.start == date || range!.end == date)) ||
          (tempStart != null && tempStart == date);

      dayWidgets.add(
        GestureDetector(
          onTap: isDisabled ? null : () => onDaySelected(date),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isStartOrEnd
                  ? colorScheme.primary
                  : isInRange
                      ? colorScheme.primary.withOpacity(0.2)
                      : null,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  color: isStartOrEnd
                      ? colorScheme.onPrimary
                      : isDisabled
                          ? colorScheme.onSurface.withOpacity(0.4)
                          : colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 7,
          childAspectRatio: 1.5,
          children: dayWidgets,
        ),
      ],
    );
  }
}
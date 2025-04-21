import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ThreeMonthRangePicker {
  /// Shows the picker in a bottom sheet and returns a valid range if selected.
  static Future<PickerDateRange?> show(BuildContext context) async {
    return await showModalBottomSheet<PickerDateRange>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const _ThreeMonthPickerSheet(),
    );
  }
}

class _ThreeMonthPickerSheet extends StatefulWidget {
  const _ThreeMonthPickerSheet();

  @override
  State<_ThreeMonthPickerSheet> createState() => _ThreeMonthPickerSheetState();
}

class _ThreeMonthPickerSheetState extends State<_ThreeMonthPickerSheet> {
  final DateTime _today = DateTime.now(); // Replace with DateTime.now()
  PickerDateRange? _range;
  String? _error;

  Map<String, DateTime> _getLimits(DateTime start) {
    final min = start.subtract(const Duration(days: 90));
    final maxCandidate = start.add(const Duration(days: 90));
    final max = maxCandidate.isAfter(_today) ? _today : maxCandidate;
    return {'min': min, 'max': max};
  }

  void _onChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final PickerDateRange r = args.value;
      final start = r.startDate;
      final end = r.endDate ?? start;

      if (start != null && end != null) {
        final limits = _getLimits(start);

        if (end.isBefore(limits['min']!) || end.isAfter(limits['max']!)) {
          setState(() {
            _error = 'Select within ±3 months of start date';
          });
        } else {
          setState(() {
            _range = r;
            _error = null;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.dark(
          primary: Theme.of(context).colorScheme.primary,
          onPrimary: Theme.of(context).colorScheme.onPrimary,
          surface: Theme.of(context).colorScheme.surfaceContainer,
          onSurface: Theme.of(context).colorScheme.onSurface,
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
            Text(
              'Select Date Range',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged: _onChanged,
              maxDate: _today,
              headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(color: colorScheme.onSurface)),
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
              showActionButtons: true,
              initialSelectedRange: _range,
              onCancel: () => Navigator.of(context).pop(),
              onSubmit: (_) {
                if (_range != null && _error == null) {
                  Navigator.of(context).pop(_range);
                }
              },
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

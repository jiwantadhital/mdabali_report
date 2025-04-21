// import 'package:flutter/material.dart';
// import 'package:nepali_utils/nepali_utils.dart';
// import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

// class NepaliThreeMonthPicker {
//   static Future<DateTimeRange?> show(BuildContext context) async {
//     return await showModalBottomSheet<DateTimeRange>(
//       backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => const NepaliThreeMonthPickerSheet(),
//     );
//   }
// }

// class NepaliThreeMonthPickerSheet extends StatefulWidget {
//   const NepaliThreeMonthPickerSheet({super.key});

//   @override
//   State<NepaliThreeMonthPickerSheet> createState() =>
//       NepaliThreeMonthPickerSheetState();
// }

// class NepaliThreeMonthPickerSheetState
//     extends State<NepaliThreeMonthPickerSheet> {
//   final NepaliDateTime _todayNepali = NepaliDateTime.now();
//   NepaliDateTime? _startDate;
//   NepaliDateTime? _endDate;
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     // Open the Nepali calendar as soon as the bottom sheet opens
//     Future.delayed(Duration.zero, () {
//       _selectDateRange();
//     });
//   }

//   Map<String, NepaliDateTime> _getLimits(NepaliDateTime start) {
//     NepaliDateTime min;
//     if (start.month > 3) {
//       min = NepaliDateTime(start.year, start.month - 3, start.day);
//     } else {
//       min = NepaliDateTime(start.year - 1, start.month + 9, start.day);
//     }

//     NepaliDateTime maxCandidate;
//     if (start.month <= 9) {
//       maxCandidate = NepaliDateTime(start.year, start.month + 3, start.day);
//     } else {
//       maxCandidate = NepaliDateTime(start.year + 1, start.month - 9, start.day);
//     }

//     final NepaliDateTime max =
//         maxCandidate.isAfter(_todayNepali) ? _todayNepali : maxCandidate;

//     return {'min': min, 'max': max};
//   }

//   DateTimeRange? _convertToADRange() {
//     if (_startDate == null) return null;

//     final adStartDate = _startDate!.toDateTime();
//     final adEndDate = _endDate?.toDateTime() ?? adStartDate;

//     return DateTimeRange(start: adStartDate, end: adEndDate);
//   }

//   Future<void> _selectDateRange() async {
//     try {
//       final picked = await picker.showMaterialDateRangePicker(
//         context: context,
//         firstDate: NepaliDateTime(2070, 1, 1),
//         lastDate: _todayNepali,
//         initialDateRange: _startDate != null && _endDate != null
//             ? picker.NepaliDateTimeRange(start: _startDate!, end: _endDate!)
//             : null,
//         builder: (context, child) {
//           return Theme(
//             data: Theme.of(context).copyWith(
//               colorScheme: ColorScheme.dark(
//                 primary: Theme.of(context).colorScheme.primary,
//                 onPrimary: Theme.of(context).colorScheme.onPrimary,
//                 surface: Theme.of(context).colorScheme.surfaceContainer,
//                 onSurface: Theme.of(context).colorScheme.onSurface,
//               ),
//             ),
//             child: child!,
//           );
//         },
//       );

//       if (picked != null) {
//         final start = picked.start;
//         final end = picked.end;

//         final limits = _getLimits(start);

//         if (end.isBefore(limits['min']!) || end.isAfter(limits['max']!)) {
//           setState(() {
//             _error = 'Select within ±3 months of start date';
//           });
//         } else {
//           setState(() {
//             _startDate = start;
//             _endDate = end;
//             _error = null;
//           });
//         }
//       } else {
//         // User cancelled selection — close the bottom sheet
//         Navigator.of(context).pop();
//       }
//     } catch (e) {
//       print("Error selecting date range: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var colorScheme = Theme.of(context).colorScheme;

//     return Container(
//       padding: EdgeInsets.only(
//         top: 16,
//         left: 16,
//         right: 16,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Selected Nepali Date Range',
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           const SizedBox(height: 16),

//           // Display selected range
//           Container(
//             padding: EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: colorScheme.surfaceContainer,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Column(
//               children: [
//                 Text(
//                   _startDate != null
//                       ? 'Selected Range (BS):'
//                       : 'No date range selected',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 if (_startDate != null)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8),
//                     child: Text(
//                       '${NepaliDateFormat("yyyy-MM-dd").format(_startDate!)} to ${NepaliDateFormat("yyyy-MM-dd").format(_endDate ?? _startDate!)}',
//                     ),
//                   ),
//               ],
//             ),
//           ),

//           if (_error != null)
//             Padding(
//               padding: const EdgeInsets.only(top: 8),
//               child: Text(
//                 _error!,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             ),

//           const SizedBox(height: 16),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('Cancel'),
//               ),
//               SizedBox(width: 16),
//               ElevatedButton(
//                 onPressed: _startDate == null || _error != null
//                     ? null
//                     : () {
//                         final adRange = _convertToADRange();
//                         Navigator.of(context).pop(adRange);
//                       },
//                 child: Text('Confirm'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class NepaliThreeMonthRangePicker {
//   /// Shows the Nepali calendar picker in a bottom sheet and returns a valid range in AD format if selected.
//   static Future<DateTimeRange?> show(BuildContext context) async {
//     return await showModalBottomSheet<DateTimeRange>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => const NepaliThreeMonthPickerSheet(),
//     );
//   }
// }

// class NepaliThreeMonthPickerSheet extends StatefulWidget {
//   const NepaliThreeMonthPickerSheet();

//   @override
//   State<NepaliThreeMonthPickerSheet> createState() =>
//       NepaliThreeMonthPickerSheetState();
// }

// class NepaliThreeMonthPickerSheetState
//     extends State<NepaliThreeMonthPickerSheet> {
//   final NepaliDateTime _todayNepali = NepaliDateTime.now();
//   final DateTime _todayAD = DateTime.now();
//   NepaliDateTime? _startDate;
//   NepaliDateTime? _endDate;
//   String? _error;

//   Map<String, NepaliDateTime> _getLimits(NepaliDateTime start) {
//     // Calculate 3 months before
//     NepaliDateTime min;
//     if (start.month > 3) {
//       min = NepaliDateTime(start.year, start.month - 3, start.day);
//     } else {
//       // Handle year boundary
//       min = NepaliDateTime(start.year - 1, start.month + 9, start.day);
//     }

//     // Calculate 3 months after
//     NepaliDateTime maxCandidate;
//     if (start.month <= 9) {
//       maxCandidate = NepaliDateTime(start.year, start.month + 3, start.day);
//     } else {
//       // Handle year boundary
//       maxCandidate = NepaliDateTime(start.year + 1, start.month - 9, start.day);
//     }

//     // Ensure maxDate doesn't exceed today
//     final NepaliDateTime max =
//         maxCandidate.isAfter(_todayNepali) ? _todayNepali : maxCandidate;

//     return {'min': min, 'max': max};
//   }

//   // Convert Nepali date range to AD DateTimeRange
//   DateTimeRange? _convertToADRange() {
//     if (_startDate == null) return null;

//     final adStartDate = _startDate!.toDateTime();
//     final adEndDate = _endDate?.toDateTime() ?? adStartDate;

//     return DateTimeRange(start: adStartDate, end: adEndDate);
//   }

//   Future<void> _selectDateRange() async {
//     try {
//       picker.NepaliDateTimeRange? picked =
//           await picker.showMaterialDateRangePicker(
//         context: context,
//         firstDate: NepaliDateTime(2070, 1, 1),
//         lastDate: _todayNepali,
//         initialDateRange: _startDate != null && _endDate != null
//             ? picker.NepaliDateTimeRange(start: _startDate!, end: _endDate!)
//             : null,
//         builder: (context, child) {
//           return Theme(
//             data: Theme.of(context).copyWith(
//               colorScheme: ColorScheme.dark(
//                 primary: Theme.of(context).colorScheme.primary,
//                 onPrimary: Theme.of(context).colorScheme.onPrimary,
//                 surface: Theme.of(context).colorScheme.surfaceContainer,
//                 onSurface: Theme.of(context).colorScheme.onSurface,
//               ),
//             ),
//             child: child!,
//           );
//         },
//       );

//       if (picked != null) {
//         final start = picked.start;
//         final end = picked.end;

//         final limits = _getLimits(start);

//         if (end.isBefore(limits['min']!) || end.isAfter(limits['max']!)) {
//           setState(() {
//             _error = 'Select within ±3 months of start date';
//           });
//         } else {
//           setState(() {
//             _startDate = start;
//             _endDate = end;
//             _error = null;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error selecting date range: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var colorScheme = Theme.of(context).colorScheme;

//     return Container(
//       padding: EdgeInsets.only(
//         top: 16,
//         left: 16,
//         right: 16,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Select Nepali Date Range',
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           const SizedBox(height: 16),

//           // Display selected range
//           Container(
//             padding: EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: colorScheme.surfaceContainer,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Column(
//               children: [
//                 Text(
//                   _startDate != null
//                       ? 'Selected Range (BS):'
//                       : 'No date range selected',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 if (_startDate != null)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8),
//                     child: Text(
//                       '${NepaliDateFormat("yyyy-MM-dd").format(_startDate!)} to ${NepaliDateFormat("yyyy-MM-dd").format(_endDate ?? _startDate!)}',
//                     ),
//                   ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Button to open the picker
//           ElevatedButton(
//             onPressed: _selectDateRange,
//             child: Text('Open Nepali Calendar'),
//           ),

//           if (_error != null)
//             Padding(
//               padding: const EdgeInsets.only(top: 8),
//               child: Text(
//                 _error!,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             ),

//           const SizedBox(height: 16),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('Cancel'),
//               ),
//               SizedBox(width: 16),
//               ElevatedButton(
//                 onPressed: _startDate == null || _error != null
//                     ? null
//                     : () {
//                         final adRange = _convertToADRange();
//                         Navigator.of(context).pop(adRange);
//                       },
//                 child: Text('Confirm'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

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

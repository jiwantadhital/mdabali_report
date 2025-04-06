import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdabali_report/bloc/five_month_data_bloc/bloc/five_month_data_bloc.dart';
import 'package:mdabali_report/bloc/monthly_aggregate_bloc/bloc/monthly_aggregate_bloc.dart';
import 'package:mdabali_report/resources/images_constants.dart';

import '../extracted_widgets/custom_text.dart';
import 'charts/line_chart_card.dart';
import 'charts/pie_chart_card.dart';
import 'header_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return RefreshIndicator(
      onRefresh: () {
        context.read<MonthlyAggregateBloc>().add(FetchMonthlyAggregate());
        return Future.delayed(const Duration(milliseconds: 1200));
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset(
                    ImagesConstants.arjnaLogo,
                    height: 30,
                    width: 30,
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  CustomText(
                    text: 'Arjan saving and credit cooperative',
                    textOverflow: TextOverflow.ellipsis,
                    letterSpacing: 1,
                    fontSize: 16,
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              CustomText(
                text: 'All your transaction details',
                fontSize: 16,
                weight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              const SizedBox(
                height: 24,
              ),
              HeaderSection(),
              const SizedBox(
                height: 24,
              ),
              CustomText(
                text: 'Summary of successful transactions',
                fontSize: 16,
                color: colorScheme.onSurface,
                weight: FontWeight.w600,
              ),
              const SizedBox(
                height: 24,
              ),
              PieChartCard(),
              const SizedBox(
                height: 24,
              ),
              CustomText(
                text: 'Transaction Trends',
                fontSize: 16,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 16,
              ),
              //line chart for Utility
              UtilityLineChartSection(),
              const SizedBox(
                height: 24,
              ),
              //line chart for Dfs(Dr)
              DfsDrLineChartSection(),
              const SizedBox(
                height: 24,
              ),
              //line chart for Dfs(cr   )
              DfsCrLineChartSection(),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DfsCrLineChartSection extends StatelessWidget {
  const DfsCrLineChartSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiveMonthDataBloc, FiveMonthDataState>(
      builder: (context, state) {
        if (state is FiveMonthDataLoading) {
          return ShimmerLineChartCard();
        } else if (state is FiveMonthDataLoaded) {
          return LineChartCard(
            title: 'DFS(Cr)',
            dataPoints: state.data.data?.dfsCredit
                    ?.map((e) => e.amount ?? 0.0)
                    .toList() ??
                [],
            months: state.data.data?.dfsCredit
                    ?.map((e) => e.month ?? '')
                    .toList() ??
                [],
          );
        } else if (state is FiveMonthDataError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                SizedBox(height: 8),
                CustomText(
                  text: state.message,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                SizedBox(height: 8),
                CustomText(
                  text: 'Failed to load Data',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class UtilityLineChartSection extends StatelessWidget {
  const UtilityLineChartSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiveMonthDataBloc, FiveMonthDataState>(
      builder: (context, state) {
        if (state is FiveMonthDataLoading) {
          return ShimmerLineChartCard();
        } else if (state is FiveMonthDataLoaded) {
          return LineChartCard(
            title: 'Utility',
            dataPoints: state.data.data?.utility
                    ?.map((e) => e.amount ?? 0.0)
                    .toList() ??
                [],
            months:
                state.data.data?.utility?.map((e) => e.month ?? '').toList() ??
                    [],
          );
        } else if (state is FiveMonthDataError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                SizedBox(height: 8),
                CustomText(
                  text: state.message,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                SizedBox(height: 8),
                CustomText(
                  text: 'Failed to load Data',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class DfsDrLineChartSection extends StatelessWidget {
  const DfsDrLineChartSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiveMonthDataBloc, FiveMonthDataState>(
      builder: (context, state) {
        if (state is FiveMonthDataLoading) {
          return ShimmerLineChartCard();
        } else if (state is FiveMonthDataLoaded) {
          return LineChartCard(
            title: 'DFS(Dr)',
            dataPoints: state.data.data?.dfsDebit
                    ?.map((e) => e.amount ?? 0.0)
                    .toList() ??
                [],
            months:
                state.data.data?.dfsDebit?.map((e) => e.month ?? '').toList() ??
                    [],
          );
        } else if (state is FiveMonthDataError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                SizedBox(height: 8),
                CustomText(
                  text: state.message,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error, size: 24),
                SizedBox(height: 8),
                CustomText(
                  text: 'Failed to load Data',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

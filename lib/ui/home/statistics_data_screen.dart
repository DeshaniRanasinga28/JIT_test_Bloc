import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../bloc/transaction_bloc.dart';
import '../../const/string_const.dart';
import '../../const/variables.dart';


class StatisticalDataScreen extends StatefulWidget {
  const StatisticalDataScreen({super.key});

  @override
  State<StatisticalDataScreen> createState() => _StatisticalDataScreenState();
}

class _StatisticalDataScreenState extends State<StatisticalDataScreen> {

  List<_Data> replenishmentDataSet = [];
  List<_Data> transferDataSet = [];
  List<_Data> withdrawalDataSet = [];

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
            const SizedBox(
              height: 20.0,
            ),
          
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionInitial) {
                  context.read<TransactionBloc>().add(const FetchTransaction());
                }
                if (state is DisplayTransaction) {
                  setReplenishmentData(state);
                  return SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(
                          text: StringConst.yearlyReplenishmentAnalysisLabel,
                          textStyle: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w800)),
                      legend: const Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<_Data, String>>[
                        LineSeries<_Data, String>(
                            dataSource: replenishmentDataSet,
                            //setDataSet(state),
                            xValueMapper: (_Data sales, _) => sales.month,
                            yValueMapper: (_Data sales, _) => sales.amount,
                            name: StringConst.replenishmentLabel,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true))
                      ]);
                }
                return Container(
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          
            const SizedBox(
              height: 20.0,
            ),
          
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionInitial) {
                  context.read<TransactionBloc>().add(const FetchTransaction());
                }
                if (state is DisplayTransaction) {
                  setTransferData(state);
                  return SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(
                          text: StringConst.yearlyTransferAnalysisLabel,
                          textStyle: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w800)),
                      legend: const Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<_Data, String>>[
                        LineSeries<_Data, String>(
                            dataSource: transferDataSet,
                            //setDataSet(state),
                            xValueMapper: (_Data sales, _) => sales.month,
                            yValueMapper: (_Data sales, _) => sales.amount,
                            name: StringConst.transferLabel,
                            dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                      ]);
                }
                return Container(
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          
            const SizedBox(
              height: 20.0,
            ),
          
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionInitial) {
                  context.read<TransactionBloc>().add(const FetchTransaction());
                }
                if (state is DisplayTransaction) {
                  setWithdrawalData(state);
                  return SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(
                          text: StringConst.yearlyWithdrawalAnalysisLabel,
                          textStyle: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w800)),
                      legend: const Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<_Data, String>>[
                        LineSeries<_Data, String>(
                            dataSource: withdrawalDataSet,
                            //setDataSet(state),
                            xValueMapper: (_Data sales, _) => sales.month,
                            yValueMapper: (_Data sales, _) => sales.amount,
                            name: StringConst.withdrawalLabel,
                            dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                      ]);
                }
                return Container(
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          
            const SizedBox(
              height: 1000.0,
            ),
          ]),
        ));
  }

  List<_Data>? setReplenishmentData(DisplayTransaction state) {
    for (var element in state.trans) {
      if (element.operationType == replenishmentOperation) {
        replenishmentDataSet.add(_Data(element.date, element.amount));
        replenishmentDataSet.sort((a, b) => a.month.compareTo(b.month));
        continue;
      }
    }
  }

  List<_Data>? setTransferData(DisplayTransaction state) {
    for (var element in state.trans) {
      if (element.operationType == transferOperation) {
        transferDataSet.add(_Data(element.date, element.amount));
        transferDataSet.sort((a, b) => a.month.compareTo(b.month));
        continue;
      }
    }
  }

  List<_Data>? setWithdrawalData(DisplayTransaction state) {
    for (var element in state.trans) {
      if (element.operationType == withdrawalOperation) {
        withdrawalDataSet.add(_Data(element.date, element.amount));
        withdrawalDataSet.sort((a, b) => a.month.compareTo(b.month));
        continue;
      }
    }
  }
}

class _Data {
  _Data(this.month, this.amount);

  final String month;
  final double amount;
}

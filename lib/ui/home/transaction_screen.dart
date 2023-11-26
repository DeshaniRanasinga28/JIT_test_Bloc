import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jit_transfer_app/ui/home/widget/transaction_list_view.dart';

import '../../bloc/transaction_bloc.dart';
import '../../const/string_const.dart';
import '../../models/transaction_model.dart';
import '../transactions/transaction_details_screen.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionInitial) {
            context.read<TransactionBloc>().add(const FetchTransaction());
          }
          if (state is DisplayTransaction) {
            return Container(
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                state.trans.isNotEmpty ?
                SizedBox(
                  width: w,
                  height: 20.0,
                  child: Text(
                      "${StringConst.noOfTransactionsLabel} : ${state.trans.length}"),
                ) : Container(),
                state.trans.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.all(8),
                          itemCount: state.trans.length,
                          itemBuilder: (context, i) {
                            return TransactionListView(
                              onTap: () => navigateToViewTransaction(context, state.trans.elementAt(i)),
                              transaction: state.trans[i],
                            );
                          },
                        ),
                      )
                    : const Center(
                    child: Text(
                      StringConst.dataNotFoundLabel,
                      style: TextStyle(fontSize: 18),
                    )),
                SizedBox(
                  width: w,
                  height: 30.0,
                  child: Text(
                      "${StringConst.noOfTransactionsLabel} : ${state.trans.length}"),
                )
              ]),
            );
          }
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  navigateToViewTransaction(BuildContext context, TransDetails transaction){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => TransactionDetailsScreen(
          transDetails: transaction,
        )),
      ),
    );
  }
}

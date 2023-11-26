import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/transaction_bloc.dart';
import '../../common_widget/custom_dialog_box.dart';
import '../../common_widget/custom_elevated_button.dart';
import '../../common_widget/custom_snack_bar.dart';
import '../../const/color_const.dart';
import '../../const/string_const.dart';
import '../../models/transaction_model.dart';
import '../home/home_screen.dart';

class TransactionDetailsScreen extends StatefulWidget {
  final TransDetails transDetails;

  const TransactionDetailsScreen({Key? key, required this.transDetails})
      : super(key: key);

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorConst.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorConst.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        width: w,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: w,
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    widget.transDetails.type.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                        fontFamily: "Lora",
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 28.0),
                  ),
                ),
              ),
              Container(
                width: w,
                alignment: Alignment.center,
                child: const Text(
                  StringConst.transactionSummaryLabel,
                  style: TextStyle(
                      fontFamily: "Lora",
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      fontSize: 20.0),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                StringConst.transactionDateLabel,
                style: TextStyle(
                    fontFamily: "FiraSans",
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    fontSize: 14.0),
              ),
              Text(widget.transDetails.date),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                StringConst.amountLabel,
                style: TextStyle(
                    fontFamily: "FiraSans",
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    fontSize: 14.0),
              ),
              Text(widget.transDetails.amount.toStringAsFixed(2).toString()),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                StringConst.commissionLabel,
                style: TextStyle(
                    fontFamily: "FiraSans",
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    fontSize: 14.0),
              ),
              Text(widget.transDetails.commission.toStringAsFixed(2).toString()),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                StringConst.totalLabel,
                style: TextStyle(
                    fontFamily: "FiraSans",
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    fontSize: 14.0),
              ),
              Text(widget.transDetails.total.toStringAsFixed(2).toString()),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                StringConst.transactionNumberLabel,
                style: TextStyle(
                    fontFamily: "FiraSans",
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    fontSize: 14.0),
              ),
              Text(widget.transDetails.transactionNumber.toString()),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                StringConst.typeOfOperationLabel,
                style: TextStyle(
                    fontFamily: "FiraSans",
                    fontWeight: FontWeight.w800,
                    color: Colors.black45,
                    fontSize: 14.0),
              ),
              Text(widget.transDetails.operationType.toString()),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: CustomElevatedButton(
          onPressed: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    height: 330.0,
                    description: StringConst.cancelTransactionLabel,
                    onPressed: () => transactionCancel(context),
                  );
                });
          },
          label: StringConst.cancelLabel,
        ),
      ),
    );
  }

  transactionCancel(BuildContext context) {

    context.read<TransactionBloc>().add(
      UpdateTransaction(
        todo: TransDetails(
          id: widget.transDetails.id,
          type: widget.transDetails.type,
          transactionNumber: widget.transDetails.transactionNumber,
          amount: widget.transDetails.amount,
          date: widget.transDetails.date,
          commission: widget.transDetails.commission,
          total: widget.transDetails.total,
          operationType: widget.transDetails.type,
          status: "cancel",
        ),
      ),
    );
    context.read<TransactionBloc>().add(const FetchTransaction());

    navigateToHome(context);
    CustomSnackBar.showSnackBar("The ${widget.transDetails.transactionNumber} ${StringConst.cancelTransactionLabel2}");
  }

  navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/transaction_bloc.dart';
import '../../common_widget/custom_elevated_button.dart';
import '../../common_widget/custom_text_form_field.dart';
import '../../const/color_const.dart';
import '../../const/string_const.dart';
import '../home/home_screen.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({Key? key}) : super(key: key);

  @override
  State<CreateTransactionScreen> createState() => _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController transactionNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController commissionController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController operationTypeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConst.black,
          title: const Text(
            StringConst.createTransactionLabel,
            style: TextStyle(color: ColorConst.white),
          ),
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
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                    controller: typeController,
                    labelText: StringConst.typeOfTransactionLabel,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                    controller: transactionNumberController,
                    labelText: StringConst.transactionNumberLabel,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                    controller: amountController,
                    labelText: StringConst.amountLabel,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                    controller: dateController,
                    labelText: StringConst.transactionDateLabel,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                    controller: operationTypeController,
                    labelText: StringConst.typeOfOperationLabel,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: CustomElevatedButton(
            onPressed: () => _submitForm(context),
            label: StringConst.saveLabel,
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<TransactionBloc>().add(
        AddTransaction(
          type: typeController.text,
          transactionNumber: transactionNumberController.text,
          amount: double.parse(amountController.text),
          date: dateController.text,
          commission: double.parse(amountController.text) * 10 / 100,
          total:  double.parse(amountController.text) + (double.parse(amountController.text) * 10 / 100),
          operationType: operationTypeController.text,
          status: "active",
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        content: Text(StringConst.transactionAddedSuccessfullyMsgLabel),
      ));
      context.read<TransactionBloc>().add(const FetchTransaction());
      navigateToHome(context);
      clearControllers();
    }
  }

  clearControllers() {
    typeController.clear();
    transactionNumberController.clear();
    amountController.clear();
    dateController.clear();
    commissionController.clear();
    totalController.clear();
    operationTypeController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    typeController.dispose();
    transactionNumberController.dispose();
    amountController.dispose();
    dateController.dispose();
    commissionController.dispose();
    totalController.dispose();
    operationTypeController.dispose();
  }

  navigateToHome(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}

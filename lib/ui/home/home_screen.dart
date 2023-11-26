import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jit_transfer_app/ui/home/transaction_screen.dart';

import '../../bloc/user_block.dart';
import '../../common_widget/custom_dialog_box.dart';
import '../../const/color_const.dart';
import '../../const/string_const.dart';
import '../login/login_screen.dart';
import 'statistics_data_screen.dart';
import '../transactions/create_transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: ColorConst.black,
            actions: [
              IconButton(
                onPressed: () => navigateToAddTransaction(context),
                icon: const Icon(
                  Icons.add,
                  color: ColorConst.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                            height: 310.0,
                            description: StringConst.logoutMsgLabel,
                            onPressed: () => logout(context));
                      });
                },
                icon: const Icon(
                  Icons.logout,
                  color: ColorConst.white,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.blue,
                  indicatorColor: Colors.black,
                  indicatorWeight: 5,
                  labelStyle: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "FiraSans"),
                  tabs: const [
                    Tab(
                      text: StringConst.transactionsLabel,
                    ),
                    Tab(
                      text: StringConst.statisticsLabel,
                    )
                  ],
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
                SizedBox(
                  width: w,
                  height: h + 350.0,
                  child: TabBarView(
                    controller: _tabController,
                    children: const <Widget>[
                      Expanded(child: TransactionScreen()),
                      Expanded(child: StatisticalDataScreen()),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logout(BuildContext context) {
    BlocProvider.of<UserBlock>(context).logout();
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => LoginScreen()));
  }

  void navigateToAddTransaction(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateTransactionScreen()),
    );
  }
}


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/transaction_model.dart';
import '../db_helper/transactions_db_Helper.dart';
part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    List<TransDetails> todos = [];

    on<AddTransaction>((event, emit) async {
      await TransactionsDBHelper.instance.insertTransactions(
        TransDetails(
          type: event.type,
          transactionNumber: event.transactionNumber,
          amount: event.amount,
          date: event.date,
          commission: event.commission,
          total: event.total,
          operationType: event.operationType,
          status: event.status,
        ),
      );
    });

    on<UpdateTransaction>((event, emit) async {
      await TransactionsDBHelper.instance.updateTransaction(
        todo: event.todo,
      );
    });

    on<FetchTransaction>((event, emit) async {
      todos = await TransactionsDBHelper.instance.getActiveTransactions();
      emit(DisplayTransaction(trans: todos));
    });

    on<DeleteTransaction>((event, emit) async {
      await TransactionsDBHelper.instance.deleteTransaction(id: event.id);
      add(const FetchTransaction());
    });
  }
}

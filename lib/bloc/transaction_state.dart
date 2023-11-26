part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();
}

class TransactionInitial extends TransactionState {
  @override
  List<Object> get props => [];
}

class DisplayTransaction extends TransactionState {
  final List<TransDetails> trans;

  const DisplayTransaction({required this.trans});
  @override
  List<Object> get props => [trans];
}

class DisplaySpecificTransaction extends TransactionState {
  final TransDetails trans;

  const DisplaySpecificTransaction({required this.trans});
  @override
  List<Object> get props => [trans];
}

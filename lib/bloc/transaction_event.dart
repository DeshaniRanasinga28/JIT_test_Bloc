part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();
}


class AddTransaction extends TransactionEvent {
  final String type;
  final String transactionNumber;
  final double amount;
  final String date;
  final double commission;
  final double total;
  final String operationType;
  final String status;

  const AddTransaction({
    required this.type,
    required this.transactionNumber,
    required this.amount,
    required this.date,
    required this.commission,
    required this.total,
    required this.operationType,
    required this.status,
  });

  @override
  List<Object?> get props =>
      [type, transactionNumber, amount, date, commission, total, operationType, status];
}

class UpdateTransaction extends TransactionEvent {
  final TransDetails todo;
  const UpdateTransaction({required this.todo});
  @override
  List<Object?> get props => [todo];
}

class FetchTransaction extends TransactionEvent {
  const FetchTransaction();

  @override
  List<Object?> get props => [];
}

class FetchSpecificTransaction extends TransactionEvent {
  final int id;
  const FetchSpecificTransaction({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteTransaction extends TransactionEvent {
  final int id;
  const DeleteTransaction({required this.id});
  @override
  List<Object?> get props => [id];
}

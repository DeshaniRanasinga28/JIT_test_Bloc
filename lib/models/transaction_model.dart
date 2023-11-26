// const String todoTable = 'transactions';

class TransDetailsFields {
  static final List<String> values = [
    id, type, transactionNumber, amount, date, commission, total, operationType, status
  ];


  static const String id = '_id';
  static const String type = 'type';
  static const String transactionNumber = 'transactionNumber';
  static const String amount = 'amount';
  static const String date = 'date';
  static const String commission = 'commission';
  static const String total = 'total';
  static const String operationType = 'operationType';
  static const String status = 'status';
}

class TransDetails {
  final int? id;
  final String type;
  final String transactionNumber;
  final double amount;
  final String date;
  final double commission;
  final double total;
  final String operationType;
  final String status;


  const TransDetails({
    this.id,
    required this.type,
    required this.transactionNumber,
    required this.amount,
    required this.date,
    required this.commission,
    required this.total,
    required this.operationType,
    required this.status,
  });

  TransDetails copy({
     int? id,
     String? type,
     String? transactionNumber,
     double? amount,
     String? date,
     double? commission,
     double? total,
     String? operationType,
     String? status,
  }) =>
      TransDetails(
        id: id ?? this.id,
        type: type ?? this.type,
        transactionNumber: transactionNumber ?? this.transactionNumber,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        commission: commission ?? this.commission,
        total: total ?? this.total,
        operationType: operationType ?? this.operationType,
        status: status ?? this.status,
      );

  static TransDetails fromJson(Map<String, Object?> json) => TransDetails(
        id: json[TransDetailsFields.id] as int?,
        type: json[TransDetailsFields.type] as String,
        transactionNumber: json[TransDetailsFields.transactionNumber] as String,
        amount: json[TransDetailsFields.amount] as double,
        date: json[TransDetailsFields.date] as String,
        commission: json[TransDetailsFields.commission] as double,
        total: json[TransDetailsFields.total] as double,
        operationType: json[TransDetailsFields.operationType] as String,
        status: json[TransDetailsFields.status] as String,
      );

  Map<String, Object?> toJson() => {
        TransDetailsFields.id: id,
        TransDetailsFields.type: type,
        TransDetailsFields.transactionNumber: transactionNumber,
        TransDetailsFields.amount: amount,
        TransDetailsFields.date: date,
        TransDetailsFields.commission: commission,
        TransDetailsFields.total: total,
        TransDetailsFields.operationType: operationType,
        TransDetailsFields.status: status,
      };
}

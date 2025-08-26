// import 'package:json_annotation/json_annotation.dart';

// part 'failure_model.g.dart';

// @JsonSerializable()
// class FailureModel {
//   @JsonKey(name: 'error')
//   List<String> errors;
//   int statusCode;

//   FailureModel({required this.errors, required this.statusCode});

//   factory FailureModel.fromJson(Map<String, dynamic> json) =>
//       _$FailureModelFromJson(json);

//   Map<String, dynamic> toJson() => _$FailureModelToJson(this);

//   @override
//   String toString() {
//     return 'FailureModel{errors: $errors, statusCode: $statusCode}';
//   }
// }
class FailureModel {
  final List<String> errors;
  final int statusCode;

  FailureModel({
    required this.errors,
    required this.statusCode,
  });

  factory FailureModel.fromJson(Map<String, dynamic> json) {
    final rawErrors = json['error'];
    List<String> parsedErrors = [];

    if (rawErrors == null) {
      parsedErrors = [];
    } else if (rawErrors is List) {
      parsedErrors = rawErrors.map((e) => e.toString()).toList();
    } else if (rawErrors is String) {
      parsedErrors = [rawErrors];
    }

    final rawStatus = json['statusCode'];
    int parsedStatus = 0;
    if (rawStatus is num) {
      parsedStatus = rawStatus.toInt();
    } else if (rawStatus is String) {
      parsedStatus = int.tryParse(rawStatus) ?? 0;
    }

    return FailureModel(
      errors: parsedErrors,
      statusCode: parsedStatus,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "error": errors,
      "statusCode": statusCode,
    };
  }

  @override
  String toString() {
    return 'FailureModel(errors: $errors, statusCode: $statusCode)';
  }
}

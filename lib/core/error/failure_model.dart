import 'package:json_annotation/json_annotation.dart';
part 'failure_model.g.dart';

@JsonSerializable()
class FailureModel {
  // @JsonKey(name: 'error')
  List<String> error;
  int statusCode;

  FailureModel({required this.error, required this.statusCode});

  factory FailureModel.fromJson(Map<String, dynamic> json) {
    print("///////////////////////////////");
    print(json);
    print("///////////////////////////////");
    return FailureModel(error: [], statusCode: 500);
    // return _$FailureModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FailureModelToJson(this);
}

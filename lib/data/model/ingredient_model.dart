import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'ingredient_model.freezed.dart';

part 'ingredient_model.g.dart';

@freezed
class IngredientModel with _$IngredientModel {
  const IngredientModel._();
  const factory IngredientModel({
    required String? image,
    required String? name,
    required Map<String, dynamic>? amount,
  }) = _IngredientModel;

  factory IngredientModel.fromJson(Map<String, Object?> json) =>
      _$IngredientModelFromJson(json);
}

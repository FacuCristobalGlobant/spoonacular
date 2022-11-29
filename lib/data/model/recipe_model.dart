import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'recipe_model.freezed.dart';

part 'recipe_model.g.dart';

@freezed
class RecipeModel with _$RecipeModel {
  const RecipeModel._();
  const factory RecipeModel({
    required int? id,
    required String? title,
    required String? summary,
    required String? instructions,
    required int? readyInMinutes,
    required int? servings,
    required String? image,
    required bool? vegetarian,
    required bool? vegan,
    required bool? glutenFree,
    required bool? dairyFree,
    required bool? veryHealthy,
    required bool? cheap,
    required bool? veryPopular,
    required bool? sustainable,
    required bool? lowFodmap,
    required int? weightWatcherSmartPoints,
    required String? gaps,
    required int? preparationMinutes,
    required int? cookingMinutes,
    required int? aggregateLikes,
    required int? healthScore,
    required String? creditsText,
    required String? license,
    required String? sourceName,
    required double? pricePerServing,
    required String? sourceUrl,
    required String? imageType,
    required String? spoonacularSourceUrl,
  }) = _RecipeModel;

  factory RecipeModel.fromJson(Map<String, Object?> json) =>
      _$RecipeModelFromJson(json);

  Map<String, bool> getRecipeTags() {
    return <String, bool>{
      'cheap': cheap ?? false,
      'dairyFree': dairyFree ?? false,
      'glutenFree': glutenFree ?? false,
      'veryHealthy': veryHealthy ?? false,
      'lowFodmap': lowFodmap ?? false,
      'veryPopular': veryPopular ?? false,
      'sustainable': sustainable ?? false,
      'vegan': vegan ?? false,
      'vegetarian': vegetarian ?? false,
    };
  }
}

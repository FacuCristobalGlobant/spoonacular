import 'package:get/get.dart';

import '../../domain/usecase/i_usecase.dart';
import '../../domain/usecase/implementations/get_nutritional_value_usecase.dart';

class NutritionalValueController extends GetxController
    with StateMixin<String> {
  final UseCase getNutritionalValueUseCase =
      Get.find<GetNutritionalValueUseCase>();

  int? recipeId;

  @override
  void onReady() {
    if (recipeId == null) {
      getNutritionalValue(
        int.parse(Get.parameters['id']!),
      );
    }
  }

  Future<void>? getNutritionalValue(int? id) async {
    recipeId = id;

    change(
      null,
      status: RxStatus.loading(),
    );

    try {
      String value = await getNutritionalValueUseCase(params: recipeId);
      change(
        value,
        status: RxStatus.success(),
      );
    } catch (e) {
      change(
        null,
        status: RxStatus.error(e.toString()),
      );
    }
  }
}

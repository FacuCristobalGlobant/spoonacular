import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:spoonacular/domain/usecase/implementations/get_nutritional_value_usecase.dart';

import 'package:spoonacular/presentation/controller/nutritional_value_controller.dart';

import 'nutritional_value_controller_test.mocks.dart';

@GenerateMocks([GetNutritionalValueUseCase])
void main() {
  group('nutritional value controller tests', () {
    test('fetch the nutritional value of a recipe from the API', () async {
      final GetNutritionalValueUseCase useCase =
          MockGetNutritionalValueUseCase();
      Get.put(useCase);
      final NutritionalValueController controller =
          NutritionalValueController();
      when(useCase.call(params: 1)).thenAnswer((_) async {
        return 'nutritional value data';
      });

      expect(
        controller.state,
        null,
      );
      await controller.getNutritionalValue(1);
      expect(
        controller.state,
        'nutritional value data',
      );
    });
  });
}

import 'package:get/get.dart';

import '../../data/model/recipe_model.dart';
import '../../domain/usecase/i_usecase.dart';
import '../../domain/usecase/implementations/get_search_results_usecase.dart';
import '../../domain/usecase/search_data_object.dart';

class SearchResultsController extends GetxController
    with StateMixin<List<RecipeModel>> {
  final UseCase getSearchResultsUseCase = Get.find<GetSearchResultsUseCase>();
  RxBool isInitialized = false.obs;

  RxList<RecipeModel> listOfRecipes = RxList<RecipeModel>();

  @override
  void onReady() {
    change(
      null,
      status: RxStatus.empty(),
    );
  }

  void resetSearchResults() {
    isInitialized(false);
    change(
      null,
      status: RxStatus.empty(),
    );
  }

  void getSearchResults(SearchDataObject params) async {
    isInitialized(true);
    listOfRecipes.clear();
    change(
      null,
      status: RxStatus.loading(),
    );
    try {
      listOfRecipes.addAll(
        await getSearchResultsUseCase.call(
          params: params,
        ),
      );
      listOfRecipes.isEmpty
          ? change(
              listOfRecipes,
              status: RxStatus.empty(),
            )
          : change(
              listOfRecipes,
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

import 'package:get/get.dart';

class RecipeSummaryController extends GetxController
    with StateMixin<List<int>> {
  RxList<int> visibleSummaries = RxList<int>();

  void switchHiding(int index) {
    visibleSummaries.contains(index)
        ? visibleSummaries.remove(index)
        : visibleSummaries.add(index);
  }

  bool containsIndex(int index) {
    return visibleSummaries.contains(index);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../core/util/api_constants.dart';
import '../../core/util/asset_constants.dart';
import '../../core/util/dimensions.dart';
import '../../core/util/keys.dart';
import '../../core/util/palette.dart';
import '../../core/util/text_constants.dart';
import '../controller/recipes_controller.dart';
import '../widget/company_logo.dart';
import '../widget/footer.dart';
import '../widget/not_found.dart';
import '../widget/recipe_card.dart';
import '../widget/recipe_card_vertical.dart';

class Home extends StatelessWidget {
  static const double searchIconWidth = 35;
  static const double sliverAppbarExtendedHeight = 200;
  static const double fivePercent = 0.05;
  static const EdgeInsets containerPadding = EdgeInsets.all(20);

  final RecipesController recipesController = Get.find<RecipesController>();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainBackground,
      body: CustomScrollView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverLayoutBuilder(
            builder: (
              BuildContext context,
              SliverConstraints constraints,
            ) {
              return SliverAppBar(
                shadowColor: Colors.black54,
                pinned: true,
                backgroundColor: Palette.primary,
                actions: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * fivePercent,
                    ),
                    child: Image.asset(
                      AssetConstants.searchIcon,
                      width: searchIconWidth,
                      color: Colors.white,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ],
                title: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * fivePercent,
                  ),
                  child: const CompanyLogo(),
                ),
                expandedHeight: sliverAppbarExtendedHeight,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  centerTitle: true,
                  title: constraints.crossAxisExtent >= Dimensions.smallScreen
                      ? const Text(TextConstants.slogan)
                      : null,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        AssetConstants.sliverBackground,
                        fit: BoxFit.cover,
                      ),
                      const ColoredBox(
                        color: Palette.darkOverlay,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (Get.width * fivePercent),
              ),
              child: Container(
                padding: Dimensions.topPadding,
                decoration: const BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      TextConstants.randomRecipesTitle,
                      style: TextStyle(
                        fontSize: Dimensions.bigFontSize,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    GestureDetector(
                      key: Keys.refreshRecipes,
                      onTap: () => recipesController
                          .getRandomRecipes(ApiConstants.numberOfRandomRecipes),
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          recipesController.obx(
            (state) {
              return SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * fivePercent,
                ),
                sliver: SliverLayoutBuilder(
                  builder:
                      (BuildContext context, SliverConstraints constraints) {
                    if (constraints.crossAxisExtent >= Dimensions.bigScreen) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (
                            BuildContext context,
                            int index,
                          ) {
                            return Builder(
                              builder: (context) {
                                return Row(
                                  children: [
                                    SizedBox.shrink(
                                      child: RecipeCard(
                                        recipe: state![index * 2],
                                        cardIndex: index * 2,
                                      ),
                                    ),
                                    ((index * 2) + 1 < state.length)
                                        ? SizedBox.shrink(
                                            child: RecipeCard(
                                              recipe: state[(index * 2) + 1],
                                              cardIndex: (index * 2) + 1,
                                            ),
                                          )
                                        : SizedBox.shrink(
                                            child: Container(),
                                          ),
                                  ],
                                );
                              },
                            );
                          },
                          childCount: (state!.length / 2).ceil(),
                        ),
                      );
                    } else if (constraints.crossAxisExtent <
                        Dimensions.smallScreen) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (
                            BuildContext context,
                            int index,
                          ) {
                            return Builder(
                              builder: (context) {
                                return RecipeCardVertical(
                                  recipe: state![index],
                                  cardIndex: index,
                                );
                              },
                            );
                          },
                          childCount: state!.length,
                        ),
                      );
                    } else {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (
                            BuildContext context,
                            int index,
                          ) {
                            return Builder(
                              builder: (context) {
                                return RecipeCard(
                                  recipe: state![index],
                                  cardIndex: index,
                                );
                              },
                            );
                          },
                          childCount: state!.length,
                        ),
                      );
                    }
                  },
                ),
              );
            },
            onLoading: const SliverSafeArea(
              minimum: Dimensions.safeAreaPadding,
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: containerPadding,
                    child: CircularProgressIndicator(
                      color: Palette.primary,
                    ),
                  ),
                ),
              ),
            ),
            onEmpty: const SliverToBoxAdapter(
              child: NotFound(),
            ),
            onError: (e) => SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: containerPadding,
                  child: Text(e.toString()),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Footer(),
          )
        ],
      ),
    );
  }
}

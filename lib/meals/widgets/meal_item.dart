import 'package:flutter/material.dart';
import 'package:test/meals/models/meal.dart';
import 'package:test/meals/widgets/meal_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    required this.meal,
    required this.onDescription,
    super.key,
  });
  final Meal meal;
  final Function({
    required BuildContext context,
    required Meal meal,
  }) onDescription;

  get _complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

    get _affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return (Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      // 只設定 shape 會無效，因為 Stack 會忽略在 Card 上的設定，所以需要加上 clipBehavior 強制將超出設定的東西砍掉隱藏
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      // 卡片的陰影
      elevation: 2,
      child: InkWell(
        onTap: () {
          onDescription(
            context: context,
            meal: meal,
          );
        },
        child: Stack(
          children: [
            FadeInImage(
              // placeholder：loading 的佔位
              placeholder: MemoryImage(kTransparentImage),
              // NetworkImage：從網路下來的照片網址
              image: NetworkImage(meal.imageUrl),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      textAlign: TextAlign.center,
                      // 限制文字不超過1行，超過就砍掉不顯示剩下的文字
                      maxLines: 1,
                      // 是否進行自動換行
                      softWrap: true,
                      // 將超出的文字顯示成...
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealTrait(
                          label: '${meal.duration.toInt()} min',
                          icon: Icons.schedule,
                        ),
                        MealTrait(
                          label: _complexityText,
                          icon: Icons.work,
                        ),
                        MealTrait(
                          label: _affordabilityText,
                          icon: Icons.attach_money,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

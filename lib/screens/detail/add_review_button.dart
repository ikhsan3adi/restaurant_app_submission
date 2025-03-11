import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/providers/detail/new_restaurant_review_provider.dart';
import 'package:restaurant_app/providers/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/widgets/review_dialog_widget.dart';

class AddReviewButton extends StatelessWidget {
  const AddReviewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, value, _) {
        final state = value.resultState;
        if (state is RestaurantDetailLoadedState) {
          return FloatingActionButton.extended(
            key: const ValueKey('add_review_button'),
            label: Text('Give a review'),
            icon: Icon(Icons.star),
            onPressed: () async {
              final status = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return ChangeNotifierProvider(
                    create: (context) => NewRestaurantReviewProvider(
                      context.read<ApiServices>(),
                    ),
                    child: ReviewDialogWidget(restaurantId: state.data.id),
                  );
                },
              );

              if (context.mounted && status == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Review successfully submitted'),
                  ),
                );

                context
                    .read<RestaurantDetailProvider>()
                    .fetchRestaurantDetail(state.data.id);
              }
            },
          );
        }
        return SizedBox();
      },
    );
  }
}

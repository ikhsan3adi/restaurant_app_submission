import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/detail/new_restaurant_review_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/screen/detail/review_dialog_widget.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class AddReviewButton extends StatelessWidget {
  const AddReviewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, value, _) {
        final state = value.resultState;
        if (state is RestaurantDetailLoadedState) {
          return FloatingActionButton.extended(
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
              }
            },
          );
        }
        return SizedBox();
      },
    );
  }
}

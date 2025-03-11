import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/new_restaurant_review.dart';
import 'package:restaurant_app/providers/detail/new_restaurant_review_provider.dart';
import 'package:restaurant_app/static/new_restaurant_review_result_state.dart';

class ReviewDialogWidget extends StatefulWidget {
  const ReviewDialogWidget({
    super.key,
    required this.restaurantId,
  });

  final String restaurantId;

  @override
  State<ReviewDialogWidget> createState() => _ReviewDialogWidgetState();
}

class _ReviewDialogWidgetState extends State<ReviewDialogWidget> {
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final provider = context.read<NewRestaurantReviewProvider>();
    provider.addListener(() {
      if (provider.resultState is NewRestaurantReviewSuccessState) {
        Navigator.pop(context, true);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: Text('Give a review'),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _formKey,
          child: Consumer<NewRestaurantReviewProvider>(
            builder: (context, value, _) => Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                switch (value.resultState) {
                  NewRestaurantReviewLoadingState() => Text(
                      'Submitting...',
                      style: textTheme.bodyMedium,
                    ),
                  NewRestaurantReviewErrorState(error: var message) => Text(
                      message,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                  _ => Text(
                      'Please fill in the following form to give a review',
                      style: textTheme.bodyMedium,
                    ),
                },
                TextFormField(
                  key: const ValueKey('review_name_field'),
                  autofocus: true,
                  controller: _nameController,
                  enabled:
                      value.resultState is! NewRestaurantReviewLoadingState,
                  maxLength: 64,
                  decoration: InputDecoration(
                    labelText: 'Your name',
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return 'Please enter your name with at least 3 characters';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  key: const ValueKey('review_review_field'),
                  controller: _reviewController,
                  minLines: 3,
                  maxLines: 5,
                  maxLength: 1000,
                  enabled:
                      value.resultState is! NewRestaurantReviewLoadingState,
                  decoration: InputDecoration(
                    labelText: 'Your review',
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.length < 10) {
                      return 'Please enter your review with at least 10 characters';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel'),
        ),
        Consumer<NewRestaurantReviewProvider>(
          builder: (context, value, _) => TextButton(
            key: const ValueKey('submit_review_button'),
            onPressed: switch (value.resultState) {
              NewRestaurantReviewLoadingState() => null,
              _ => () async {
                  if (_formKey.currentState?.validate() != true) return;

                  final newReview = NewRestaurantReview(
                    id: widget.restaurantId,
                    name: _nameController.text,
                    review: _reviewController.text,
                  );

                  await context
                      .read<NewRestaurantReviewProvider>()
                      .addNewRestaurantReview(newReview);
                },
            },
            child: Text(switch (value.resultState) {
              NewRestaurantReviewLoadingState() => 'Submitting...',
              _ => 'Submit',
            }),
          ),
        ),
      ],
    );
  }
}

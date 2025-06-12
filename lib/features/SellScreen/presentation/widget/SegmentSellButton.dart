import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/text_styles.dart';
import '../cubit/TestProduct.dart';

class Segmentsellbutton extends StatefulWidget {
  const Segmentsellbutton({super.key});

  @override
  State<Segmentsellbutton> createState() => _SegmentsellbuttonState();
}

class _SegmentsellbuttonState extends State<Segmentsellbutton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Testproduct, productState>(builder: (context, state) {
      return SegmentedButton<productState>(
        style: SegmentedButton.styleFrom(
            selectedBackgroundColor: ColorManager.SecondaryColor,
            selectedForegroundColor: ColorManager.PrimaryColor,
            foregroundColor: ColorManager.PrimaryColor,
            backgroundColor: ColorManager.greyColor),
        segments: [
          ButtonSegment(
            value: productState.Sell,
            label: Text(
              "Sell",
              style: state == productState.Sell
                  ? TextStyles.white14Bold
                  : TextStyles.black14Regular400,
            ),
          ),
          ButtonSegment(
            value: productState.Donate,
            label: Text(
              "Donate",
              style: state == productState.Donate
                  ? TextStyles.white14Bold
                  : TextStyles.black14Regular400,
            ),
          ),
        ],
        selected: {state},
        onSelectionChanged: (Set<productState> newSelection) {
          context.read<Testproduct>().changeState(newSelection.first);
        },
      );
    });
  }
}

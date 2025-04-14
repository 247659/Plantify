import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/loader_item/loader_item_widget.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'plant_card_loading_model.dart';
export 'plant_card_loading_model.dart';

class PlantCardLoadingWidget extends StatefulWidget {
  const PlantCardLoadingWidget({super.key});

  @override
  State<PlantCardLoadingWidget> createState() => _PlantCardLoadingWidgetState();
}

class _PlantCardLoadingWidgetState extends State<PlantCardLoadingWidget> {
  late PlantCardLoadingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlantCardLoadingModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final loaderItems = List.generate(random_data.randomInteger(0, 0),
                (index) => random_data.randomName(true, true))
            .toList()
            .take(4)
            .toList();

        return GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.79,
          ),
          scrollDirection: Axis.vertical,
          itemCount: loaderItems.length,
          itemBuilder: (context, loaderItemsIndex) {
            final loaderItemsItem = loaderItems[loaderItemsIndex];
            return LoaderItemWidget(
              key: Key('Key73a_${loaderItemsIndex}_of_${loaderItems.length}'),
            );
          },
        );
      },
    );
  }
}

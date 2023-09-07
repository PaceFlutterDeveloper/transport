import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:transport_app/utils/constants/db_constants.dart';

import '../../config/theme/color_constants.dart';
import '../../data/resource/local/trip_db.dart';
import '../../domain/models/trip_model.dart';

class InOutCountComponent extends StatelessWidget {
  const InOutCountComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<TripModel>(studTrip).listenable(),
        builder: (BuildContext context, Box value, Widget? child) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffededed),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "IN Count",
                          style: TextStyle(
                            color: ColorConstants.green,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "${TripDB.getCountOfEntryStat()}",
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffededed),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "OUT Count",
                          style: TextStyle(
                            color: ColorConstants.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "${TripDB.getCountOfExitStat()}",
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

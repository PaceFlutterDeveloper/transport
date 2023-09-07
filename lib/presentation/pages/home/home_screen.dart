import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/data/resource/local/trip_db.dart';
import 'package:transport_app/domain/models/trip_model.dart';
import 'package:transport_app/presentation/pages/markAttendance/mark_attendance_screen.dart';
import 'package:transport_app/utils/constants/db_constants.dart';

import '../../providers/nfc_provider.dart';
import '../../widgets/all_student_component.dart';
import '../../widgets/excep_in_out_component.dart';
import '../../widgets/in_out_component.dart';
import '../../widgets/stop_component.dart';
import '../../widgets/trip_component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: const Color.fromARGB(255, 24, 112, 156),
          ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ValueListenableBuilder(
                valueListenable: Hive.box<TripModel>(studTrip).listenable(),
                builder: (BuildContext context, Box value, Widget? child) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const StopComponent(),
                        heightBox(),
                        const AllStudentComponent(),
                        heightBox(),
                        const TripModeComponent(),

                        heightBox(),

                        const InOutCountComponent(),
                        heightBox(),

                        const ExcepInOutComponent(),
                        heightBox(),
                        const Text("Last Student"),
                        const SizedBox(
                          height: 5,
                        ),
                        TripDB.getLastUpdatedItem() != null
                            ? StudentTileAttendance(
                                tripModel: TripDB.getLastUpdatedItem()!)
                            : const Center(
                                child: Text("No student attendence marked"),
                              )

                        // GestureDetector(
                        //   onTap: () {
                        //     Provider.of<NfcProvider>(context, listen: false)
                        //         .listenForNFCEvents(context);
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => const MarkAttendanceScreen(),
                        //         ));
                        //   },
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width,
                        //     height: MediaQuery.of(context).size.height * 0.2,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       color: const Color(0xffededed),
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Text(
                        //                 "Mark Attendance",
                        //                 style:
                        //                     Theme.of(context).textTheme.titleLarge!.merge(
                        //                           const TextStyle(
                        //                             color: Colors.black,
                        //                             fontSize: 20,
                        //                             fontWeight: FontWeight.w500,
                        //                           ),
                        //                         ),
                        //               ),
                        //               const Text(
                        //                 "ID card to mark your attendance",
                        //                 style: TextStyle(
                        //                   color: Colors.black,
                        //                   fontSize: 16,
                        //                 ),
                        //               )
                        //             ],
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ]);
                })),
      ),
    );
  }

  heightBox() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.012,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    Future(() => Provider.of<NfcProvider>(context, listen: false)
        .listenForNFCEvents(context));
    super.initState();
  }
}

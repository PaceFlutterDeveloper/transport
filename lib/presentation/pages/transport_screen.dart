import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/data/resource/remote/data_state.dart';
import 'package:transport_app/presentation/providers/transportProvider.dart';
import 'package:transport_app/presentation/widgets/custom_drop_down.dart';

class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});

  @override
  State<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Consumer<TransportProvider>(
            builder: (context, value, child) {
              switch (value.getBusDataState.dataState) {
                case DataState.Uninitialized:
                case DataState.Loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case DataState.Loaded:
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/images/bus.png"),
                        Text(
                          "Select Bus",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownInput(
                          getLabel: (p0) => p0!.busNo.toString(),
                          options: value.transportModel.bus,
                          value: value.selectedBus,
                          onChanged: (p0) {
                            value.setBus(p0!);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Select Trip",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownInput(
                          getLabel: (p0) => p0!.tripName.toString(),
                          options: value.transportModel.trip,
                          value: value.selectedTrip,
                          onChanged: (p0) {
                            value.setTrip(p0!);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        value.selectedBus == null && value.selectedBus == null
                            ? const SizedBox()
                            : Center(
                                child: GestureDetector(
                                  onTap: () {
                                    value.startTrip(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30.0,
                                          right: 30.0,
                                          top: 18.0,
                                          bottom: 18.0),
                                      child: Text(
                                        "START",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .merge(const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  );
                case DataState.NoData:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case DataState.Error:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<TransportProvider>(context, listen: false);
      provider.getBuses();
    });
  }
}

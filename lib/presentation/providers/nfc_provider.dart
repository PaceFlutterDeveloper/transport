// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:transport_app/data/resource/local/student_db.dart';
import 'package:transport_app/data/resource/local/trip_db.dart';
import 'package:transport_app/domain/models/students_model.dart';
import 'package:transport_app/domain/models/trip_model.dart';
import 'package:transport_app/utils/extensions/show_loader.dart';
import 'package:transport_app/utils/extensions/toast.dart';

import '../../utils/extensions/current_date.dart';

String duplicate = "audio/duplicate.mp3";

String thankyou = "audio/thankyou.mp3";

int toDec(List<int> bytes) {
  int result = 0;
  int factor = 1;
  for (int i = 0; i < bytes.length; ++i) {
    int value = bytes[i] & 0xFF;
    result += value * factor;
    factor *= 256;
  }
  return result;
}

class NfcProvider with ChangeNotifier {
  NfcStates nfcStates = NfcStates.Unitialized;
  int readeadNfcData = 0;
  bool inOut = true;
  bool isNfcStatus = false;

  AudioPlayer audioPlayer = AudioPlayer();
  NfcProvider() {
    // listenForNFCEvents();
  }
  Future<void> listenForNFCEvents(BuildContext context) async {
    await Geolocator.checkPermission();
    log(
      'NFC listener running in background now, approach tag(s)',
    );
    //Always run this for ios but only once for android
    if (Platform.isAndroid || Platform.isIOS) {
      //Android supports reading nfc in the background, starting it one time is all we need
      if (Platform.isAndroid) {
        log(
          'NFC listener running in background now, approach tag(s)',
        );
        //Update button states
        // setState(() {
        //   listenerRunning = true;
        // });
      }

      await NfcManager.instance.startSession(
        alertMessage: 'Hold your NFC tag near the device.',

        onDiscovered: (NfcTag tag) async {
          // bool succses = false;
          //Try to convert the raw tag        data to NDEF
          if (inOut == null) {
            showToast("Select Trip Type");
          } else {
            showProgressDialog(context);
            final ndefTag = NdefFormatable.from(tag);

            //If the data could be converted we will get an object
            if (ndefTag != null) {
              log(ndefTag.identifier.toString());
              var identifier = ndefTag.identifier;

              //String s = String.fromCharCodes(identifier);

              log(identifier.toString());
              var result = hex.encode(identifier);
              log(result);

              final number = toDec(identifier);
              readeadNfcData = number;
              if (isNfcStatus) {
                log("nfc card number:  + $number");
                // Provider.of<StudentProvider>(context, listen: false)
                //     .cardNumber(number);
              } else {
                Position position = await Geolocator.getCurrentPosition();
                log("student Position");

                log("Position ${position.longitude}\n${position.latitude}");
                log(number.toString());
                Student? student =
                    StudentDb.getStudentByNfcTag(number.toString());

                TripModel tripModel = TripModel(
                    tripId: '1234',
                    id: 0,
                    name: student == null ? "" : student.studName,
                    nfcTag: number.toString(),
                    studCode: student == null ? "" : student.studCode,
                    entryTime: inOut ? currentDateTime() : "",
                    exitTime: !inOut ? currentDateTime() : "",
                    entryStat: inOut ? "1" : "0",
                    exitStat: !inOut ? "1" : "0",
                    entryLat: inOut ? position.latitude : 0,
                    entryLong: inOut ? position.longitude : 0,
                    exitLat: !inOut ? position.latitude : 0,
                    exitLong: !inOut ? position.longitude : 0,
                    lastUpdated: DateTime.now());

                int result = TripDB.addTrip(tripModel);

                if (result == 2) {
                  playAudio(duplicate, "Duplicate Attendance marked", context)
                      .then((value) => Navigator.pop(context));
                } else if (result == 1) {
                  playAudio(thankyou, "Attendance marked", context)
                      .then((value) => Navigator.pop(context));
                } else if (result == 3) {
                  playAudio(thankyou, "Attendance Updated", context)
                      .then((value) => Navigator.pop(context));
                }
                //  Navigator.pop(context);
              }

              notifyListeners();
              log(number.toString());
            }
            //Due to the way ios handles nfc we need to stop after each tag
            if (Platform.isIOS) {
              NfcManager.instance.stopSession();
            }
          }
        },
        // Required for iOS to define what type of tags should be noticed
        pollingOptions: {
          NfcPollingOption.iso14443,
          NfcPollingOption.iso15693,
        },
      );
    }
    nfcStates = NfcStates.NfcListenable;
    notifyListeners();
  }

  nfcStatesUpdate(bool v) async {
    isNfcStatus = v;
    notifyListeners();
  }

  Future<void> playAudio(String path, String message, context) async {
    await audioPlayer.play(AssetSource(path));
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        // Navigator.pop(context);
      }
    });
  }

  setInOut(bool v) {
    inOut = v;
    notifyListeners();
  }

  stop() async {
    await NfcManager.instance.stopSession();
  }
}

enum NfcStates {
  Unitialized,
  NfcListenable,
}

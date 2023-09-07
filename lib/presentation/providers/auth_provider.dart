import 'package:flutter/material.dart';

import '../../data/resource/local/local_db.dart';
import '../../data/resource/remote/api_service.dart';
import '../../data/resource/remote/data_state.dart';
import '../../data/resource/remote/dependancy_injection.dart';
import '../../domain/repository/repository.dart';

class AUthProvider with ChangeNotifier {
  final Repository _repository = locator<Repository>();
  ResDataState autState = ResDataState(dataState: DataState.Uninitialized);
  login({required String userName, required String password}) async {
    autState = ResDataState(dataState: DataState.Loading);
    var res = await _repository.login(username: userName, password: password);
    if (res.isLeft) {
      ErrorType errorType = res.left;
      autState = ResDataState(
          dataState: DataState.Error, message: errorType.toString());
    } else {
      if (res.right == null) {
        autState = ResDataState(dataState: DataState.NoData);
      } else {
        addTripId("logged", "true");
        // _transportModel = TransportModel.fromJson(jsonDecode(res.right));
        autState = ResDataState(dataState: DataState.Loaded);
      }
      notifyListeners();
    }
  }
}

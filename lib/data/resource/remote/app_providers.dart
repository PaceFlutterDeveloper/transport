import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:transport_app/presentation/providers/auth_provider.dart';
import 'package:transport_app/presentation/providers/transportProvider.dart';

import '../../../presentation/providers/nfc_provider.dart';

List<SingleChildWidget> allProviders() {
  return [
    ChangeNotifierProvider(
      create: (context) => TransportProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => NfcProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AUthProvider(),
    ),
  ];
}

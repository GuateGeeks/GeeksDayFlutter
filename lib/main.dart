import 'package:geeksday/app.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/services/implementation/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authCubit = AuthCubit(AuthService());

  runApp(
    BlocProvider(
      create: (_) => authCubit..init(),
      child: MyApp.create(),
    ),
  );
}
// import 'package:flutter/material.dart';
// import 'package:percent_indicator/percent_indicator.dart';

// void main() {
//   runApp(MaterialApp(home: Scaffold(body: SamplePage())));
// }

// class SamplePage extends StatefulWidget {
//   @override
//   _SamplePageState createState() => _SamplePageState();
// }

// class _SamplePageState extends State<SamplePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         title: new Text("Linear Percent Indicators"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 60.0),
//               child: new LinearPercentIndicator(
//                 width: MediaQuery.of(context).size.width - 50,
//                 animation: true,
//                 lineHeight: 30.0,
//                 animationDuration: 2500,
//                 percent: 0.98,
//                 center: Text("80.0%"),
//                 linearStrokeCap: LinearStrokeCap.roundAll,
//                 progressColor: Colors.green,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

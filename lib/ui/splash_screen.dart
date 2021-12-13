import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SplashScreen extends StatelessWidget {
  static Widget create(BuildContext context) => SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('Estamos preparando todo', 
                style: TextStyle(fontSize: 18),
              ),
            ),
            JumpingDotsProgressIndicator(
              fontSize: 30.0,
              color: Theme.of(context).primaryColor,
            ),
            
          ],
        ),
      ),
    );
  }
}

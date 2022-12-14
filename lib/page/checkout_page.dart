import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../payment/rapyd.dart';
import '../widgets/back_button.dart';

class CheckOutScreen extends StatefulWidget {
  final Rapyd rapyd;

  const CheckOutScreen({
    Key? key,
    required this.rapyd,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CheckOutScreenState();
  }
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late Future<Map> createdCheckoutPage;
  @override
  void initState() {
    super.initState();
    createdCheckoutPage = widget.rapyd.createCheckoutPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: CustomBackButton(),
          title: const Align(
            child: Text("Checkout",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          backgroundColor: Colors.white,
          actions: const [
            SizedBox(
              width: 55,
            ),
          ],
          elevation: 0,
        ),
        body: FutureBuilder(
          future: createdCheckoutPage,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return const Center(child: Text('Some error occurred!'));
                } else {
                  return WebView(
                    initialUrl: snapshot.data["redirect_url"].toString(),
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageStarted: (url) {
                      
                      if (url
                          .contains(snapshot.data["complete_checkout_url"])) {
                        Navigator.pop(context);
                      } else if (url
                          .contains(snapshot.data["cancel_checkout_url"])) {
                        Navigator.pop(context);
                      }
                    },
                  );
                }
            }
          },
        ));
  }
}
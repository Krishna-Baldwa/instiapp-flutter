// import 'dart:convert';
// import 'dart:developer';
// import 'dart:ffi';

import 'package:InstiApp/src/bloc_provider.dart';
import 'package:InstiApp/src/drawer.dart';
import 'package:InstiApp/src/utils/common_widgets.dart';
import 'package:InstiApp/src/utils/title_with_backbutton.dart';
import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'qr_encryption.dart';
import '../api/model/user.dart';
import 'package:flutter/services.dart';



class QRPage extends StatefulWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String? qrString ="";
  bool first = true;
  bool loading = true;
  bool error = false;
 User? profile;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

  }
@override
dispose(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  super.dispose();
}
  void getQRString(bloc) async {

    final qr_encryption= QREncryption(profile!);
    String qr = (qr_encryption.Encrypt()).toString();
    if (qr == "Error") {
      setState(() {
        error = true;
        loading = false;
      });
    } else {
      setState(() {
        qrString = (qr_encryption.Encrypt()).toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var bloc = BlocProvider.of(context)!.bloc;
    profile= bloc.currSession?.profile;
    if (first && bloc.currSession != null) {
      getQRString(bloc);
      first = false;
    }

    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: MyBottomAppBar(
        shape: RoundedNotchedRectangle(),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              tooltip: "Show bottom sheet",
              icon: Icon(
                Icons.menu_outlined,
                semanticLabel: "Show bottom sheet",
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ],
        ),
      ),
      drawer: NavDrawer(),
      body: SafeArea(
        child: bloc.currSession == null
            ? Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(50),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud,
                      size: 200,
                      color: Colors.grey[600],
                    ),
                    Text(
                      "Login To View QR",
                      style: theme.textTheme.headline5,
                      textAlign: TextAlign.center,
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              )
            : ListView(
                children: [
                  TitleWithBackButton(
                    child: Text(
                      "QR Code",
                      style: theme.textTheme.headline3,
                    ),
                  ),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : error
                          ? Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(50),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.cloud,
                                    size: 200,
                                    color: Colors.grey[600],
                                  ),
                                  Text(
                                    "Some error in generating QR",
                                    style: theme.textTheme.headline5,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              margin: EdgeInsets.all(50),
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height / 2,

                              child: QrImage(

                                // data: '',
                                data: '${qrString}',
                                size: MediaQuery.of(context).size.width / 2,
                                foregroundColor: Colors.black,
                                embeddedImage:  AssetImage('assets/buynsell/DevcomLogo.png'),
                                // embeddedImageStyle: QrEmbeddedImageStyle(size: Size(90,90) ),

                              ),
                            ),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: (bloc.currSession?.profile != null)
          ? FloatingActionButton.extended(
              icon: Icon(Icons.calendar_month),
              label: Text("Mess Calendar"),
              onPressed: () {
                Navigator.of(context).pushNamed("/messcalendar");
              },
            )
          : null,
    );
  }

}

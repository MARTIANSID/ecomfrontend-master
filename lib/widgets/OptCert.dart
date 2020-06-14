import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/options.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:provider/provider.dart';

class OptCert extends StatefulWidget {
  final int cert;
  final bool isCart;
  final Function sett;
  OptCert(this.cert,this.isCart,this.sett);
  @override
  _OptCertState createState() => _OptCertState();
}

class _OptCertState extends State<OptCert> {
  int cert;
  @override
  void initState(){
    cert=widget.cert;

    super.initState();
  }
  Future<void> setData(index)async{
        if (index == 0) {
                      await Provider.of<Options>(context, listen: false)
                          .setCert(cert: 0);
                    }
                    if (index == 1) {
                      await Provider.of<Options>(context, listen: false)
                         .setCert(cert: 1);
                    }
                    if (index == 2) {
                      await Provider.of<Options>(context, listen: false)
                         .setCert(cert: 2);
                    }
                    await Provider.of<Options>(context, listen: false)
            .getStringValuesSF();
  }
  @override
  Widget build(BuildContext context) {

    Map<int, Widget> certItems = {
      0: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text('IGI'),
      ),
      1: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text('GSI'),
      ),
      2: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text('NONE'),
      ),
    };
    return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.grey,
              //     borderRadius: BorderRadius.circular(10.0),
              //   ),
              //   height: size.height * 0.012,
              //   width: size.width * 0.2,
              //   margin: EdgeInsets.only(bottom: 30.0),
              // ),
              // Text(
              //   'Select Filter Options',
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontFamily: 'Gilroy Black',
              //     fontSize: 25.0,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: MaterialSegmentedControl(
                  children: certItems,
                  selectionIndex:cert ,
                  borderColor: Colors.black,
                  selectedColor: kPrimaryColor,
                  unselectedColor: Colors.white,
                  borderRadius: 20.0,
                  onSegmentChosen: (index) async {
                    if(!widget.isCart){
                    await setData(index);
                    }
                    else{
                      widget.sett(index);
                    }
                   
                
                     setState(() {
                      cert = index;
                    });
                  },
                  
                ),
              ),
            ],
          );
  }
}
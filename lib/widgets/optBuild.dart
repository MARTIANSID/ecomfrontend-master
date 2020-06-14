import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/options.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:provider/provider.dart';

class Opt1 extends StatefulWidget {
  final int buildd;
  final bool isCart;
  final Function sett;
  Opt1(this.buildd,this.isCart,this.sett);
  @override
  _Opt1State createState() => _Opt1State();
}

class _Opt1State extends State<Opt1> {
  int buildd;
  bool isInit = false;

  bool isLoading = false;

  void initState() {
    super.initState();
    buildd = widget.buildd;
  }

  Future<void> getValues(index) async {
    if (index == 0) {
      await Provider.of<Options>(context, listen: false).setBuild(build: 0);
    }
    if (index == 1) {
      await Provider.of<Options>(context, listen: false).setBuild(build: 1);
    }
    await Provider.of<Options>(context, listen: false).getStringValuesSF();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Widget> buildItems = {
      0: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text('TAAR'),
      ),
      1: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text('SCREW'),
      ),
    };

    var size = MediaQuery.of(context).size;
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
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
                  children: buildItems,
                  selectionIndex: buildd,
                  borderColor: Colors.black,
                  selectedColor: kPrimaryColor,
                  unselectedColor: Colors.white,
                  borderRadius: 20.0,
                  onSegmentChosen: (index) async {
                    if(!widget.isCart){
                    await getValues(index);
                    }
                    else{
                    widget.sett(index);
                    }
                    setState(() {
                      buildd = index;
                    });
                  },
                ),
              ),
            ],
          );
  }
}

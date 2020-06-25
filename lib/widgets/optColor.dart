import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/options.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:provider/provider.dart';

class OptColor extends StatefulWidget {
  final int color;
  final bool isCart;
  final Function sett;
  OptColor(this.color,this.isCart,this.sett);
  @override
  _OptColorState createState() => _OptColorState();
}

class _OptColorState extends State<OptColor> {
  bool isLoading = false;
  bool isInit = true;
  int color;

  @override

  // void didChangeDependencies() async {
  //   if (isInit) {

  //     if (Provider.of<Options>(context, listen: false).color != null) {
  //       color = Provider.of<Options>(context, listen: false).color;
  //     }
  //     color=Provider.of<Options>(context, listen: true).color;

  //     isInit = false;
  //   }

  //   super.didChangeDependencies();
  // }
  @override
  void initState() {
    color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Widget> colorItems = {
      0: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text('YELLOW'),
      ),
      1: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text('WHITE'),
      ),
      2: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text('ROSE'),
      ),
    };
    Future<void> setData(index) async {
      if (index == 0) {
        await Provider.of<Options>(context, listen: false).setColor(color: 0);
      }
      if (index == 1) {
        await Provider.of<Options>(context, listen: false).setColor(color: 1);
      }
      if (index == 2) {
        await Provider.of<Options>(context, listen: false).setColor(color: 2);
      }
      await await Provider.of<Options>(context, listen: false)
          .getStringValuesSF();
    }

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
                  children: colorItems,
                  selectionIndex: color,
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
                      color = index;
                    });
                  },
                ),
              ),
            ],
          );
  }
}

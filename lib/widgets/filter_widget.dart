import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:provider/provider.dart';

class FilterForProduct extends StatefulWidget {
  @override
  _FilterForProductState createState() => _FilterForProductState();
}

class _FilterForProductState extends State<FilterForProduct> {
  Map<int, Widget> _childrenItem = {
    0: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text('Diamond Count'),
    ),
    1: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text('Diamond Weight'),
    ),
    2: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text('Gold Weight'),
    ),
  };
  Map<int, Widget> _childrenHighLow = {
    0: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text('Low to High'),
    ),
    1: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Text('High to Low'),
    ),
  };

  int count;
  int order;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    int sort;
    Future<void> sortIt(count, index) async {
      if (index == 1) sort = -1;
      if (index == 0) sort = 1;

      if (count == 0) {
        setState(() {
          isLoading = true;
        });

        await Provider.of<Pagination>(context, listen: false).getProducts(
            page: 1,
            addition: false,
            select: 'all',
            context: context,
            sortby: 'diamondCount',
            sort: sort);

        await Provider.of<Pagination>(context, listen: false).getProducts(
            page: 1,
            addition: false,
            select: 'featured',
            context: context,
            sort: sort,
            sortby: 'diamondCount');
        await Provider.of<Pagination>(context, listen: false).getProducts(
            page: 1,
            addition: false,
            select: 'new',
            context: context,
            sort: sort,
            sortby: 'diamondCount');
        await Provider.of<Pagination>(context, listen: false).getProducts(
            page: 1,
            addition: false,
            select: 'highestSelling',
            context: context,
            sort: sort,
            sortby: 'diamondCount');
        await Provider.of<Pagination>(context, listen: false).getProducts(
            addition: false,
            page: 1,
            context: context,
            select: 'fancyDiamond',
            sort: sort,
            sortby: 'diamondCount');
        Provider.of<Pagination>(context, listen: false).pageStart();
        Provider.of<Pagination>(context, listen: false).setSort(sort);
        Provider.of<Pagination>(context, listen: false)
            .setCount('diamondCount');
      }

      if (count == 1) {
        setState(() {
          isLoading = true;
        });

        await Provider.of<Pagination>(context, listen: false).getProducts(
            page: 1,
            addition: false,
            select: 'all',
            context: context,
            sortby: 'diamondWeight',
            sort: sort);
        await Provider.of<Pagination>(context, listen: false).getProducts(
            page: 1,
            addition: false,
            select: 'featured',
            context: context,
            sortby: 'diamondWeight',
            sort: sort);
        await Provider.of<Pagination>(context, listen: false).getProducts(
            page: 1,
            addition: false,
            select: 'new',
            context: context,
            sortby: 'diamondWeight',
            sort: sort);
        await Provider.of<Pagination>(context, listen: false).getProducts(
            page: 1,
            addition: false,
            select: 'highestSelling',
            context: context,
            sortby: 'diamondWeight',
            sort: sort);
        await Provider.of<Pagination>(context, listen: false).getProducts(
            addition: false,
            page: 1,
            context: context,
            select: 'fancyDiamond',
            sortby: 'diamondWeight',
            sort: sort);
        Provider.of<Pagination>(context, listen: false).pageStart();
        Provider.of<Pagination>(context, listen: false).setSort(sort);
        Provider.of<Pagination>(context, listen: false)
            .setCount('diamondWeight');
      }
      if (count == 2) {
        setState(() {
          isLoading = true;
        });

        await Provider.of<Pagination>(context, listen: false).getProducts(
            page: 1,
            addition: false,
            select: 'all',
            context: context,
            sort: sort,
            sortby: 'goldWeight');
        await Provider.of<Pagination>(context, listen: false).getProducts(
            page: 1,
            addition: false,
            select: 'featured',
            context: context,
            sort: sort,
            sortby: 'goldWeight');
        await Provider.of<Pagination>(context, listen: false).getProducts(
            page: 1,
            addition: false,
            select: 'new',
            context: context,
            sort: sort,
            sortby: 'goldWeight');
        await Provider.of<Pagination>(context, listen: false).getProducts(
            page: 1,
            addition: false,
            select: 'highestSelling',
            context: context,
            sort: sort,
            sortby: 'goldWeight');

        await Provider.of<Pagination>(context, listen: false).getProducts(
            addition: false,
            page: 1,
            context: context,
            select: 'fancyDiamond',
            sort: sort,
            sortby: 'goldWeight');
        Provider.of<Pagination>(context, listen: false).pageStart();
        Provider.of<Pagination>(context, listen: false).setSort(sort);
        Provider.of<Pagination>(context, listen: false).setCount('goldWeight');
      }
    }

    var size = MediaQuery.of(context).size;
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: size.height * 0.012,
                width: size.width * 0.2,
                margin: EdgeInsets.only(bottom: 30.0),
              ),
              Text(
                'Select Filter Options',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Gilroy Black',
                  fontSize: 25.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: MaterialSegmentedControl(
                  children: _childrenItem,
                  selectionIndex: count,
                  borderColor: Colors.black,
                  selectedColor: kPrimaryColor,
                  unselectedColor: Colors.white,
                  borderRadius: 32.0,
                  onSegmentChosen: (index) {
                    setState(() {
                      count = index;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                child: Divider(
                  color: Colors.black,
                  height: 3.0,
                ),
              ),
              MaterialSegmentedControl(
                children: _childrenHighLow,
                selectionIndex: order,
                borderColor: Colors.black,
                selectedColor: kPrimaryColor,
                unselectedColor: Colors.white,
                borderRadius: 32.0,
                onSegmentChosen: (index) async {
                  setState(() {
                    order = index;
                  });
                },
              ),
              Expanded(
                  child: FlatButton(
                child: Text('Done'),
                onPressed: () async {
                 
                  await sortIt(count, order);
                  Navigator.pop(context);
                },
              ))
            ],
          );
  }
}

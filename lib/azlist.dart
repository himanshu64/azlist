library alistz;

import 'package:flutter/material.dart';

// class Alistz
class Azlist extends StatefulWidget {
  final List<String> listData;
  final bool isSearch;
  final Function onTap;

  Azlist({Key key, @required this.listData, this.isSearch = true, this.onTap})
      : super(key: key);
  @override
  _AzlistState createState() => _AzlistState();
}

class _AzlistState extends State<Azlist> {
  TextEditingController searchController = TextEditingController();

  List<String> listDataforDisplay = List<String>();

  String letter = '';
  List<String> searchList = List<String>();
  int index;

  @override
  void initState() {
    // TODO: implement initState
    searchList.addAll(widget.listData);
    listDataforDisplay.addAll(searchList);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  void _filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(searchList);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        listDataforDisplay.clear();
        listDataforDisplay.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        listDataforDisplay.clear();
        listDataforDisplay.addAll(searchList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isSearch
            ? Container(
                // padding: spacer.bottom.xs,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50.0,
                    child: TextField(
                      onChanged: (value) {
                        _filterSearchResults(value.toLowerCase());
                      },
                      controller: searchController,
                      style: Theme.of(context).textTheme.bodyText2,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        labelText: "Search",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.grey, fontSize: 16),
                        counterStyle: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: listDataforDisplay.length,
                itemBuilder: (BuildContext context, int i) {
                  // String letter = listDataforDisplay[i].substring(0, 1);

                  // return ListTile(
                  //   title: Text(listDataforDisplay[i]),
                  // );
                  return _listitems(listDataforDisplay, i);
                }),
          ),
        )
      ],
    );
  }

  Widget _listitems(List<String> list, int i) {
    if (letter.isEmpty) {
      letter = list[i][0];
      index = i;
    } else if (letter != list[i][0]) {
      letter = list[i][0];
      index = i;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        index != i
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                child: Text(letter,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ),
        Material(
          elevation: 0,
          color: Colors.white,
          child: InkWell(
            onTap: widget.onTap != null
                ? () {
                    widget.onTap(list[i]);
                  }
                : null,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  left: 20.0, top: 10.0, bottom: 10.0, right: 20.0),
              child: Text(
                list[i],
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        )
      ],
    );
  }
}

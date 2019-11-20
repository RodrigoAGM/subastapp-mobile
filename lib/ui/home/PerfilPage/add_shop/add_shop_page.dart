import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:subastapp/model/market.dart';
import 'package:subastapp/network/market_api.dart';
import 'package:subastapp/network/store_api.dart';
import 'package:subastapp/ui/animation/FadeAnimation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:subastapp/ui/login/login_screen.dart';

const double paddingValue = 16.0;

class AddShopPage extends StatefulWidget {
  @override
  _AddShopPageState createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  final _nameController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _storeNumberController = TextEditingController();
  final _phoneController = TextEditingController();
  final _openController = TextEditingController();
  final _closeController = TextEditingController();
  final _nameFocus = FocusNode();
  final _contactNameFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _storeNumberFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _openFocus = FocusNode();
  final _closeFocus = FocusNode();
  final format = DateFormat("hh:mm a");
  final _storeApi = new StoreApi();
  final _marketApi = new MarketApi();
  List<DropdownMenuItem>list = [];
  var dropDownItemsMap;
  var _selectedItem =0;
  var selectedMarket;

  Future<List<Market>> function() async {
    var list = await _marketApi.getAll();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar tienda'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeAnimation(
                    1.2,
                    Text(
                      "Add Store",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 10,
                ),
                FadeAnimation(
                    1.5,
                    Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextFormField(
                              controller: _nameController,
                              focusNode: _nameFocus,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                _fieldFocusChange(
                                    context, _nameFocus, _contactNameFocus);
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8)),
                                  hintText: "Name"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextFormField(
                              controller: _contactNameController,
                              focusNode: _contactNameFocus,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                _fieldFocusChange(
                                    context, _contactNameFocus, _descriptionFocus);
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8)),
                                  hintText: "Contact name"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextFormField(
                              controller: _descriptionController,
                              focusNode: _descriptionFocus,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                _fieldFocusChange(
                                    context, _descriptionFocus, _storeNumberFocus);
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8)),
                                  hintText: "Description"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextFormField(
                              controller: _storeNumberController,
                              focusNode: _storeNumberFocus,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.none,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                _fieldFocusChange(
                                    context, _storeNumberFocus, _phoneFocus);
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8)),
                                  hintText: "Store number"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextFormField(
                              controller: _phoneController,
                              focusNode: _phoneFocus,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                _fieldFocusChange(
                                    context, _phoneFocus, _openFocus);
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8)),
                                  hintText: "Phone"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: DateTimeField(
                              controller: _openController,
                              focusNode: _openFocus,
                              format: format,
                              onFieldSubmitted: (value) {
                                _fieldFocusChange(
                                    context, _openFocus, _closeFocus);
                              },
                              onShowPicker: (context, currentValue) async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                return DateTimeField.convert(time);
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8)),
                                  hintText: "Opens at"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: DateTimeField(
                              controller: _closeController,
                              focusNode: _closeFocus,
                              format: format,
                              onShowPicker: (context, currentValue) async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                return DateTimeField.convert(time);
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8)),
                                  hintText: "Closes at"),
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: FutureBuilder<List<Market>>(
                              future: function(),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {

                                if (snapshot.hasError) {
                                  return Container();

                                } else if (snapshot.hasData) {
                                  list.clear();
                                  dropDownItemsMap = new Map();

                                  list.add(new DropdownMenuItem(
                                        child: new Container( 
                                          child: Text("Choose market")),
                                        value: 0));
                                  dropDownItemsMap[0] = new Market(name: "Choose market...", id: "0");
                                  snapshot.data.forEach((branchItem) {
                                    //listItemNames.add(branchItem.itemName);
                                    int index = snapshot.data.indexOf(branchItem)+1;
                                    dropDownItemsMap[index] = branchItem;

                                    list.add(new DropdownMenuItem(
                                        child: new Container( 
                                          child: Text(dropDownItemsMap[index].name)),
                                        value: index));
                                  });

                                    return DropdownButtonFormField(
                                      items:list,
                                      onChanged: (value){

                                        _selectedItem = int.parse(value.toString());
                                        selectedMarket = dropDownItemsMap[_selectedItem].id;
                                        setState(() {
                                          
                                        });
                                      },
                                      hint: Text(dropDownItemsMap[_selectedItem].name),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        ),
                                    );

                                  
                                }

                                return CircularProgressIndicator();
                              },
                            ),
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: 15.0,
                ),
                FadeAnimation(
                    1.8,
                    Center(
                        child: Column(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () async {
                            var name = _nameController.text;
                            var description = _descriptionController.text;
                            var storeNumber = _storeNumberController.text;
                            var phone = _phoneController.text;
                            var open = _openController.text;
                            var close = _closeController.text;
                            var contactName = _contactNameController.text;

                            if (name.isNotEmpty &&
                                description.isNotEmpty &&
                                storeNumber.isNotEmpty &&
                                phone.isNotEmpty &&
                                open.isNotEmpty &&
                                close.isNotEmpty && selectedMarket != "0" && contactName.isNotEmpty) {
                                  debugPrint(selectedMarket);
                              var res = await _storeApi.register(
                                  name, description, storeNumber, phone, open, close, selectedMarket, contactName);
                              if (res == "success") {
                                _toastMessage("Completed", Colors.green.withOpacity(.6));
                                Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: LoginPage()));
                              } else {
                                _toastMessage(
                                    "You must complete all the fields", Colors.red.withOpacity(.6));
                              }
                            } else {
                              _toastMessage("You must complete all the fields", Colors.red.withOpacity(.6));
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50),
                          ),
                          color: Colors.blue[900],
                          child: Container(
                            width: 120,
                            padding: EdgeInsets.all(15),
                            child: Center(
                                child: Text(
                              "Create",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.8)),
                            )),
                          ),
                        ),
                      ],
                    ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

_toastMessage(String message, Color color) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 12.0);
}

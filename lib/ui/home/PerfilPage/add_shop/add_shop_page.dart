import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:subastapp/ui/animation/FadeAnimation.dart';
import 'package:fluttertoast/fluttertoast.dart';

const double paddingValue = 16.0;

class AddShopPage extends StatefulWidget {
  @override
  _AddShopPageState createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _openController = TextEditingController();
  final _closeController = TextEditingController();
  final _nameFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _openFocus = FocusNode();
  final _closeFocus = FocusNode();
  final format = DateFormat("hh:mm a");

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
                                    bottom: BorderSide(color: Colors.grey[300]))),
                            child: TextFormField(
                              controller: _nameController,
                              focusNode: _nameFocus,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                _fieldFocusChange(context, _nameFocus, _descriptionFocus);
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                      TextStyle(color: Colors.grey.withOpacity(.8)),
                                  hintText: "Name"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey[300]))),
                            child: TextFormField(
                              controller: _descriptionController,
                              focusNode: _descriptionFocus,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value){
                                _fieldFocusChange(context, _descriptionFocus, _emailFocus);
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                      TextStyle(color: Colors.grey.withOpacity(.8)),
                                  hintText: "Description"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey[300]))),
                            child: TextFormField(
                              controller: _emailController,
                              focusNode: _emailFocus,
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                _fieldFocusChange(context, _emailFocus, _phoneFocus);                                
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                      TextStyle(color: Colors.grey.withOpacity(.8)),
                                  hintText: "Email"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey[300]))),
                            child: TextFormField(
                              controller: _phoneController,
                              focusNode: _phoneFocus,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                _fieldFocusChange(context, _phoneFocus, _openFocus);
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                      TextStyle(color: Colors.grey.withOpacity(.8)),
                                  hintText: "Phone"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey[300]))),
                            child: DateTimeField(
                              controller: _openController,
                              focusNode: _openFocus,
                              format: format,
                              onFieldSubmitted: (value){
                                _fieldFocusChange(context, _openFocus, _closeFocus);
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
                                  hintStyle:
                                      TextStyle(color: Colors.grey.withOpacity(.8)),
                                  hintText: "Opens at"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey[300]))),
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
                                  hintStyle:
                                      TextStyle(color: Colors.grey.withOpacity(.8)),
                                  hintText: "Closes at"),
                            ),
                          ),
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
                          onPressed: () {
                            var name = _nameController.text;
                            var description = _descriptionController.text;
                            var email = _emailController.text;
                            var phone = _phoneController.text;
                            var open = _openController.text;
                            var close = _closeController.text;

                            if (name.isNotEmpty && description.isNotEmpty && email.isNotEmpty && phone.isNotEmpty && open.isNotEmpty && close.isNotEmpty){
                              
                            }else{
                              _toastMessage("You must complete all the fields");
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
                              style: TextStyle(color: Colors.white.withOpacity(.8)),
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

_fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);  
}

_toastMessage(String message){

  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.red.withOpacity(.6),
      textColor: Colors.white,
      fontSize: 12.0
  );
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

const double paddingValue = 16.0;

class AddShopPage extends StatefulWidget {
  @override
  _AddShopPageState createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar tienda'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(paddingValue),
            child: TextField(),
          ),
          Padding(
            padding: const EdgeInsets.all(paddingValue),
            child: TextField(),
          ),
          Padding(
            padding: const EdgeInsets.all(paddingValue),
            child: BasicTimeField(
              title: 'Hora de apertura',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(paddingValue),
            child: BasicTimeField(
              title: 'Hora de cierre',
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> print('holi'),
        child: Icon(Icons.add),
      ),
    );
  }
}

class BasicTimeField extends StatelessWidget {
  final String title;

  const BasicTimeField({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("hh:mm a");
    return Column(children: <Widget>[
      Text(title),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

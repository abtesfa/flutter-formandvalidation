import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'application form',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? _name;
  String? _email;
  String? _phone;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('input Form')),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: FormWidget(),
        ),
      ),
    );
  }

  Widget FormWidget() {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(labelText: 'Name'),
          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (String? val) {
            _name = val;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'email'),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onSaved: (String? val) {
            _email = val;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Phone'),
          keyboardType: TextInputType.phone,
          validator: validatePhone,
          onSaved: (String? val) {
            _phone = val;
          },
        ),
        SizedBox(height: 10.0),
        ElevatedButton(
          child: Text('press me'),
          onPressed: _validateInput,
        )
      ],
    );
  }

  void _validateInput() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  String? validateName(String? value) {
    if (value == null || value.length < 3) {
      return 'name must be more than 2 character';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || !value.contains('@')) {
      return 'please enter a valid email address';
    } else {
      return null;
    }
  }

  String? validatePhone(String? value) {
    if (value == null || value.length < 10) {
      return 'please enter a valid phone number';
    } else {
      return null;
    }
  }
}
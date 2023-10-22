import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ais_register/bloc/auth_bloc.dart';
import 'package:flutter_ais_register/bloc/auth_event.dart';
import 'package:flutter_ais_register/bloc/auth_state.dart';
import 'package:flutter_ais_register/generated/codegen_loader.g.dart';
import 'package:flutter_ais_register/generated/locale_keys.g.dart';
import 'package:flutter_ais_register/regispage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('kk'), Locale('en'), Locale('ru')],
      path: 'assets/translation',
      fallbackLocale: Locale('ru'),
      assetLoader: CodegenLoader(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(),
      home: BlocProvider(
        create: (context) => RegistrationBloc(),
        child: MyRegistarion(),
      ),
    );
  }
}

class MyRegistarion extends StatefulWidget {
  const MyRegistarion({Key? key}) : super(key: key);

  @override
  _Textfield createState() => _Textfield();
}

class _Textfield extends State<MyRegistarion> {
  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _bioController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final List<String> _countries = ['USA', 'Canada', 'UK', 'Australia'];
  String _selectedCountry = 'USA';

  @override
  Widget build(BuildContext context) {
    final registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Регистрационная страничка'),
        centerTitle: true,
      ),
      body: BlocListener<RegistrationBloc, RegistrationState>(
        bloc: registrationBloc,
        listener: (context, state) {
          if (state is RegistrationSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RegisPage(
                  username: _usernameController.text,
                  email: _emailController.text,
                  phoneNumber: _phoneNumberController.text,
                  country: _selectedCountry,
                  bio: _bioController.text,
                ),
              ),
            );
          } else if (state is RegistrationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.choosename.tr(),
                  hintText: LocaleKeys.choosename.tr(),
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                validator: validateUsername,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.chooseemail.tr(),
                  hintText: LocaleKeys.chooseemail.tr(),
                  prefixIcon: Icon(Icons.mail),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: LocaleKeys.choosenumber.tr(),
                  hintText: LocaleKeys.choosenumber.tr(),
                  prefixIcon: Icon(Icons.call),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.map),
                  labelText: LocaleKeys.choosecountry.tr(),
                ),
                items: _countries.map((country) {
                  return DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (country) {
                  setState(() {
                    _selectedCountry = country as String;
                  });
                },
                value: _selectedCountry,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(
                  labelText: 'Bio',
                  hintText: LocaleKeys.choosebio.tr(),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: _hidePass,
                maxLength: 8,
                decoration: InputDecoration(
                  labelText: 'Password *',
                  hintText: LocaleKeys.chooseparol.tr(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _hidePass ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                  ),
                  icon: Icon(Icons.security),
                ),
                validator: validatePassword,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _hidePass,
                maxLength: 8,
                decoration: InputDecoration(
                  labelText: 'Confirm Password *',
                  hintText: LocaleKeys.povtorenie.tr(),
                  icon: Icon(Icons.border_color),
                ),
                validator: validatePassword,
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  textStyle: TextStyle(color: Colors.white),
                ),
                child: Text(LocaleKeys.Registration.tr()),
              ),
              ElevatedButton(
                onPressed: () async {
                  await context.setLocale(Locale('kk'));
                },
                child: const Text('KZ'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await context.setLocale(Locale('en'));
                },
                child: const Text('EN'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await context.setLocale(Locale('ru'));
                },
                child: const Text('RU'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late RegistrationBloc registrationBloc; // Определите ее на уровне класса

  @override
  void initState() {
    super.initState();
    registrationBloc = BlocProvider.of<RegistrationBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    registrationBloc.close(); // Закрыть блок в методе dispose
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final userName = _usernameController.text;
      final userEmail = _emailController.text;
      final userPhone = _phoneNumberController.text;
      final userCountry = _selectedCountry;
      final userBio = _bioController.text;
      final userPassword = _passwordController.text;

      BlocProvider.of<RegistrationBloc>(context).add(
        RegisterUserEvent(
          userName: userName,
          userEmail: userEmail,
          userPhone: userPhone,
          userCountry: userCountry,
          userBio: userBio,
          userPassword: userPassword,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Пожалуйста, заполните регистрацию'),
        ),
      );
    }
  }
}

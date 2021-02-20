import 'package:flutter/material.dart';

class MyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hoşgeldiniz',
                style: Theme.of(context).textTheme.headline1,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Boş bırakılamaz.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Kullanıcı Adı',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Boş bırakılamaz.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Şifre',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                child: Text('Giriş'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/catalog');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iot_app/client_screen.dart';
import 'package:iot_app/responsable_screen.dart';
import 'package:iot_app/signup_screen.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        // Utilisation d'un Stack pour superposer des widgets
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                        child: Text(
                          'Bienvenue,',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.blue[800],
                              fontSize: 35,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          labelText: "Adresse email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        textInputAction: TextInputAction.next,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          labelText: "Mot de passe",
                          hintText: "Mot de passe",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue.shade800,
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResponsablePage(),
                              ),
                            );
                          },
                          child: Text("Se connecter",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Vous n'avez pas de compte? ",
                            style: TextStyle(fontFamily: 'poppins'),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupScreen()));
                            },
                            child: Text(
                              "Inscrivez-vous !",
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          "Ou",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 50.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClientPage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    'Se connecter avec Google',
                                    style: TextStyle(
                                      color: Colors.blue.shade800,
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            // Ajouter le logo en bas à droite
            bottom: 20,
            right: 20,
            child: Image.asset(
              // Assurez-vous d'avoir l'image dans les assets
              'assets/images/logoiot.png',
              height: 70, // Taille du logo
            ),
          ),
        ],
      ),
    );
  }
}

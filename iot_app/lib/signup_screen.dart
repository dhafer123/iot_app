import 'package:flutter/material.dart';
import 'package:iot_app/sign_in_page.dart'; // Assurez-vous que cet import est correct

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Cette fonction est utilisée pour la visibilité des caractères du mot de passe
  bool _isObscure = true;

  // Valeur du dropdown
  String? _selectedRole;

  // Éléments du dropdown
  final List<String> _roles = ['Client', 'Responsable'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Titre
                  SizedBox(
                    child: Text(
                      'Créez votre compte',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.blue.shade800,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  // Champ pour le nom
                  SizedBox(height: 5),
                  TextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_rounded),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      labelText: "Nom",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Champ pour le prénom
                  TextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_rounded),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      labelText: "Prénom",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Champ pour l'email
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
                  // Champ pour le mot de passe
                  TextField(
                      textInputAction: TextInputAction.next,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        labelText: "Mot de passe",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                  SizedBox(height: 15),
                  // Dropdown pour sélectionner le rôle
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRole = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.people_alt),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      labelText: "Rôle",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: _roles.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 22),
                  // Bouton d'inscription
                  Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue.shade800,
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {},
                      child: const Text("S'inscrire",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 22),
                  // Lien vers la page de connexion
                  Container(
                    height: 50.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const login_screen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 53, 4, 36),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                'Se connecter',
                                style: TextStyle(
                                  color: Colors.blue[800],
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
                  // Logo en bas à droite
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 90.0),
                      child: Image.asset(
                        'assets/images/logoiot.png', // Assurez-vous d'avoir l'image dans ce chemin
                        height: 70, // Taille du logo
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

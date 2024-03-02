import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 105),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Icon
              (Icons.contact_page,
              size: 100,
              color: Colors.lightGreen),

              const SizedBox(height: 40),

              const Text('Hello There!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                ),
              ),
              const SizedBox(height: 15,),
              const Text('Welcome back, You\'ve been missed!',
              style: TextStyle(
                fontSize: 18,
                )
              ),

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                    ),

                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,   
                        hintText: 'Email',
                                         
                      ),
                    ),
                  ),
                ),
              ),
              

            const SizedBox(height: 10),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                    ),

                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,   
                        hintText: 'Password',
                                         
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ignore: avoid_unnecessary_containers
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: 
                    Text('Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,),
                    )),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Not a member? ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                    Text('Register now',
                     style: TextStyle(color: Colors.blue,
                     fontWeight: FontWeight.bold),
                     ),
                  ],
                ),
              

            ],
          ),
        ),
      ),
    );
  }
}
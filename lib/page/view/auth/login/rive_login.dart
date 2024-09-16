import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveLoginPage extends StatefulWidget {
  const RiveLoginPage({super.key});

  @override
  State<RiveLoginPage> createState() => _RiveLoginPageState();
}

class _RiveLoginPageState extends State<RiveLoginPage> {
//form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  SMINumber? numLook;

  late StateMachineController? stateMachineController;
  void isCheckField(){
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }

  void moveEYEBol(value){
    numLook?.change(value.length.toDouble());
  }
  void hidePassword(){
    isHandsUp?.change(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 260,
                child: RiveAnimation.asset(
                  "assets/images/remix_of_login_machine (2).riv",
                  stateMachines: const ["Login Machine"],
                  onInit: (artBoard) {
                    stateMachineController = StateMachineController.fromArtboard(
                        artBoard,
                        "Login Machine"); // it must be same from rive name
                    if (stateMachineController == null) return;
                    artBoard.addController(stateMachineController!);
                    isChecking = stateMachineController?.findInput("isChecking");
                    isHandsUp = stateMachineController?.findInput("isHandsUp");
                    trigSuccess =
                        stateMachineController?.findInput("trigSuccess");
                    trigFail = stateMachineController?.findInput("trigFail");
                    numLook = stateMachineController?.findSMI("numLook");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  alignment: Alignment.center,
                  width: 400,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, blurRadius: 5, spreadRadius: 2)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          // username
                          TextFormField(
                            onChanged: moveEYEBol,
                            onTap: isCheckField,
                            controller: userNameController,
                            style: const TextStyle(fontSize: 15),
                            cursorColor: const Color.fromARGB(255, 176, 72, 99),
                            decoration: InputDecoration(
                              hintText: "UserName",
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusColor: const Color.fromARGB(255, 176, 72, 99),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 176, 72, 99),
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the valid username";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //password field
                          TextFormField(
                            onTap: hidePassword,
                            controller: passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 15),
                            cursorColor: const Color.fromARGB(255, 176, 72, 99),
                            decoration: InputDecoration(
                              hintText: "Password",
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusColor: const Color.fromARGB(255, 176, 72, 99),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 176, 72, 99),
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the valid password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          // login button
                          GestureDetector(
                            onTap: () {
                              if(formKey.currentState!.validate()){
                                isChecking?.change(false);
                                isHandsUp?.change(false);
                                trigSuccess?.change(false);
                                trigFail?.change(true); // for success
                                isChecking?.change(false);
                              }else{
                                isChecking?.change(false);
                                isHandsUp?.change(false);
                                trigSuccess?.change(true); // for unsuccessful
                                trigFail?.change(false);
                                isChecking?.change(false);
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 400,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple[300],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mystery_cards/main.dart';

// late final TextEditingController taskClubs;
// late final TextEditingController taskSpades;
// late final TextEditingController taskHearts;
// late final TextEditingController taskDiamonds;



const TextStyle kTitleTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 255, 255, 255),
);

class LandingPage extends StatefulWidget {
  const LandingPage({ Key? key }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

//text controllers
  final _spadesTask = TextEditingController();
  final _clubsTask = TextEditingController();
  final _heartsTask = TextEditingController();
  final _diamondsTask = TextEditingController();

// text variables for tasks
  String spadesTask = '';
  String clubsTask = '';
  String heartsTask = '';
  String diamondsTask = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        title: Center(
          child: Wrap(
            //spacing: 9.0,
            children: const [
              Icon(
                Icons.batch_prediction,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              Text('MYSTERY CARD', style: kTitleTextStyle)
            ],
          ),
        ),
      ),
      //resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 55),
        
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.0),
                child: Text('ASSIGN TASKS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 22,
                ),),
              ),
        
              const SizedBox(height: 35),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration:  BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    
                ),
        
                child: Padding (
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    controller: _clubsTask,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '♣️: ',
                      suffixIcon: IconButton(
                        onPressed:() {
                          _clubsTask.clear();
                        },
                        icon: const Icon(Icons.clear))
                    ),
                  ),
                )
                ),
              ),
        
              const SizedBox(height: 10),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration:  BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    
                ),
        
                child: Padding (
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    controller: _diamondsTask,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '♦️: ',
                      suffixIcon: IconButton(
                        onPressed:() {
                          _diamondsTask.clear();
                        },
                        icon: const Icon(Icons.clear))
                    ),
                  ),
                )
                ),
              ),
        
              const SizedBox(height: 10),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration:  BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    
                ),
        
                child: Padding (
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    controller: _spadesTask,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '♠️: ',
                      suffixIcon: IconButton(
                        onPressed:() {
                          _spadesTask.clear();
                        },
                        icon: const Icon(Icons.clear))
                    ),
                  ),
                )
                ),
              ),
        
              const SizedBox(height: 10),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration:  BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    
                ),
        
                child: Padding (
                  padding:const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    controller: _heartsTask,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '♥️: ',
                      suffixIcon: IconButton(
                        onPressed:() {
                          _heartsTask.clear();
                        },
                        icon: const Icon(Icons.clear))
                    ),
                  ),
                )
                ),
              ),
              
              const SizedBox(height: 10),
        
              MaterialButton(onPressed: () {
                
                //insert route to move to cardsPage
                
                tasks.clubsTask = _clubsTask.text;
                tasks.spadesTask = _spadesTask.text;
                tasks.heartsTask = _heartsTask.text;
                tasks.diamondsTask = _diamondsTask.text;
                print(tasks.spadesTask);
        
                if(tasks.clubsTask!= '' && tasks.spadesTask != '' && tasks.heartsTask != '' && tasks.diamondsTask!= ''){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> CardsPage(title: 'MYSTERY CARD')));}
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Tasks not assigned correctly, Try again!"),
                    ));
                }
                //return CardsPage(title: 'MYSTERY CARD');
              },
              color: Colors.blueGrey,
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
                ),
                shape: const StadiumBorder(),
                )
            ],
            
          ),
        ),
      ),
      );
  }
}
TaskValues tasks = TaskValues();






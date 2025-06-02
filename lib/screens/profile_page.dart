import 'package:flutter/material.dart';
import 'package:notflix/screens/login_page.dart';
import 'package:notflix/screens/signup_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoggedIn = false;
  String _username = "Misafir Kullanıcı";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      
      body: _isLoggedIn ? _buildLoggedInView() : _buildLoggedOutView(),
    );
  }

  Widget _buildLoggedInView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
       
  
    
       Padding(
        padding: const EdgeInsets.only(top: 10,left: 20),
        child: Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/poster/profile.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    
   
          Text(
            "Watch movies in\n  Virtual Reality",
            style: const TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            "Download and watch offline\n         wherever you are",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Container(
              margin: const EdgeInsets.only(left: 16.0, right: 16.0),
              padding: const EdgeInsets.all(3), // Border kalınlığı gibi davranır
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                     Color.fromARGB(255, 9, 246, 207),
          Color.fromARGB(255, 9, 184, 227),
          Color.fromARGB(255, 246, 9, 214),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 41, 56, 188).withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 7),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
        
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  setState(() {
                    _isLoggedIn = false;
                  });
                },
                child: const Text("Sign Up", style: TextStyle(fontSize: 16),),
              ),
            ),
          ),
/*
          const SizedBox(height: 20),
          Text(
            _username,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 30),
          _buildProfileButton(
            icon: Icons.settings,
            text: "Ayarlar",
            onTap: () {
              // Ayarlar sayfasına yönlendirme
            },
          ),
          const SizedBox(height: 16),
          _buildProfileButton(
            icon: Icons.favorite,
            text: "Favoriler",
            onTap: () {
              // Favoriler sayfasına yönlendirme
            },
          ),
          const SizedBox(height: 16),
          _buildProfileButton(
            icon: Icons.history,
            text: "İzleme Geçmişi",
            onTap: () {
              // İzleme geçmişi sayfasına yönlendirme
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            onPressed: () {
              setState(() {
                _isLoggedIn = false;
              });
            },
            child: const Text("Çıkış Yap", style: TextStyle(fontSize: 16)),
          ),
        ],
        */
        ],
      ),
    );
  }

  Widget _buildLoggedOutView() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 26, 26, 102),
            Colors.black,
            
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.white70,
              ),
              const SizedBox(height: 30),
              const Text(
                "Notflix Welcome",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Login to your account or create a new one",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 50),
              _buildGradientButton(
                text: "Sign In",
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                  
                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      _isLoggedIn = result['isLoggedIn'] ?? false;
                      _username = result['username'] ?? "Kullanıcı";
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              _buildGradientButton(
                text: "Sign Up",
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupPage(),
                    ),
                  );
                  
                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      _isLoggedIn = result['isLoggedIn'] ?? false;
                      _username = result['username'] ?? "Kullanıcı";
                    });
                  }
                },
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLoggedIn = true;
                    _username = "Demo Kullanıcı";
                  });
                },
                child: const Text(
                  "Continue as Guest",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
              width: double.infinity,

              padding: const EdgeInsets.all(3), // Border kalınlığı gibi davranır
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                     Color.fromARGB(255, 9, 246, 207),
          Color.fromARGB(255, 9, 184, 227),
          Color.fromARGB(255, 246, 9, 214),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 41, 56, 188).withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 7),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
        
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
        
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildProfileButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white.withOpacity(0.1),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(text, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        onTap: onTap,
      ),
    );
  }
}
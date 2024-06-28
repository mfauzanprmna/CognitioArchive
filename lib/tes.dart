import 'package:flutter/material.dart';
import 'register.dart';
import 'auth_provider.dart';
import 'main.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            Text(
              'Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            _buildTextField(Icons.lock, 'Password', true),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    Text('Remember password'),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Forget password', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;

                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                final success = await authProvider.login(email, password);

                if (success) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainNavigation()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login failed')),
                  );
                }
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'or connect with',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset('assets/facebook.png'), // Add your asset here
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.asset('assets/google.png'), // Add your asset here
                  onPressed: () {},
                ),
              ],
            ),
            Spacer(),
            Image.asset('assets/login_image.png'), // Add your asset here
          ],
        ),
      ),
    );
  }

  Widget _buildTabs(BuildContext context, {required bool isLogin}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isLogin ? FontWeight.bold : FontWeight.normal,
                  color: isLogin ? Colors.blue : Colors.grey,
                ),
              ),
              if (isLogin)
                Container(
                  height: 2,
                  width: 60,
                  color: Colors.blue,
                  margin: EdgeInsets.only(top: 4),
                ),
            ],
          ),
        ),
        SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          child: Column(
            children: [
              Text(
                'Register',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isLogin ? FontWeight.normal : FontWeight.bold,
                  color: isLogin ? Colors.grey : Colors.blue,
                ),
              ),
              if (!isLogin)
                Container(
                  height: 2,
                  width: 60,
                  color: Colors.blue,
                  margin: EdgeInsets.only(top: 4),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(IconData icon, String hintText, bool isPassword) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

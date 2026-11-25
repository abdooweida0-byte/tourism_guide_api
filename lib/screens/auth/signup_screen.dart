import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../home_screen.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/custom_text_field.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
final nameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final confirmController = TextEditingController();

@override
void dispose() {
nameController.dispose();
emailController.dispose();
passwordController.dispose();
confirmController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {

return Scaffold(
backgroundColor: Colors.white,

appBar: AppBar(),

body: SingleChildScrollView(
child: Padding(
padding: const EdgeInsets.all(25),

child: Column(
children: [

Image.asset(
"assets/logo/logo1.jfif",
width: 200,
),

const SizedBox(height: 20),

const Text(
"Create Account",
style: TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 30),

CustomTextField(
controller: nameController,
hint: "Full Name",
icon: Icons.person_outline,
),

CustomTextField(
controller: emailController,
hint: "Email",
icon: Icons.email_outlined,
),

CustomTextField(
controller: passwordController,
hint: "Password",
icon: Icons.lock_outline,
isPassword: true,
),

CustomTextField(
controller: confirmController,
hint: "Confirm Password",
icon: Icons.lock_outline,
isPassword: true,
),

const SizedBox(height: 20),

SizedBox(
width: double.infinity,
height: 55,

child: ElevatedButton(
style:
ElevatedButton.styleFrom(
backgroundColor:
AppColors.primary,
),

onPressed: () async {
if (passwordController.text != confirmController.text) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Passwords do not match'),
),
);
return;
}

final auth = context.read<AppAuthProvider>();

final ok = await auth.signUp(
nameController.text.trim(),
emailController.text.trim(),
passwordController.text.trim(),
);

if (!context.mounted) return;

if (ok) {
Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(
builder: (_) => const HomeScreen(),
),
(route) => false,
);
} else {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text(auth.error ?? 'Sign up failed')),
);
}
},
  child: const Text(
    "Sign Up",
    style: TextStyle(
      color: Colors.white,
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
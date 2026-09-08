import 'package:flutter/material.dart';

void main() => runApp(const LuckyDrawApp());

class LuckyDrawApp extends StatelessWidget {
  const LuckyDrawApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LuckyDraw',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFF9FAFC),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1261D8)),
      ),
      home: const EntryPage(),
    );
  }
}

const blue = Color(0xFF1261D8);
const navy = Color(0xFF14355F);
const paleBlue = Color(0xFFEAF3FF);
const muted = Color(0xFF687386);

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 390),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(colors: [Color(0xFF2C7CE7), Color(0xFF0A4DBA)]),
                      boxShadow: [BoxShadow(color: blue.withOpacity(.25), blurRadius: 16, offset: const Offset(0, 6))],
                    ),
                    child: const Icon(Icons.location_on_rounded, color: Colors.white, size: 36),
                  ),
                  const SizedBox(height: 18),
                  RichText(text: const TextSpan(style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: navy), children: [TextSpan(text: 'Welcome to '), TextSpan(text: 'LuckyDraw', style: TextStyle(color: blue))])),
                  const SizedBox(height: 28),
                  _LoginField(icon: Icons.person_outline_rounded, hint: 'Phone or Email'),
                  const SizedBox(height: 12),
                  _LoginField(icon: Icons.lock_outline_rounded, hint: 'Password', obscure: true),
                  const SizedBox(height: 18),
                  _PrimaryButton(label: 'Login', onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()))),
                  const SizedBox(height: 10),
                  _OutlineButton(label: 'Register', onPressed: () {}),
                  const SizedBox(height: 20),
                  const Divider(indent: 28, endIndent: 28, color: Color(0xFFE1E5EB)),
                  const SizedBox(height: 12),
                  TextButton(onPressed: () {}, child: const Text('Forgot Password?', style: TextStyle(color: muted, fontSize: 13))),
                  const SizedBox(height: 10),
                  _OutlineButton(label: 'Continue as Guest', onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()))),
                  const SizedBox(height: 26),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  final selected = <int>{};

  @override
  Widget build(BuildContext context) {
    final body = tab == 0 ? _homeBody() : tab == 1 ? const ResultsPage() : const ProfilePage();
    return Scaffold(
      body: SafeArea(child: body),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) => setState(() => tab = value),
        height: 68,
        backgroundColor: Colors.white,
        indicatorColor: paleBlue,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: blue), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long, color: blue), label: 'Results'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: blue), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _homeBody() {
    return Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 20),
        decoration: const BoxDecoration(color: blue, borderRadius: BorderRadius.vertical(bottom: Radius.circular(18))),
        child: Column(children: [
          Row(children: [
            const CircleAvatar(radius: 21, backgroundColor: Colors.white, child: Icon(Icons.person, color: blue)),
            const SizedBox(width: 12),
            const Expanded(child: Text('Hello, User 👋', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17))),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded, color: Colors.white)),
          ]),
          const SizedBox(height: 10),
          Container(padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9), decoration: BoxDecoration(color: Colors.white.withOpacity(.16), borderRadius: BorderRadius.circular(8)), child: const Row(children: [Icon(Icons.account_balance_wallet_outlined, size: 16, color: Colors.white), SizedBox(width: 7), Text('Wallet Balance: \$125.00', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12))])),
        ]),
      ),
      Expanded(child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(18, 18, 18, 12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Pick Your Numbers', style: TextStyle(fontWeight: FontWeight.bold, color: navy, fontSize: 15)),
        const SizedBox(height: 10),
        Card(elevation: 0, color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE8ECF2))), child: Padding(padding: const EdgeInsets.all(12), child: GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: 35, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 7, crossAxisSpacing: 7), itemBuilder: (_, i) { final n = i + 1; final isSelected = selected.contains(n); return InkWell(onTap: () => setState(() => isSelected ? selected.remove(n) : selected.add(n)), borderRadius: BorderRadius.circular(7), child: Container(alignment: Alignment.center, decoration: BoxDecoration(color: isSelected ? blue : const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(7), border: Border.all(color: isSelected ? blue : const Color(0xFFE4E7EC))), child: Text('$n', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : navy)))); } }))),
        const SizedBox(height: 18),
        const Text('Your Numbers', style: TextStyle(fontWeight: FontWeight.bold, color: navy, fontSize: 15)),
        const SizedBox(height: 10),
        Row(children: [7, 14, 23, 35, 42].map((n) => Padding(padding: const EdgeInsets.only(right: 8), child: _Ball('$n', highlighted: n == 14 || n == 35))).toList()),
        const SizedBox(height: 24),
        Row(children: [Expanded(child: _PrimaryButton(label: 'Buy Ticket', onPressed: () {})), const SizedBox(width: 10), Expanded(child: _SecondaryButton(label: 'View Results', onPressed: () => setState(() => tab = 1)))]),
      ]))),
    ]);
  }
}

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});
  @override Widget build(BuildContext context) => SingleChildScrollView(padding: const EdgeInsets.fromLTRB(18, 20, 18, 28), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: navy)), const Expanded(child: Center(child: Text('Latest Results', style: TextStyle(fontWeight: FontWeight.bold, color: navy, fontSize: 16)))), const SizedBox(width: 48)]),
    const Divider(height: 26),
    const Center(child: Text('Winning Numbers', style: TextStyle(color: navy, fontWeight: FontWeight.bold, fontSize: 14))),
    const SizedBox(height: 12),
    Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [7, 14, 22, 35, 40].map((n) => _Ball('$n', highlighted: n == 7 || n == 14 || n == 35 || n == 40, gold: n == 22)).toList())),
    const SizedBox(height: 10), const Center(child: Text('April 15, 2024', style: TextStyle(color: muted, fontSize: 12))),
    const SizedBox(height: 30),
    const Center(child: Text('Your Numbers', style: TextStyle(color: navy, fontWeight: FontWeight.bold, fontSize: 14))),
    const SizedBox(height: 12),
    Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [7, 14, 22, 35, 42].map((n) => _Ball('$n', highlighted: n == 14 || n == 35, gold: n == 35)).toList())),
    const SizedBox(height: 28),
    const Center(child: Icon(Icons.check_circle, color: Color(0xFF37A857), size: 34)), const SizedBox(height: 8), const Center(child: Text('Congratulations! You Win!', style: TextStyle(color: Color(0xFF3E9956), fontWeight: FontWeight.bold, fontSize: 14))),
    const SizedBox(height: 20), _PrimaryButton(label: 'Play Again', onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()))),
  ]));
}

class ProfilePage extends StatelessWidget { const ProfilePage({super.key}); @override Widget build(BuildContext context) => const Center(child: Text('Profile', style: TextStyle(color: navy, fontWeight: FontWeight.bold, fontSize: 20))); }

class _LoginField extends StatelessWidget { final IconData icon; final String hint; final bool obscure; const _LoginField({required this.icon, required this.hint, this.obscure = false}); @override Widget build(BuildContext context) => TextField(obscureText: obscure, style: const TextStyle(fontSize: 13), decoration: InputDecoration(prefixIcon: Icon(icon, size: 18, color: muted), hintText: hint, hintStyle: const TextStyle(color: muted, fontSize: 12), filled: true, fillColor: Colors.white, contentPadding: const EdgeInsets.symmetric(vertical: 13), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Color(0xFFDCE1E8))), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: blue)))); }

class _PrimaryButton extends StatelessWidget { final String label; final VoidCallback onPressed; const _PrimaryButton({required this.label, required this.onPressed}); @override Widget build(BuildContext context) => SizedBox(width: double.infinity, height: 42, child: ElevatedButton(onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: blue, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))), child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)))); }
class _SecondaryButton extends StatelessWidget { final String label; final VoidCallback onPressed; const _SecondaryButton({required this.label, required this.onPressed}); @override Widget build(BuildContext context) => SizedBox(height: 42, child: ElevatedButton(onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2374D8), foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))), child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)))); }
class _OutlineButton extends StatelessWidget { final String label; final VoidCallback onPressed; const _OutlineButton({required this.label, required this.onPressed}); @override Widget build(BuildContext context) => SizedBox(width: double.infinity, height: 42, child: OutlinedButton(onPressed: onPressed, style: OutlinedButton.styleFrom(foregroundColor: navy, side: const BorderSide(color: Color(0xFFDCE1E8)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))), child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)))); }
class _Ball extends StatelessWidget { final String text; final bool highlighted; final bool gold; const _Ball(this.text, {this.highlighted = false, this.gold = false}); @override Widget build(BuildContext context) => Container(width: 31, height: 31, margin: const EdgeInsets.only(right: 6), alignment: Alignment.center, decoration: BoxDecoration(shape: BoxShape.circle, color: gold ? const Color(0xFFF6C646) : highlighted ? blue : const Color(0xFFF3F5F8), border: Border.all(color: highlighted || gold ? Colors.transparent : const Color(0xFFE1E5EA))), child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: highlighted || gold ? Colors.white : navy))); }

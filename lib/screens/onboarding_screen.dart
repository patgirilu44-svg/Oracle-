import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/supabase_client.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const Color bg = Color(0xFF0A0A0F);
  static const Color gold = Color(0xFFD4A017);
  static const Color text = Color(0xFFF5F0E8);

  double _mood = 3;
  final _avoidController = TextEditingController();
  final _hardController = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _avoidController.dispose();
    _hardController.dispose();
    super.dispose();
  }

  String _moodLabel(double v) {
    if (v < 1.5) return 'bahut bura';
    if (v < 2.5) return 'thoda off';
    if (v < 3.5) return 'theek-thaak';
    if (v < 4.5) return 'achha';
    return 'badhiya';
  }

  Future<void> _submit() async {
    if (_hardController.text.trim().isEmpty ||
        _avoidController.text.trim().isEmpty) {
      setState(() => _error = 'sab kuch likhna zaroori hai');
      return;
    }

    setState(() {
      _submitting = true;
      _error = null;
    });

    try {
      final supa = OracleSupabase.client;

      final userRes = await supa
          .from('users')
          .insert({'onboarding_done': true})
          .select()
          .single();

      final userId = userRes['id'] as String;

      await supa.from('onboarding_answers').insert({
        'user_id': userId,
        'mood_baseline': _moodLabel(_mood),
        'core_avoid': _avoidController.text.trim(),
        'personality_word': _hardController.text.trim(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('saved. prophecy aaane wali hai...'),
          backgroundColor: Color(0xFF1A1A22),
        ),
      );
    } catch (e) {
      setState(() => _error = 'kuch galat hua: \$e');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'pehle teen sawaal',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: gold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Oracle ko tumhe samajhne do',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: text.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 40),

                _label('aaj ka mood?'),
                const SizedBox(height: 12),
                Slider(
                  value: _mood,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  activeColor: gold,
                  inactiveColor: text.withOpacity(0.15),
                  onChanged: (v) => setState(() => _mood = v),
                ),
                Center(
                  child: Text(
                    _moodLabel(_mood),
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: gold,
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                _label('kal ka sabse mushkil moment?'),
                const SizedBox(height: 12),
                _input(_hardController, 'kuch shabd, kuch line...'),
                const SizedBox(height: 36),
                _label('kya avoid kar rahe ho?'),
                const SizedBox(height: 12),
                _input(_avoidController, 'jo dimag me chal raha hai...'),
                const SizedBox(height: 40),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      _error!,
                      style: GoogleFonts.inter(
                        color: Colors.redAccent,
                        fontSize: 13,
                      ),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _submitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gold,
                      disabledBackgroundColor: gold.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: _submitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: bg,
                            ),
                          )
                        : Text(
                            'aage badho',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: bg,
                              letterSpacing: 1,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String s) => Text(
        s,
        style: GoogleFonts.playfairDisplay(
          fontSize: 19,
          color: text,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _input(TextEditingController c, String hint) => TextField(
        controller: c,
        style: GoogleFonts.inter(color: text, fontSize: 15),
        cursorColor: gold,
        maxLines: 2,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            color: text.withOpacity(0.3),
            fontSize: 14,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: text.withOpacity(0.2)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: gold, width: 2),
          ),
        ),
      );
}

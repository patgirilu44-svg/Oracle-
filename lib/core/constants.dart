class OracleConstants {
  // Supabase — injected via --dart-define at build time
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );

  // Groq — injected via --dart-define at build time
  static const String groqApiKey = String.fromEnvironment(
    'GROQ_API_KEY',
    defaultValue: '',
  );

  static const String groqModel = 'llama-3.3-70b-versatile';
  static const String groqApiUrl =
      'https://api.groq.com/openai/v1/chat/completions';

  // Design tokens
  static const int bgColorHex = 0xFF0A0A0F;
  static const int goldColorHex = 0xFFD4A017;
  static const int textColorHex = 0xFFF5F0E8;
}

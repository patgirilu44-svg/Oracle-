import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants.dart';

class OracleSupabase {
  static Future<void> init() async {
    await Supabase.initialize(
      url: OracleConstants.supabaseUrl,
      anonKey: OracleConstants.supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}

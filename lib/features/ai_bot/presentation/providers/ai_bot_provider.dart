import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medrep_pro/features/ai_bot/domain/models/chat_message.dart';

final aiBotProvider =
    StateNotifierProvider<AiBotNotifier, List<ChatMessage>>((ref) {
  return AiBotNotifier();
});

final aiLoadingProvider = StateProvider<bool>((ref) => false);

class AiBotNotifier extends StateNotifier<List<ChatMessage>> {
  AiBotNotifier()
      : super([
          ChatMessage(
              role: 'assistant',
              content:
                  'Hello! I am your MedRep AI Assistant powered by Claude. How can I help you manage your territory or log your visits today?')
        ]);

  void clearChat() {
    state = [
      ChatMessage(
          role: 'assistant',
          content: 'Chat cleared. What else can I help you with?')
    ];
  }

  Future<void> sendMessage(String text, WidgetRef ref) async {
    if (text.trim().isEmpty) return;

    // Add user message
    final userMsg = ChatMessage(role: 'user', content: text);
    state = [...state, userMsg];

    ref.read(aiLoadingProvider.notifier).state = true;

    try {
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id ?? 'unknown_user';

      // Send to Edge Function
      final response = await supabase.functions.invoke(
        'ai-assistant',
        body: {
          'userId': userId,
          'message': text,
          'conversationHistory': state.map((m) => m.toJson()).toList(),
          'userContext': {
            'name': 'Raheel Ahmad', // Fallback context
            'role': 'medical_rep',
            'territory': 'Lahore Central',
          }
        },
      );

      final data = response.data;
      String assistantText =
          data['text'] ?? 'Sorry, I could not process that request.';
      Map<String, dynamic>? parsedAction;

      // Extract JSON action from Claude's <action> tags if present
      final actionRegex = RegExp(r'<action>(.*?)</action>', dotAll: true);
      final match = actionRegex.firstMatch(assistantText);
      if (match != null) {
        try {
          parsedAction = jsonDecode(match.group(1)!);
          // Strip the action tag from the visible chat output
          assistantText = assistantText.replaceAll(actionRegex, '').trim();
        } catch (e) {
          print('Failed to parse Claude action JSON: $e');
        }
      }

      state = [
        ...state,
        ChatMessage(
          role: 'assistant',
          content: assistantText,
          action: parsedAction,
        )
      ];
    } catch (e) {
      state = [
        ...state,
        ChatMessage(
            role: 'assistant',
            content:
                'Error reaching the AI server. Ensure you have internet connectivity and the edge function is deployed.\n\nDetails: $e')
      ];
    } finally {
      ref.read(aiLoadingProvider.notifier).state = false;
    }
  }
}

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import Anthropic from "npm:@anthropic-ai/sdk"

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const apiKey = Deno.env.get('ANTHROPIC_API_KEY')
    if (!apiKey) {
      throw new Error('ANTHROPIC_API_KEY environment variable is not set')
    }

    const anthropic = new Anthropic({
      apiKey: apiKey,
    })

    const { userId, message, conversationHistory, userContext } = await req.json()

    // 1. Sanitize history into the Anthropic expected format
    const formattedHistory = conversationHistory.map((msg: any) => ({
      role: msg.role === 'user' ? 'user' : 'assistant',
      content: msg.content
    }))

    // 2. Build the System Prompt tailored for MedRep Pro
    const systemPrompt = `
You are MedRep Pro's AI assistant for a pharmaceutical sales rep.
Current user: ${userContext?.name || 'Representative'}, Territory: ${userContext?.territory || 'Unknown'}
Today's date: ${new Date().toISOString().split('T')[0]}
Role: ${userContext?.role || 'medical_rep'}

You can perform ACTIONS by responding with structured JSON inside <action> tags.
Supported actions:
- ADD_ORDER: { "action": "ADD_ORDER", "chemist_name": "string", "products": [{"name": "string", "quantity": 0}] }
- LOG_DOCTOR_VISIT: { "action": "LOG_DOCTOR_VISIT", "doctor_name": "string", "outcome": "positive|neutral|needs_followup", "notes": "string" }
- GET_ACHIEVEMENT: { "action": "GET_ACHIEVEMENT", "period": "week|month" }

Rules:
1. Always respond conversationally.
2. If the user wants to log a visit or make an order, append an <action>...</action> block at the end of your response containing valid JSON.
3. Be concise and professional.
`

    // 3. Request Claude
    const msg = await anthropic.messages.create({
      model: "claude-3-5-sonnet-20240620",
      max_tokens: 1000,
      system: systemPrompt,
      messages: formattedHistory,
    })

    const assistantResponse = msg.content[0].type === 'text' ? msg.content[0].text : 'Sorry, I am unable to respond.'

    return new Response(
      JSON.stringify({ text: assistantResponse }),
      { 
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 200,
      },
    )
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { 
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 500,
      },
    )
  }
})

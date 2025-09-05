// functions/get-user-by-email/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { v4 as uuidv4 } from "https://esm.sh/uuid@9.0.0";

// Get env vars
const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!; // admin key

const supabaseAdmin = createClient(supabaseUrl, serviceRoleKey);

serve(async (req) => {
  try {
    const { email } = await req.json();

    if (!email) {
      return new Response(JSON.stringify({ error: "Email required" }), { status: 400 });
    }

    // Find user by email
    const { data, error } = await supabaseAdmin.auth.admin.listUsers({ email });

    if (error) {
      return new Response(JSON.stringify({ error: error.message }), { status: 400 });
    }

    if (!data.users || data.users.length === 0) {
      return new Response(JSON.stringify({ error: "User not found" }), { status: 404 });
    }

    const user = data.users[0];

    // Generate reset token
    const token = uuidv4();

    // Save token in table
    const { error: insertError } = await supabaseAdmin
      .from("password_reset_tokens")
      .insert([
        { user_id: user.id, token, expires_at: new Date(Date.now() + 15 * 60 * 1000).toISOString() },
      ]);

    if (insertError) {
      return new Response(JSON.stringify({ error: insertError.message }), { status: 500 });
    }

    // Construct reset link (Frontend page that consumes the token)
    const resetLink = `${supabaseUrl.replace(".supabase.co", ".supabase.co")}/reset-password?token=${token}`;

    // TODO: Send email with reset link (use Supabase SMTP, Resend, Mailgun, etc.)
    console.log(`Send email to ${email} with link: ${resetLink}`);

    return new Response(JSON.stringify({
      message: "Password reset email sent",
      resetLink // ⚠️ for dev/debug only, remove in production
    }), { status: 200 });

  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), { status: 500 });
  }
});

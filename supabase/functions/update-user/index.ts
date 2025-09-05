import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

// Use service_role key for Admin API access
const supabaseAdmin = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
);

serve(async (req) => {
  try {
    const body = await req.json();

    const { id, email, phone, password } = body;

    if (!id) {
      return new Response(
        JSON.stringify({ error: "User ID is required" }),
        { status: 400 }
      );
    }

    // Build update payload
    const updateData: any = {};
    if (email) updateData.email = email;
    if (phone) updateData.phone = phone;
    if (password) updateData.password = password;
    

    // Call Supabase Admin API to update user
    const { data, error } = await supabaseAdmin.auth.admin.updateUserById(
      id,
      updateData
    );

    if (error) {
      console.error("UpdateUser error:", error);
      return new Response(JSON.stringify({ error: error.message }), {
        status: 400,
      });
    }

    return new Response(JSON.stringify({ user: data.user }), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  } catch (err) {
    console.error("Unexpected error:", err);
    return new Response(JSON.stringify({ error: "Internal Server Error" }), {
      status: 500,
    });
  }
});
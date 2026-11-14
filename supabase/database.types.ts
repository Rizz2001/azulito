export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.18"
  }
  public: {
    Tables: {
      cash_sessions: {
        Row: {
          closed_at: string | null
          created_at: string
          declared_cash_bs: number | null
          declared_cash_usd: number | null
          difference_bs: number | null
          difference_usd: number | null
          expected_cash_bs: number
          expected_cash_usd: number
          id: string
          is_deleted: boolean
          notes: string | null
          opened_at: string
          opening_cash_bs: number
          opening_cash_usd: number
          status: string
          store_id: string | null
          updated_at: string
          user_id: string | null
        }
        Insert: {
          closed_at?: string | null
          created_at?: string
          declared_cash_bs?: number | null
          declared_cash_usd?: number | null
          difference_bs?: number | null
          difference_usd?: number | null
          expected_cash_bs?: number
          expected_cash_usd?: number
          id?: string
          is_deleted?: boolean
          notes?: string | null
          opened_at?: string
          opening_cash_bs?: number
          opening_cash_usd?: number
          status?: string
          store_id?: string | null
          updated_at?: string
          user_id?: string | null
        }
        Update: {
          closed_at?: string | null
          created_at?: string
          declared_cash_bs?: number | null
          declared_cash_usd?: number | null
          difference_bs?: number | null
          difference_usd?: number | null
          expected_cash_bs?: number
          expected_cash_usd?: number
          id?: string
          is_deleted?: boolean
          notes?: string | null
          opened_at?: string
          opening_cash_bs?: number
          opening_cash_usd?: number
          status?: string
          store_id?: string | null
          updated_at?: string
          user_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "cash_sessions_store_id_fkey"
            columns: ["store_id"]
            isOneToOne: false
            referencedRelation: "stores"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "cash_sessions_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      categories: {
        Row: {
          color_hex: string
          created_at: string
          icon_name: string
          id: string
          is_deleted: boolean
          name: string
          sort_order: number
          store_id: string | null
          updated_at: string
        }
        Insert: {
          color_hex?: string
          created_at?: string
          icon_name?: string
          id?: string
          is_deleted?: boolean
          name: string
          sort_order?: number
          store_id?: string | null
          updated_at?: string
        }
        Update: {
          color_hex?: string
          created_at?: string
          icon_name?: string
          id?: string
          is_deleted?: boolean
          name?: string
          sort_order?: number
          store_id?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "categories_store_id_fkey"
            columns: ["store_id"]
            isOneToOne: false
            referencedRelation: "stores"
            referencedColumns: ["id"]
          },
        ]
      }
      combo_items: {
        Row: {
          combo_product_id: string
          component_product_id: string
          created_at: string
          id: string
          is_deleted: boolean
          quantity_required: number
          updated_at: string
        }
        Insert: {
          combo_product_id: string
          component_product_id: string
          created_at?: string
          id?: string
          is_deleted?: boolean
          quantity_required?: number
          updated_at?: string
        }
        Update: {
          combo_product_id?: string
          component_product_id?: string
          created_at?: string
          id?: string
          is_deleted?: boolean
          quantity_required?: number
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "combo_items_combo_product_id_fkey"
            columns: ["combo_product_id"]
            isOneToOne: false
            referencedRelation: "products"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "combo_items_component_product_id_fkey"
            columns: ["component_product_id"]
            isOneToOne: false
            referencedRelation: "products"
            referencedColumns: ["id"]
          },
        ]
      }
      customers: {
        Row: {
          address: string | null
          created_at: string
          credit_limit_usd: number
          current_debt_usd: number
          email: string | null
          full_name: string
          id: string
          id_document: string | null
          is_deleted: boolean
          phone: string | null
          store_id: string | null
          updated_at: string
        }
        Insert: {
          address?: string | null
          created_at?: string
          credit_limit_usd?: number
          current_debt_usd?: number
          email?: string | null
          full_name: string
          id?: string
          id_document?: string | null
          is_deleted?: boolean
          phone?: string | null
          store_id?: string | null
          updated_at?: string
        }
        Update: {
          address?: string | null
          created_at?: string
          credit_limit_usd?: number
          current_debt_usd?: number
          email?: string | null
          full_name?: string
          id?: string
          id_document?: string | null
          is_deleted?: boolean
          phone?: string | null
          store_id?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "customers_store_id_fkey"
            columns: ["store_id"]
            isOneToOne: false
            referencedRelation: "stores"
            referencedColumns: ["id"]
          },
        ]
      }
      exchange_rates: {
        Row: {
          created_at: string
          id: string
          is_active: boolean
          is_deleted: boolean
          rate: number
          source: string
          store_id: string | null
          updated_at: string
        }
        Insert: {
          created_at?: string
          id?: string
          is_active?: boolean
          is_deleted?: boolean
          rate: number
          source: string
          store_id?: string | null
          updated_at?: string
        }
        Update: {
          created_at?: string
          id?: string
          is_active?: boolean
          is_deleted?: boolean
          rate?: number
          source?: string
          store_id?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "exchange_rates_store_id_fkey"
            columns: ["store_id"]
            isOneToOne: false
            referencedRelation: "stores"
            referencedColumns: ["id"]
          },
        ]
      }
      inventory_movements: {
        Row: {
          cost_usd: number | null
          created_at: string
          id: string
          movement_type: string
          new_stock: number
          notes: string | null
          previous_stock: number
          product_id: string
          quantity: number
          reference_id: string | null
          store_id: string | null
        }
        Insert: {
          cost_usd?: number | null
          created_at?: string
          id?: string
          movement_type: string
          new_stock: number
          notes?: string | null
          previous_stock: number
          product_id: string
          quantity: number
          reference_id?: string | null
          store_id?: string | null
        }
        Update: {
          cost_usd?: number | null
          created_at?: string
          id?: string
          movement_type?: string
          new_stock?: number
          notes?: string | null
          previous_stock?: number
          product_id?: string
          quantity?: number
          reference_id?: string | null
          store_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "inventory_movements_product_id_fkey"
            columns: ["product_id"]
            isOneToOne: false
            referencedRelation: "products"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "inventory_movements_store_id_fkey"
            columns: ["store_id"]
            isOneToOne: false
            referencedRelation: "stores"
            referencedColumns: ["id"]
          },
        ]
      }
      product_presentations: {
        Row: {
          barcode: string | null
          created_at: string
          id: string
          is_deleted: boolean
          name: string
          price_usd: number
          product_id: string
          quantity_equivalent: number
          updated_at: string
        }
        Insert: {
          barcode?: string | null
          created_at?: string
          id?: string
          is_deleted?: boolean
          name: string
          price_usd: number
          product_id: string
          quantity_equivalent: number
          updated_at?: string
        }
        Update: {
          barcode?: string | null
          created_at?: string
          id?: string
          is_deleted?: boolean
          name?: string
          price_usd?: number
          product_id?: string
          quantity_equivalent?: number
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "product_presentations_product_id_fkey"
            columns: ["product_id"]
            isOneToOne: false
            referencedRelation: "products"
            referencedColumns: ["id"]
          },
        ]
      }
      product_variants: {
        Row: {
          additional_price_usd: number
          barcode: string | null
          created_at: string
          id: string
          is_deleted: boolean
          product_id: string
          sku: string | null
          stock_quantity: number
          updated_at: string
          variant_name: string
        }
        Insert: {
          additional_price_usd?: number
          barcode?: string | null
          created_at?: string
          id?: string
          is_deleted?: boolean
          product_id: string
          sku?: string | null
          stock_quantity?: number
          updated_at?: string
          variant_name: string
        }
        Update: {
          additional_price_usd?: number
          barcode?: string | null
          created_at?: string
          id?: string
          is_deleted?: boolean
          product_id?: string
          sku?: string | null
          stock_quantity?: number
          updated_at?: string
          variant_name?: string
        }
        Relationships: [
          {
            foreignKeyName: "product_variants_product_id_fkey"
            columns: ["product_id"]
            isOneToOne: false
            referencedRelation: "products"
            referencedColumns: ["id"]
          },
        ]
      }
      products: {
        Row: {
          barcode: string | null
          category_id: string | null
          cost_usd: number
          created_at: string
          description: string | null
          id: string
          image_url: string | null
          is_deleted: boolean
          min_stock_alert: number
          name: string
          price_usd: number
          product_type: string
          profit_margin_percent: number
          sku: string | null
          stock_quantity: number
          store_id: string | null
          updated_at: string
        }
        Insert: {
          barcode?: string | null
          category_id?: string | null
          cost_usd?: number
          created_at?: string
          description?: string | null
          id?: string
          image_url?: string | null
          is_deleted?: boolean
          min_stock_alert?: number
          name: string
          price_usd: number
          product_type?: string
          profit_margin_percent?: number
          sku?: string | null
          stock_quantity?: number
          store_id?: string | null
          updated_at?: string
        }
        Update: {
          barcode?: string | null
          category_id?: string | null
          cost_usd?: number
          created_at?: string
          description?: string | null
          id?: string
          image_url?: string | null
          is_deleted?: boolean
          min_stock_alert?: number
          name?: string
          price_usd?: number
          product_type?: string
          profit_margin_percent?: number
          sku?: string | null
          stock_quantity?: number
          store_id?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "products_category_id_fkey"
            columns: ["category_id"]
            isOneToOne: false
            referencedRelation: "categories"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "products_store_id_fkey"
            columns: ["store_id"]
            isOneToOne: false
            referencedRelation: "stores"
            referencedColumns: ["id"]
          },
        ]
      }
      profiles: {
        Row: {
          created_at: string
          email: string | null
          full_name: string
          id: string
          is_active: boolean
          is_deleted: boolean
          quick_pin: string | null
          role: string
          store_id: string | null
          updated_at: string
        }
        Insert: {
          created_at?: string
          email?: string | null
          full_name: string
          id?: string
          is_active?: boolean
          is_deleted?: boolean
          quick_pin?: string | null
          role?: string
          store_id?: string | null
          updated_at?: string
        }
        Update: {
          created_at?: string
          email?: string | null
          full_name?: string
          id?: string
          is_active?: boolean
          is_deleted?: boolean
          quick_pin?: string | null
          role?: string
          store_id?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "profiles_store_id_fkey"
            columns: ["store_id"]
            isOneToOne: false
            referencedRelation: "stores"
            referencedColumns: ["id"]
          },
        ]
      }
      sale_items: {
        Row: {
          created_at: string
          id: string
          presentation_id: string | null
          product_id: string
          product_name: string
          quantity: number
          returned_quantity: number
          sale_id: string
          subtotal_usd: number
          unit_price_usd: number
          variant_id: string | null
        }
        Insert: {
          created_at?: string
          id?: string
          presentation_id?: string | null
          product_id: string
          product_name: string
          quantity: number
          returned_quantity?: number
          sale_id: string
          subtotal_usd: number
          unit_price_usd: number
          variant_id?: string | null
        }
        Update: {
          created_at?: string
          id?: string
          presentation_id?: string | null
          product_id?: string
          product_name?: string
          quantity?: number
          returned_quantity?: number
          sale_id?: string
          subtotal_usd?: number
          unit_price_usd?: number
          variant_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "sale_items_presentation_id_fkey"
            columns: ["presentation_id"]
            isOneToOne: false
            referencedRelation: "product_presentations"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "sale_items_product_id_fkey"
            columns: ["product_id"]
            isOneToOne: false
            referencedRelation: "products"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "sale_items_sale_id_fkey"
            columns: ["sale_id"]
            isOneToOne: false
            referencedRelation: "sales"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "sale_items_variant_id_fkey"
            columns: ["variant_id"]
            isOneToOne: false
            referencedRelation: "product_variants"
            referencedColumns: ["id"]
          },
        ]
      }
      sale_payments: {
        Row: {
          amount_original: number
          amount_usd_equivalent: number
          bank_name: string | null
          created_at: string
          currency: string
          exchange_rate: number
          id: string
          notes: string | null
          payment_method: string
          reference_number: string | null
          sale_id: string
        }
        Insert: {
          amount_original: number
          amount_usd_equivalent: number
          bank_name?: string | null
          created_at?: string
          currency?: string
          exchange_rate: number
          id?: string
          notes?: string | null
          payment_method: string
          reference_number?: string | null
          sale_id: string
        }
        Update: {
          amount_original?: number
          amount_usd_equivalent?: number
          bank_name?: string | null
          created_at?: string
          currency?: string
          exchange_rate?: number
          id?: string
          notes?: string | null
          payment_method?: string
          reference_number?: string | null
          sale_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "sale_payments_sale_id_fkey"
            columns: ["sale_id"]
            isOneToOne: false
            referencedRelation: "sales"
            referencedColumns: ["id"]
          },
        ]
      }
      sales: {
        Row: {
          cash_session_id: string | null
          created_at: string
          customer_id: string | null
          discount_usd: number
          exchange_rate_used: number
          id: string
          igtf_amount_usd: number
          igtf_applied: boolean
          invoice_number: string
          is_deleted: boolean
          notes: string | null
          payment_status: string
          store_id: string | null
          subtotal_usd: number
          total_bs: number
          total_usd: number
          updated_at: string
          user_id: string | null
        }
        Insert: {
          cash_session_id?: string | null
          created_at?: string
          customer_id?: string | null
          discount_usd?: number
          exchange_rate_used: number
          id?: string
          igtf_amount_usd?: number
          igtf_applied?: boolean
          invoice_number: string
          is_deleted?: boolean
          notes?: string | null
          payment_status?: string
          store_id?: string | null
          subtotal_usd: number
          total_bs: number
          total_usd: number
          updated_at?: string
          user_id?: string | null
        }
        Update: {
          cash_session_id?: string | null
          created_at?: string
          customer_id?: string | null
          discount_usd?: number
          exchange_rate_used?: number
          id?: string
          igtf_amount_usd?: number
          igtf_applied?: boolean
          invoice_number?: string
          is_deleted?: boolean
          notes?: string | null
          payment_status?: string
          store_id?: string | null
          subtotal_usd?: number
          total_bs?: number
          total_usd?: number
          updated_at?: string
          user_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "sales_cash_session_id_fkey"
            columns: ["cash_session_id"]
            isOneToOne: false
            referencedRelation: "cash_sessions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "sales_customer_id_fkey"
            columns: ["customer_id"]
            isOneToOne: false
            referencedRelation: "customers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "sales_store_id_fkey"
            columns: ["store_id"]
            isOneToOne: false
            referencedRelation: "stores"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "sales_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      stores: {
        Row: {
          address: string | null
          created_at: string
          default_igtf_enabled: boolean
          id: string
          is_deleted: boolean
          name: string
          phone: string | null
          primary_color: string
          rif: string
          secondary_color: string
          updated_at: string
        }
        Insert: {
          address?: string | null
          created_at?: string
          default_igtf_enabled?: boolean
          id?: string
          is_deleted?: boolean
          name: string
          phone?: string | null
          primary_color?: string
          rif: string
          secondary_color?: string
          updated_at?: string
        }
        Update: {
          address?: string | null
          created_at?: string
          default_igtf_enabled?: boolean
          id?: string
          is_deleted?: boolean
          name?: string
          phone?: string | null
          primary_color?: string
          rif?: string
          secondary_color?: string
          updated_at?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends (DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never) = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends (PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never) = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const


const { Client } = require('pg');
const fs = require('fs');
const path = require('path');

const connectionStrings = [
  // Session pooler (IPv4) us-east-2
  'postgres://postgres.ujrwamckhqhhtdfbikhy:5CLXfuBUdHGiVa00@aws-0-us-east-2.pooler.supabase.com:5432/postgres',
  // Transaction pooler (IPv4) us-east-2
  'postgres://postgres.ujrwamckhqhhtdfbikhy:5CLXfuBUdHGiVa00@aws-0-us-east-2.pooler.supabase.com:6543/postgres',
];

async function run() {
  const sql = fs.readFileSync(path.join(__dirname, '..', 'supabase', 'migrations', '20261114174000_licencias_negocios_master.sql'), 'utf-8');
  
  for (const connStr of connectionStrings) {
    console.log(`Intentando conectar a: ${connStr.split('@')[1]}...`);
    const client = new Client({
      connectionString: connStr,
      ssl: { rejectUnauthorized: false },
      connectionTimeoutMillis: 10000,
    });

    try {
      await client.connect();
      console.log('¡Conexión establecida con éxito!');
      await client.query(sql);
      console.log('¡Migración 20261114174000_licencias_negocios_master.sql ejecutada con éxito!');
      
      const res = await client.query('SELECT codigo_tienda, nombre_negocio, estado_licencia FROM public.licencias_negocios;');
      console.log('Filas en licencias_negocios:', res.rows);
      await client.end();
      return;
    } catch (err) {
      console.error('Error con esta conexión:', err.message);
      try { await client.end(); } catch (_) {}
    }
  }
}

run();

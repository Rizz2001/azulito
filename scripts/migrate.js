const fs = require('fs');
const path = require('path');
const { Client } = require('pg');

async function runMigration() {
  const connectionString = 'postgresql://postgres:5CLXfuBUdHGiVa00@db.ujrwamckhqhhtdfbikhy.supabase.co:5432/postgres';
  
  console.log('Conectando a Supabase PostgreSQL...');
  const client = new Client({
    connectionString,
    ssl: { rejectUnauthorized: false }
  });

  try {
    await client.connect();
    console.log('¡Conexión establecida con éxito!');

    const sqlPath = path.join(__dirname, '..', 'supabase', 'migrations', '20261113005800_initial_pos_schema.sql');
    const sql = fs.readFileSync(sqlPath, 'utf8');

    console.log('Ejecutando migración 20261113005800_initial_pos_schema.sql...');
    await client.query(sql);
    console.log('¡Migración de 14 tablas completada con éxito!');
  } catch (err) {
    console.error('Error durante la migración:', err);
    process.exit(1);
  } finally {
    await client.end();
  }
}

runMigration();

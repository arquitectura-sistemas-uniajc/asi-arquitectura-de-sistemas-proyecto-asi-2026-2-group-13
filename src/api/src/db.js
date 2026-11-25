// DATABASE_URL sigue siendo compatible. En Compose usamos PGHOST, PGPORT,
// PGUSER, PGPASSWORD y PGDATABASE para admitir caracteres especiales en la clave.
const { Pool } = require("pg");

const pool = new Pool({
  ...(process.env.DATABASE_URL ? { connectionString: process.env.DATABASE_URL } : {}),
  connectionTimeoutMillis: 5000,
});

// Una desconexión de un cliente inactivo no debe terminar el proceso.
pool.on("error", (error) => console.error("Conexión PostgreSQL:", error.message));
module.exports = pool;

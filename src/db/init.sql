-- Base de datos de TiendaLocal: Comercio electrónico para pequeños comercios.
-- Se ejecuta solo la primera vez que PostgreSQL arranca con el volumen vacio.

-- Productos
CREATE TABLE IF NOT EXISTS items (
  id        SERIAL PRIMARY KEY,
  nombre    TEXT NOT NULL,          -- Producto
  detalle   TEXT NOT NULL,          -- Tienda y precio
  categoria TEXT NOT NULL,          -- Categoría
  cantidad  NUMERIC(14,2) NOT NULL CHECK (cantidad >= 0)  -- Unidades en stock
);

-- Pedidos
CREATE TABLE IF NOT EXISTS registros (
  id      SERIAL PRIMARY KEY,
  item_id INTEGER REFERENCES items(id),
  persona TEXT NOT NULL,            -- Cliente
  monto   NUMERIC(14,2),
  fecha   TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO items (nombre, detalle, categoria, cantidad) VALUES
  ('Café de Nariño 500 g', 'Tienda Don Luis · $28.000', 'Despensa', 25),
  ('Arepas de maíz x10', 'Panadería La Esquina · $6.500', 'Panadería', 40),
  ('Jabón artesanal', 'Natural Cali · $12.000', 'Aseo', 18),
  ('Panela orgánica 1 kg', 'Tienda Don Luis · $5.800', 'Despensa', 30),
  ('Mochila tejida', 'Artesanías Wayuu · $95.000', 'Artesanías', 6);

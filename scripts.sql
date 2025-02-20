\echo 'Sebastian Heredia Pardo - 175680\n'

CREATE TABLE Clientes (
  cliente_id INTEGER PRIMARY KEY,
  nombre VARCHAR(50),
  email VARCHAR(50)
);

CREATE TABLE Pedidos (
  pedido_id INTEGER PRIMARY KEY,
  cliente_id INTEGER,
  fecha DATE,
  total DECIMAL,
  FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE Productos (
  producto_id INTEGER PRIMARY KEY,
  nombre VARCHAR(50),
  precio DECIMAL
);

CREATE TABLE Detalles_Pedido (
  detalle_id INTEGER PRIMARY KEY,
  pedido_id INTEGER,
  producto_id INTEGER,
  cantidad INT,
  FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
  FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

INSERT INTO Clientes (cliente_id, nombre, email) VALUES
(1, 'Ana Pérez', 'ana.perez@gmail.com'),
(2, 'Carlos López', 'carlos.lopez@yahoo.com'),
(3, 'María García', 'maria.garcia@hotmail.com'),
(4, 'Juan Martínez', 'juan.martinez@gmail.com'),
(5, 'Laura Fernández', 'laura.fernandez@outlook.com');

INSERT INTO Pedidos (pedido_id, cliente_id, fecha, total) VALUES
(1, 1, '2025-01-15', 150.75),
(2, 2, '2025-01-20', 200.50),
(3, 3, '2025-01-25', 300.00),
(4, 4, '2025-02-01', 450.25),
(5, 5, '2025-02-10', 120.00);

INSERT INTO Productos (producto_id, nombre, precio) VALUES
(1, 'Laptop', 1000.00),
(2, 'Smartphone', 750.00),
(3, 'Tablet', 500.00),
(4, 'Monitor', 300.00),
(5, 'Teclado', 50.00);

INSERT INTO Detalles_Pedido (detalle_id, pedido_id, producto_id, cantidad) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 1),
(4, 4, 4, 3),
(5, 5, 5, 4);

\echo '\nEntrada de nuevo cliente:\n'
INSERT INTO Clientes (cliente_id, nombre, email) VALUES
(6, 'Pedro Sánchez', 'pedro.sanchez@example.com');

INSERT INTO Pedidos (pedido_id, cliente_id, fecha, total) VALUES
(6, 6, '2025-02-15', 1000.00),
(7, 6, '2025-02-16', 750.00),
(8, 6, '2025-02-17', 500.00),
(9, 6, '2025-02-18', 300.00),
(10, 6, '2025-02-19', 50.00);

INSERT INTO Detalles_Pedido (detalle_id, pedido_id, producto_id, cantidad) VALUES
(6, 6, 1, 1),
(7, 7, 2, 1),
(8, 8, 3, 1),
(9, 9, 4, 1),
(10, 10, 5, 1);

\echo '\n1. Selección: Obtén todos los clientes cuyo nombre empieza con A\n'
SELECT * FROM Clientes
WHERE nombre LIKE 'A%';

\echo '\n2. Proyección: Muestra solo los nombres y correos electrónicos de los clientes\n'
SELECT nombre, email FROM Clientes;

\echo '\n3. Unión: Encuentra todos los productos que han sido pedidos.\n'
SELECT DISTINCT p.* FROM Productos p
LEFT JOIN Detalles_Pedido dp ON p.producto_id = dp.producto_id;

\echo '\n4. Intersección: Encuentra los clientes que han realizado pedidos y aquellos que tienen un correo electrónico que contiene gmail.\n'
SELECT c.* FROM Clientes c
LEFT JOIN Pedidos p ON c.cliente_id = p.cliente_id
WHERE c.email LIKE '%gmail%';

\echo '\n5. Diferencia: Encuentra los productos que no han sido pedidos.\n'
SELECT p.* FROM Productos p
WHERE p.producto_id NOT IN (SELECT producto_id FROM Detalles_Pedido);

\echo '\n6. Producto Cartesiano: Muestra todas las combinaciones posibles de clientes y productos.\n'
SELECT c.nombre AS cliente, p.nombre AS producto FROM clientes c 
CROSS JOIN productos p;

\echo '\n7. Join Natural: Muestra los detalles de los pedidos junto con la información del cliente.\n'
SELECT * FROM detalles_pedido dp
NATURAL JOIN pedidos p
NATURAL JOIN clientes c;

\echo '\n8. División: Encuentra los clientes que han pedido todos los productos disponibles.\n'
SELECT c.cliente_id, c.nombre, c.email FROM clientes c
WHERE NOT EXISTS (
    SELECT p.producto_id
    FROM productos p
    WHERE NOT EXISTS (
        SELECT dp.producto_id FROM detalles_pedido dp
        JOIN pedidos p2 ON dp.pedido_id = p2.pedido_id
        WHERE p2.cliente_id = c.cliente_id AND dp.producto_id = p.producto_id
    )
);



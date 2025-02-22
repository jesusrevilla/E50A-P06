--Antonio de Jesus Morales Quiroz--176412
-- create
CREATE TABLE Clientes (
  cliente_id  INTEGER PRIMARY KEY,
  nombre  VARCHAR(100),
  email  VARCHAR(100)
);

CREATE TABLE Pedidos (
  pedido_id  INTEGER PRIMARY KEY,
  cliente_id INT  REFERENCES clientes(cliente_id),
  fecha DATE,
  total DECIMAL
);


CREATE TABLE Productos (
  producto_id   INTEGER PRIMARY KEY,
  nombre  VARCHAR(100),
  precio  DECIMAL
);


CREATE TABLE Detalles_Pedido (
  detalle_id    INTEGER PRIMARY KEY,
  pedido_id INT  REFERENCES Pedidos(pedido_id),
  producto_id INT  REFERENCES Productos(producto_id),
  cantidad INT
); 


SELECT DISTINCT C.*
FROM Clientes C
JOIN Pedidos P ON C.cliente_id = P.cliente_id
WHERE C.email LIKE '%gmail%';



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

-- Selección (σ):
SELECT * FROM Clientes WHERE nombre  LIKE 'A%';

SELECT nombre, email FROM   Clientes;


SELECT DISTINCT p.producto_id, p.nombre, p.precio
FROM Productos p
JOIN Detalles_Pedido dp ON p.producto_id = dp.producto_id
JOIN Pedidos pe ON dp.pedido_id = pe.pedido_id;



SELECT DISTINCT C.*
FROM Clientes C
JOIN Pedidos P ON C.cliente_id = P.cliente_id
WHERE C.email LIKE '%gmail%';

SELECT * FROM Productos
WHERE producto_id NOT IN (SELECT DISTINCT producto_id FROM Detalles_Pedido);

SELECT * FROM Clientes, Productos
ORDER BY cliente_id;


SELECT  C.nombre,  P.fecha,  DP.producto_id, DP.cantidad
FROM Clientes C
JOIN Pedidos P ON C.cliente_id = P.cliente_id
JOIN Detalles_Pedido DP ON P.pedido_id = DP.pedido_id;



SELECT C.cliente_id, C.nombre
FROM Clientes C
WHERE NOT EXISTS (
    SELECT P.producto_id 
    FROM Productos P
    WHERE NOT EXISTS (
        SELECT 1 
        FROM Pedidos Pe
        JOIN Detalles_Pedido DP ON Pe.pedido_id = DP.pedido_id
        WHERE DP.producto_id = P.producto_id 
        AND Pe.cliente_id = C.cliente_id
    )
);

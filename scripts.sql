CREATE TABLE Clientes(
  cliente_id INT PRIMARY KEY,
  nombre VARCHAR(50),
  email VARCHAR(50)
);

CREATE TABLE Pedidos(
  pedido_id INT PRIMARY KEY,
  cliente_id INT,
  fecha DATE,
  total DECIMAL,
  FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE Productos(
  producto_id INT PRIMARY KEY,
  Nombre VARCHAR(50),
  precio DECIMAL
);

CREATE TABLE Detalles_Pedido(
  detalle_id INT PRIMARY KEY,
  pedido_id INT,
  producto_id INT,
  cantidad INT,
  FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id),
  FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)
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

--1. Selección: Obtén todos los clientes cuyo nombre empieza con 'A'.

    SELECT * FROM Clientes WHERE nombre LIKE '%A%';

--2. Proyección: Muestra solo los nombres y correos electrónicos de los clientes.

    SELECT nombre,email FROM Clientes;

--3. Unión: Encuentra todos los productos que han sido pedidos.

    SELECT producto_id FROM Productos
    UNION
    SELECT producto_id FROM Detalles_Pedido;
    
--4. Intersección: Encuentra los clientes que han realizado pedidos y aquellos que tienen un correo electrónico que contiene 'gmail'.

    SELECT cliente_id FROM Clientes WHERE email LIKE '%gmail%'
    INTERSECT
    SELECT cliente_id FROM Pedidos;

--5. Diferencia: Encuentra los productos que no han sido pedidos.

    SELECT producto_id FROM Productos
    EXCEPT
    SELECT producto_id FROM Detalles_Pedido;

--6. Producto Cartesiano: Muestra todas las combinaciones posibles de clientes y productos.

    SELECT * FROM Clientes, Productos;
    
--7. Join Natural: Muestra los detalles de los pedidos junto con la información del cliente.

    SELECT * FROM Clientes
    JOIN Pedidos ON Clientes.cliente_id = Pedidos.cliente_id;
    
    
--8. División: Encuentra los clientes que han pedido todos los productos disponibles.

 
  SELECT c.cliente_id, c.nombre
  FROM Clientes c
  WHERE 5 = (
      SELECT COUNT(DISTINCT dp.producto_id)
      FROM Pedidos p
      JOIN Detalles_Pedido dp ON p.pedido_id = dp.pedido_id
      WHERE p.cliente_id = c.cliente_id
  );

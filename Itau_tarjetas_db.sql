DROP DATABASE IF EXISTS Itau_tarjetas_db;
CREATE DATABASE Itau_tarjetas_db;
USE Itau_tarjetas_db;

CREATE TABLE Segmentos_Itau (
    ID_segmento INT AUTO_INCREMENT PRIMARY KEY,
    nombre_segmento VARCHAR(50) NOT NULL,
    tasa_interes_anual DECIMAL(5,2) NOT NULL
);

CREATE TABLE clientes (
    ID_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    cedula VARCHAR(20) NOT NULL,
    ciudad VARCHAR(100) DEFAULT 'ASUNCION',
    ID_segmento INT,
    FOREIGN KEY (ID_segmento) REFERENCES Segmentos_Itau(ID_segmento)
);

CREATE TABLE tarjetas (
    ID_tarjeta INT AUTO_INCREMENT PRIMARY KEY,
    ID_cliente INT,
    franquicia VARCHAR(40) NOT NULL,
    clase VARCHAR(30) NOT NULL,
    limite_credito DECIMAL(15,2) NOT NULL,
    saldo_disponible DECIMAL(15,2) NOT NULL,
    estado VARCHAR(20) DEFAULT 'ACTIVA',
    FOREIGN KEY (ID_cliente) REFERENCES clientes(ID_cliente)
);

CREATE TABLE transacciones (
    ID_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    ID_tarjeta INT,
    fecha_transaccion DATETIME NOT NULL,
    monto DECIMAL(15,2) NOT NULL,
    comercio VARCHAR(50) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    cuotas_pactadas INT DEFAULT 1,
    tiene_promo BOOLEAN DEFAULT FALSE,
    porcentaje_reintegro DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (ID_tarjeta) REFERENCES tarjetas(ID_tarjeta)
);

INSERT INTO Segmentos_Itau (nombre_segmento, tasa_interes_anual) VALUES 
('Minorista', 15.00), 
('Personal Bank', 12.50),
('Platinum', 11.50), 
('Corporativo', 9.00);

-- Clientes iniciales (IDs 1 al 6)
INSERT INTO clientes (nombre, cedula, ciudad, ID_segmento) VALUES 
('Silvio', '3236438', 'Fdo de la Mora', 1),
('Carlos', '4576345', 'Ypane', 1),
('Josue', '9856432', 'Villa Elisa', 2),
('Martina', '4352636', 'San Antonio', 3),
('Raquel', '2435267', 'Lambare', 3),
('Mateo', '6542637', 'San Lorenzo', 4);

-- 30 Nuevos clientes (IDs 7 al 36)
INSERT INTO clientes (ID_cliente, nombre, cedula, ciudad, ID_segmento) VALUES
(7, 'Lucía Benítez', '4512890', 'Asunción', 1),
(8, 'Marcos Giménez', '3894120', 'Luque', 2),
(9, 'Sofía Galeano', '5123456', 'Lambaré', 3),
(10, 'Diego Cáceres', '4298741', 'Capiatá', 2),
(11, 'Valeria Ortiz', '4987123', 'Ñemby', 4),
(12, 'Alejandro Rojas', '3654789', 'Asunción', 1),
(13, 'Camila Duarte', '5321654', 'San Lorenzo', 3),
(14, 'Fernando Núñez', '4123987', 'Fernando de la Mora', 2),
(15, 'Gabriela Silva', '4876543', 'Mariano Roque Alonso', 4),
(16, 'Javier Acosta', '3456123', 'Asunción', 1),
(17, 'Patricia Vera', '5012345', 'Ypané', 3),
(18, 'Ricardo Méndez', '3987654', 'Villa Elisa', 2),
(19, 'Natalia Romero', '4654321', 'Asunción', 1),
(20, 'Sebastián Díaz', '5234567', 'Luque', 4),
(21, 'Andrea Franco', '4789123', 'San Antonio', 3),
(22, 'Héctor Aquino', '3741852', 'Capiatá', 2),
(23, 'Mónica Paredes', '4369258', 'Lambaré', 1),
(24, 'Óscar Torres', '5147258', 'Ñemby', 3),
(25, 'Lorena Villalba', '4852963', 'Asunción', 2),
(26, 'Gustavo Cardozo', '3963852', 'Fernando de la Mora', 4),
(27, 'Carolina Insfrán', '5258147', 'San Lorenzo', 3),
(28, 'Rubén Chávez', '3582147', 'Asunción', 1),
(29, 'Estefanía López', '4951753', 'Luque', 2),
(30, 'Daniel Sosa', '4159753', 'Villa Elisa', 3),
(31, 'Verónica Martínez', '3852741', 'Asunción', 1),
(32, 'Cristian Caballero', '5369147', 'Capiatá', 4),
(33, 'Paola Escobar', '4456789', 'Lambaré', 2),
(34, 'Arturo Brítez', '4753951', 'Ypané', 3),
(35, 'Elena Ayala', '3698521', 'Asunción', 1),
(36, 'Matías Coronel', '4258369', 'San Lorenzo', 2);

-- Tarjetas iniciales (IDs 1 al 5)
INSERT INTO tarjetas (ID_cliente, franquicia, clase, limite_credito, saldo_disponible, estado) VALUES 
(1, 'Mastercard', 'Gold', 8000000.00, 7250000.00, 'ACTIVA'),
(2, 'Visa', 'Platinum', 15000000.00, 11400000.00, 'ACTIVA'),
(3, 'Mastercard', 'Black', 40000000.00, 34000000.00, 'ACTIVA'),
(4, 'Mastercard', 'Internacional', 2800000.00, 370000.00, 'MOROSA'),
(6, 'Visa', 'Infinite', 65000000.00, 62000000.00, 'ACTIVA');

-- 30 Nuevas tarjetas (IDs 6 al 35, vinculadas a los clientes 7 al 36)
INSERT INTO tarjetas (ID_tarjeta, ID_cliente, franquicia, clase, limite_credito, saldo_disponible, estado) VALUES
(6, 7, 'Visa', 'Infinite', 70000000, 61500000, 'ACTIVA'),
(7, 8, 'Mastercard', 'Black', 35000000, 29000000, 'ACTIVA'),
(8, 9, 'Visa', 'Gold', 10000000, 7800000, 'ACTIVA'),
(9, 10, 'Mastercard', 'Platinum', 25000000, 18500000, 'ACTIVA'),
(10, 11, 'Visa', 'Internacional', 4500000, 800000, 'MOROSA'),
(11, 12, 'Mastercard', 'Black', 60000000, 52000000, 'ACTIVA'),
(12, 13, 'Visa', 'Clásica', 5000000, 4100000, 'ACTIVA'),
(13, 14, 'Visa', 'Platinum', 30000000, 24000000, 'ACTIVA'),
(14, 15, 'Mastercard', 'Internacional', 3500000, 3100000, 'ACTIVA'),
(15, 16, 'Visa', 'Infinite', 80000000, 68000000, 'ACTIVA'),
(16, 17, 'Mastercard', 'Gold', 12000000, 9500000, 'ACTIVA'),
(17, 18, 'Visa', 'Black', 42000000, 36000000, 'ACTIVA'),
(18, 19, 'Mastercard', 'Infinite', 75000000, 64000000, 'ACTIVA'),
(19, 20, 'Visa', 'Internacional', 4000000, 500000, 'MOROSA'),
(20, 21, 'Mastercard', 'Clásica', 6000000, 4900000, 'ACTIVA'),
(21, 22, 'Visa', 'Platinum', 28000000, 21000000, 'ACTIVA'),
(22, 23, 'Visa', 'Infinite', 65000000, 55000000, 'ACTIVA'),
(23, 24, 'Mastercard', 'Gold', 11000000, 8700000, 'ACTIVA'),
(24, 25, 'Visa', 'Black', 38000000, 31000000, 'ACTIVA'),
(25, 26, 'Mastercard', 'Internacional', 3000000, 450000, 'MOROSA'),
(26, 27, 'Visa', 'Gold', 9500000, 7600000, 'ACTIVA'),
(27, 28, 'Mastercard', 'Infinite', 90000000, 77000000, 'ACTIVA'),
(28, 29, 'Visa', 'Platinum', 22000000, 17500000, 'ACTIVA'),
(29, 30, 'Mastercard', 'Clásica', 5500000, 4300000, 'ACTIVA'),
(30, 31, 'Visa', 'Black', 55000000, 46000000, 'ACTIVA'),
(31, 32, 'Visa', 'Internacional', 3800000, 3200000, 'ACTIVA'),
(32, 33, 'Mastercard', 'Platinum', 32000000, 25000000, 'ACTIVA'),
(33, 34, 'Visa', 'Gold', 8500000, 1200000, 'MOROSA'),
(34, 35, 'Mastercard', 'Infinite', 72000000, 61000000, 'ACTIVA'),
(35, 36, 'Visa', 'Black', 40000000, 33500000, 'ACTIVA');

-- Transacciones iniciales
INSERT INTO transacciones (ID_tarjeta, fecha_transaccion, monto, comercio, categoria, cuotas_pactadas, tiene_promo, porcentaje_reintegro) VALUES 
(1, '2026-10-05 14:30:00', 450000.00, 'Supermercados Stock', 'Supermercados', 1, TRUE, 20.00),
(1, '2026-10-12 19:15:00', 300000.00, 'Petrobras', 'Combustible', 1, TRUE, 15.00),
(2, '2026-10-08 11:20:00', 1800000.00, 'Tupi Electrodomesticos', 'Hogar y Tecnologia', 6, FALSE, 0.00),
(2, '2026-10-18 21:00:00', 650000.00, 'Shopping del Sol', 'Indumentaria', 3, TRUE, 25.00),
(2, '2026-10-25 13:10:00', 1150000.00, 'Superseis', 'Supermercados', 1, TRUE, 20.00),
(3, '2026-10-03 10:00:00', 4500000.00, 'Copa Airlines', 'Viajes', 6, FALSE, 0.00),
(3, '2026-10-20 22:30:00', 1500000.00, 'Tierra Colorada Gastro', 'Restaurantes', 1, TRUE, 30.00),
(4, '2026-09-15 16:45:00', 1200000.00, 'Biggie Express', 'Supermercados', 1, FALSE, 0.00),
(4, '2026-09-28 18:20:00', 1230000.00, 'Farmacenter', 'Salud y Farmacia', 3, FALSE, 0.00),
(5, '2026-10-14 15:00:00', 3000000.00, 'Paseo La Galeria', 'Indumentaria', 3, TRUE, 25.00);

-- 40 Nuevas transacciones variadas (Agosto - Octubre 2026)
INSERT INTO transacciones (ID_transaccion, ID_tarjeta, fecha_transaccion, comercio, categoria, monto) VALUES
(101, 6, '2026-08-05 10:15:00', 'Copa Airlines', 'Viajes', 4500000),
(102, 7, '2026-08-08 18:30:00', 'Superseis Los Laureles', 'Supermercados', 850000),
(103, 8, '2026-08-12 08:45:00', 'Petrobras', 'Combustible', 350000),
(104, 9, '2026-08-15 15:20:00', 'Nissei Asunción', 'Hogar y Tecnologia', 3200000),
(105, 10, '2026-08-18 19:00:00', 'Zara Paseo La Galería', 'Indumentaria', 1800000),
(106, 11, '2026-08-21 11:10:00', 'LATAM Airlines', 'Viajes', 5200000),
(107, 12, '2026-08-25 14:40:00', 'Punto Farma', 'Salud y Farmacia', 280000),
(108, 13, '2026-08-28 21:30:00', 'Tierra Colorada', 'Restaurantes', 650000),
(109, 14, '2026-09-02 17:15:00', 'Stock San Lorenzo', 'Supermercados', 400000),
(110, 15, '2026-09-04 09:50:00', 'Iberia', 'Viajes', 6800000),
(111, 16, '2026-09-06 16:05:00', 'Farmacenter', 'Salud y Farmacia', 320000),
(112, 17, '2026-09-09 12:30:00', 'Tupi Electrodomésticos', 'Hogar y Tecnologia', 2900000),
(113, 18, '2026-09-11 20:00:00', 'Salvatore Ferragamo', 'Indumentaria', 4100000),
(114, 19, '2026-09-14 07:30:00', 'Copetrol', 'Combustible', 450000),
(115, 20, '2026-09-16 22:10:00', 'Biggie Express', 'Supermercados', 190000),
(116, 21, '2026-09-19 21:15:00', 'La Cabrera', 'Restaurantes', 920000),
(117, 22, '2026-09-22 10:45:00', 'Avianca', 'Viajes', 3900000),
(118, 23, '2026-09-24 18:20:00', 'Meta Sports', 'Indumentaria', 1100000),
(119, 24, '2026-09-26 15:00:00', 'Bristol', 'Hogar y Tecnologia', 3500000),
(120, 25, '2026-09-29 11:35:00', 'Farmacia Catedral', 'Salud y Farmacia', 550000),
(121, 26, '2026-10-01 17:50:00', 'Supermercado Luisito', 'Supermercados', 620000),
(122, 27, '2026-10-03 09:20:00', 'American Airlines', 'Viajes', 7500000),
(123, 28, '2026-10-05 19:40:00', 'Shopping Mariscal', 'Indumentaria', 2100000),
(124, 29, '2026-10-07 08:15:00', 'Shell Paraguay', 'Combustible', 300000),
(125, 30, '2026-10-09 21:45:00', 'O Gaucho', 'Restaurantes', 780000),
(126, 31, '2026-10-10 16:30:00', 'Arete Supermercados', 'Supermercados', 480000),
(127, 32, '2026-10-12 18:55:00', 'Shopping del Sol', 'Indumentaria', 2750000),
(128, 33, '2026-10-14 14:10:00', 'González Giménez', 'Hogar y Tecnologia', 4100000),
(129, 34, '2026-10-16 11:00:00', 'Air Europa', 'Viajes', 6200000),
(130, 35, '2026-10-18 20:30:00', 'Pez de Mar', 'Restaurantes', 850000),
(131, 6, '2026-10-19 17:20:00', 'Casa Rica', 'Supermercados', 1450000),
(132, 7, '2026-10-20 08:00:00', 'Puma Energy', 'Combustible', 500000),
(133, 11, '2026-10-21 15:45:00', 'Samsung House', 'Hogar y Tecnologia', 4800000),
(134, 15, '2026-10-22 19:10:00', 'SAX Department Store', 'Indumentaria', 5200000),
(135, 18, '2026-10-23 10:25:00', 'Sanatorio La Costa', 'Salud y Farmacia', 1900000),
(136, 22, '2026-10-24 21:50:00', 'Talleyrand', 'Restaurantes', 1100000);



SELECT 
    c.ID_cliente,
    c.nombre,
    s.nombre_segmento,
    COALESCE(SUM(tr.monto), 0) AS total_gastado
FROM clientes c
LEFT JOIN Segmentos_Itau s ON c.ID_segmento = s.ID_segmento
LEFT JOIN tarjetas t ON c.ID_cliente = t.ID_cliente
LEFT JOIN transacciones tr ON t.ID_tarjeta = tr.ID_tarjeta
GROUP BY c.ID_cliente, c.nombre, s.nombre_segmento
ORDER BY total_gastado DESC;


-- 2. Volumen de compras y ticket promedio por categoría
SELECT 
    categoria,
    COUNT(ID_transaccion) AS cantidad_compras,
    SUM(monto) AS volumen_total,
    ROUND(AVG(monto), 2) AS ticket_promedio
FROM transacciones
GROUP BY categoria
ORDER BY volumen_total DESC;

-- 3. Costo real de reintegros por comercio en compras con promoción
SELECT 
    comercio,
    COUNT(ID_transaccion) AS compras_con_promo,
    SUM(monto) AS monto_bruto,
    ROUND(SUM(monto * (porcentaje_reintegro / 100)), 2) AS costo_reintegro_banco
FROM transacciones
WHERE tiene_promo = TRUE
GROUP BY comercio
ORDER BY costo_reintegro_banco DESC;

-- 4. Nivel de endeudamiento y porcentaje de uso de línea por cliente
SELECT
    c.nombre,
    t.franquicia,
    t.clase,
    t.estado,
    t.limite_credito,
    (t.limite_credito - t.saldo_disponible) AS deuda_total,
    ROUND(((t.limite_credito - t.saldo_disponible) / t.limite_credito) * 100, 2) AS porcentaje_uso
FROM tarjetas t
INNER JOIN clientes c ON t.ID_cliente = c.ID_cliente
ORDER BY porcentaje_uso DESC;




    I





   

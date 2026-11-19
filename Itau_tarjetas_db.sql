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

INSERT INTO clientes (nombre, cedula, ciudad, ID_segmento) VALUES 
('Silvio', '3236438', 'Fdo de la Mora', 1),
('Carlos', '4576345', 'Ypane', 1),
('Josue', '9856432', 'Villa Elisa', 2),
('Martina', '4352636', 'San Antonio', 3),
('Raquel', '2435267', 'Lambare', 3),
('Mateo', '6542637', 'San Lorenzo', 4);

INSERT INTO tarjetas (ID_cliente, franquicia, clase, limite_credito, saldo_disponible, estado) VALUES 
(1, 'Mastercard', 'Gold', 8000000.00, 7250000.00, 'ACTIVA'),
(2, 'Visa', 'Platinum', 15000000.00, 11400000.00, 'ACTIVA'),
(3, 'Mastercard', 'Black', 40000000.00, 34000000.00, 'ACTIVA'),
(4, 'Mastercard', 'Internacional', 2800000.00, 370000.00, 'MOROSA'),
(6, 'Visa', 'Infinite', 65000000.00, 62000000.00, 'ACTIVA');

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

-- 1. Gasto total por cliente y segmento (incluyendo clientes sin tarjeta)
SELECT 
    c.ID_cliente,
    c.nombre,
    s.nombre_segmento,
    COALESCE(SUM(tr.monto), 0) AS total_gastado
FROM clientes c
INNER JOIN Segmentos_Itau s ON c.ID_segmento = s.ID_segmento
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

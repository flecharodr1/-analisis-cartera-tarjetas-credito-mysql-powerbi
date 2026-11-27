# Análisis de Cartera y Consumos de Tarjetas de Crédito (MySQL + Power BI)

En este proyecto armé una base de datos relacional desde cero en **MySQL** para simular el movimiento real de tarjetas de crédito (límites, saldos disponibles, promociones y mora) y la conecté a **Power BI** para visualizar el estado de la cartera y el comportamiento de consumo por segmentos.

*(Nota: Todos los nombres, cédulas y montos utilizados en este proyecto son 100 % ficticios y fueron creados con fines de práctica y portafolio).*

---

## ¿Qué problema resuelve este proyecto?
En el día a día financiero es clave saber cuánto crédito tienen disponible los clientes, en qué rubros consumen más y detectar rápido quién cayó en mora. Este proyecto toma esos registros transaccionales, asegura que los saldos cuadren mediante reglas relacionales en MySQL y los convierte en un tablero interactivo fácil de leer.

---

## Estructura de la Base de Datos (MySQL)
El modelo relacional está dividido en 4 tablas conectadas mediante llaves primarias y foráneas:
* **`Segmentos_Itau`**: Define los perfiles de clientes (*Minorista, Personal Bank, Platinum, Corporativo*) y su tasa de interés anual.
* **`clientes`**: Contiene los datos básicos de cada titular, ciudad y segmento asignado.
* **`tarjetas`**: Registra la franquicia (*Visa, Mastercard*), clase, límite de crédito, saldo disponible y estado de la cuenta (*Activa* o *Morosa*).
* **`transacciones`**: Almacena el historial de compras por comercio, categoría, cuotas pactadas y porcentaje de reintegro aplicado.

### Consultas incluidas en el script
* Cálculo de gasto total por cliente y segmento (incluyendo clientes sin tarjeta asignada).
* Volumen de compras y ticket promedio agrupado por categoría de comercio.
* Cálculo del costo real asumido por reintegros en compras con promoción.
* Nivel de endeudamiento y porcentaje de utilización de línea por tarjeta.

---

## Tablero Interactivo en Power BI
El reporte visual permite filtrar dinámicamente por **Segmento de Cliente** y muestra:
1. **Indicadores clave (KPI):** Límite total otorgado (Gs. 130,80 mill.) y total facturado en compras (Gs. 15,78 mill.).
2. **Estado de Cartera:** Proporción de tarjetas activas (80 %) frente a tarjetas en estado moroso (20 %).
3. **Límite vs. Saldo Disponible por Segmento:** Comparación directa del cupo total frente al saldo restante en cada perfil.
4. **Consumo por Categoría:** Ranking de los rubros con mayor volumen de gasto.
5. **Detalle de Clientes y Líneas:** Tabla operativa con el desglose completo por titular, ciudad, franquicia y estado actual.
6. **Evolución Diaria de Consumos:** Comportamiento de las compras registradas a lo largo de las fechas.

### Vista General del Tablero
<img width="602" height="340" alt="dashboard general db" src="https://github.com/user-attachments/assets/a0fd4830-29b0-480b-95ba-b0972d013f6a" />



### Vista Filtrada por Segmento
<img width="660" height="335" alt="dashboard filtrado db" src="https://github.com/user-attachments/assets/e04a51d8-9929-4131-9651-6555c444e33e" />


## Herramientas utilizadas
* **MySQL**: Diseño de esquema relacional, integridad referencial y consultas analíticas.
* **Power BI Desktop**: Modelado relacional de tablas y diseño de visualización de datos.

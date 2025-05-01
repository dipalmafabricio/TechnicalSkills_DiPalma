

/*

1) Listar los usuarios que cumplan años
 el día de hoy cuya cantidad de ventas 
 realizadas en enero 2020 sea superior a 1500

*/

-- Lógica: Si existe ID_Customer en Item es un seller
WITH Venta_Sellers as (
    SELECT 
        i.[ID_Customer] as 'ID_Seller',
        YEAR(o.[Fecha_Order]) as 'Anio_Venta',
        MONTH(o.[Fecha_Order]) as 'Mes_Venta',
        SUM(o.[Cantidad]) as 'Cantidad_Ventas'

    FROM 
        Orders as o
    INNER JOIN 
        Item as i ON i.[ID_Item] = o.[ID_Item]
    GROUP BY i.[ID_Customer], YEAR(o.[Fecha_Order]), MONTH(o.[Fecha_Order])
)



SELECT 
    c.[Nombre],
    c.[Apellido],
    c.[Email], 
    c.[Telefono],
    c.[Fecha_Nacimiento]
FROM Customer as c
INNER JOIN Venta_Sellers as v
ON v.[ID_Seller] = c.[ID_Customer]
WHERE 1=1
AND DAY(c.[Fecha_Nacimiento]) = DAY(GETDATE()) 
AND MONTH(c.Fecha_Nacimiento) = MONTH(GETDATE())
AND v.[Anio_Venta] = 2020
AND v.[Mes_Venta] = 1
AND v.[Cantidad_Ventas] > 1500



/*

2) Por cada mes del 2020, se solicita el top 5 de usuarios que más vendieron($)
 en la categoría Celulares.
 Se requiere el mes y año de análisis, nombre y apellido del vendedor, 
 cantidad de ventas realizadas, cantidad de productos vendidos
  y el monto total transaccionado.

*/

-- Siguiendo la lógica de que si existe ID_Customer en Item es un seller
-- (por eso el inner entre order e item y luego con customer)
-- tomando como buyer los ID_Customer de orders

WITH VentasCelulares AS (
    SELECT 
        c.Nombre,
        c.Apellido,
        YEAR(o.Fecha_Order) AS Anio,
        MONTH(o.Fecha_Order) AS Mes,
        --o.ID_Customer AS ID_Buyer,
        i.ID_Customer AS ID_Seller,
        COUNT(o.ID_Order) AS Cantidad_Ventas,
        SUM(o.Cantidad) AS Cantidad_Productos,
        SUM(o.Monto_Total) AS Monto_Total
    FROM Orders  as o
    INNER JOIN Item  as i 
    ON i.ID_Item = o.ID_Item
    INNER JOIN Category  as cat 
    ON cat.ID_Category = i.ID_Category
    INNER JOIN Customer as  c 
    ON c.ID_Customer = i.ID_Customer
    WHERE 1=1
     AND YEAR(o.Fecha_Order) = 2020
    AND UPPER(cat.Nombre_Categoria) = 'CELULARES'
    GROUP BY 
        c.Nombre, c.Apellido, i.ID_Customer, YEAR(o.Fecha_Order), MONTH(o.Fecha_Order)
),

TopVendedores AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY Anio, Mes ORDER BY Monto_Total DESC) as rank 
    FROM VentasCelulares
)
SELECT 
    Anio,
    Mes,
    Nombre,
    Apellido,
    Cantidad_Ventas,
    Cantidad_Productos,
    Monto_Total
FROM TopVendedores
WHERE rank <= 5
ORDER BY Anio, Mes, rank;



/*

3) Poblar una nueva tabla con el precio y estado de los Ítems a fin del día.
 Tener en cuenta que debe ser reprocesable. 
 Vale resaltar que en la tabla Item, vamos a tener únicamente el último estado informado por la PK definida.
 (Se puede resolver a través de StoredProcedure)

*/

-- Lógica: Crear un stored procedure que vaya sacando fotos de la tabla item

-- 1: crear tabla Snapshot
CREATE TABLE Item_Snapshot (
    ID_Snapshot     INT IDENTITY(1,1) PRIMARY KEY,
    ID_Item         INT NOT NULL,
    Fecha_Snapshot  DATE NOT NULL,
    Precio          DECIMAL(10, 2) NOT NULL,
    Estado          CHAR(1) NOT NULL,
    CONSTRAINT FK_Item FOREIGN KEY (ID_Item) REFERENCES Item(ID_Item)
);


-- 2: creo el stored procedure reprocesable 

CREATE PROCEDURE Generar_Snapshot_Item
    @FechaSnapshot DATE
AS
BEGIN
    SET NOCOUNT ON; -- para no dar mensajes de row affected

    -- Elimina si ya existe snapshot de ese día
    DELETE FROM Item_Snapshot
    WHERE Fecha_Snapshot = @FechaSnapshot;

    -- Inserta estado actual como snapshot de ese día
    INSERT INTO Item_Snapshot (ID_Item, Fecha_Snapshot, Precio, Estado)
    SELECT 
        ID_Item,
        @FechaSnapshot,
        Precio,
        Estado
    FROM Item;
END

-- 3: para ejecutar
EXEC Generar_Snapshot_Item @FechaSnapshot = 'INSERTAR FECHA yyyy-mm-dd';





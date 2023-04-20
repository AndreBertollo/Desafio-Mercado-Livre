--1. Listar los usuarios que cumplan años el día de hoy cuya cantidad de ventas realizadas en enero 2020 sea superior a 1500.

-- Selecionar o nome, sobrenome e total de vendas dos clientes
SELECT 
    c.first_name, 
    c.last_name, 
    COUNT(*) AS sales_count 
-- realizar o join entre as tabelas
FROM 
    Order o
    JOIN Customer c ON o.customer_id = c.id
    JOIN Item i ON o.id = i.order_id
    JOIN Category cat ON i.category_id = cat.id
-- filtrar categoria igual a celular, ano igual a 2020 e a data de nascimento do cliente igual a hoje
WHERE 
    cat.name = 'Celulares' 
    AND MONTH(order_date) = 1 
    AND YEAR(order_date) = 2020 
    AND c.birthdate = DATE_FORMAT(NOW(), '%m-%d')
-- agrupar o resultado por nome e sobrenome dos cliente
GROUP BY 
    c.first_name, c.last_name
-- filtrar apenas os clientes que tiveream mais de 1500 vendas no mês de janeiro de 2020
HAVING 
    sales_count > 1500;


--2. Por cada mes del 2020, se solicita el top 5 de usuarios que más vendieron($) en la categoría Celulares. Se requiere el mes y año de análisis, nombre y apellido del vendedor, cantidad de ventas realizadas, cantidad de productos vendidos y el monto total transaccionado. 

-- Selecionar o nome, sobrenome dos clientes, as ordens distintas, formata a data da ordem de compra, seleciona a soma da quantidade de produtos vendidos e calcula a quantidade monetária vendida
SELECT 
    DATE_FORMAT(Order.order_date, '%Y-%m') AS mes_analisis,
    Customer.first_name,
    Customer.last_name,
    COUNT(DISTINCT Order.id) AS cantidad_ventas_realizadas,
    SUM(Item.quantity) AS cantidad_productos_vendidos,
    SUM(Item.unit_price * Item.quantity) AS monto_total_transaccionado
-- realizar o join entre as tabelas order, customer e item
FROM 
    Order 
    INNER JOIN Customer ON Order.customer_id = Customer.id 
    INNER JOIN Item ON Order.id = Item.order_id 
    INNER JOIN Category ON Item.category_id = Category.id 
-- filtrar categoria igual a celular e ano igual a 2020
WHERE 
    Category.name = 'Celulares' 
    AND YEAR(Order.order_date) = 2020 
-- agrupar o resultado por mes e id do cliente
GROUP BY 
    mes_analisis, 
    Customer.id 
-- ordenar por mês e valor total transacionado
ORDER BY 
    mes_analisis ASC, 
    monto_total_transaccionado DESC 
--filtra apenas os top 5
LIMIT 
    5
	
--3. Se solicita poblar una nueva tabla con el precio y estado de los Ítems a fin del día. Tener en cuenta que debe ser reprocesable. Vale resaltar que en la tabla Item, vamos a tener únicamente el último estado informado por la PK definida. (Se puede resolver a través de StoredProcedure)

CREATE PROCEDURE Populate_Item_Status_Price_Table
AS
BEGIN
    -- Criar a tabela temporária para armazenar os dados do final do dia
    CREATE TABLE #temp_item_status_price (
        itemId INT,
        price DECIMAL(10,2),
        status VARCHAR(50)
    )
    
    -- Inserir os dados na tabela temporária
    INSERT INTO #temp_item_status_price (itemId, price, status)
    SELECT i.itemId, i.price, i.status
    FROM Item i
    WHERE i.StatusDate = (
        SELECT MAX(StatusDate)
        FROM Item
        WHERE itemId = i.itemId
    )
    
    -- Inserir os dados na tabela final, evitando duplicações
    INSERT INTO Item_Status_Price (itemId, price, status)
    SELECT t.itemId, t.price, t.status
    FROM #temp_item_status_price t
    LEFT JOIN Item_Status_Price isp ON isp.itemId = t.itemId
    WHERE isp.itemId IS NULL
    
    -- Dropar a tabela temporária
    DROP TABLE #temp_item_status_price
END

EXEC Populate_Item_Status_Price_Table;
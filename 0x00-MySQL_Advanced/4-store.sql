-- Script that creates a trigger that decreases the quantity of an item after adding a new order
DROP TRIGGER IF EXISTS reduce_item_qty;

CREATE TRIGGER reduce_item_qty
AFTER INSERT IN orders
FOR EACH ROW
BEGIN
	UPDATE items
	SET quantity -= NEW.number
	WHERE name = NEW.item_name;
END;

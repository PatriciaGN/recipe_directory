TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Lentil stew', '30', '4');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Spanish omelette', '45', '5');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Stir-fry', '20', '3');

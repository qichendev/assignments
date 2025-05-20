-- Prime Auto Group

DROP TABLE p_dealers          CASCADE CONSTRAINTS;
DROP TABLE p_previous_owners  CASCADE CONSTRAINTS;
DROP TABLE p_cars             CASCADE CONSTRAINTS;
DROP TABLE p_categories       CASCADE CONSTRAINTS;
DROP TABLE p_services         CASCADE CONSTRAINTS;
DROP TABLE p_work_orders      CASCADE CONSTRAINTS;
-- DROP TABLE p_colors           CASCADE CONSTRAINTS;
-- DROP TABLE p_car_locations    CASCADE CONSTRAINTS;
---- SERVICE_REQUESTS

CREATE TABLE p_categories (
  category_id          INTEGER,
  category_description VARCHAR(40) );

ALTER TABLE p_categories
ADD CONSTRAINT p_categories_pk
PRIMARY KEY ( category_id );
    
INSERT INTO p_categories VALUES (200, 'Engine maintenance');
INSERT INTO p_categories VALUES (300, 'Air conditioning');
INSERT INTO p_categories VALUES (400, 'Tires');
INSERT INTO p_categories VALUES (500, 'Electronic system');
INSERT INTO p_categories VALUES (600, 'Body shop');
INSERT INTO p_categories VALUES (700, 'Detailing');

CREATE TABLE p_services (
  service_id           INTEGER,
  service_description  VARCHAR(50),
  price                DECIMAL(7,2),
  category_id          INTEGER );

ALTER TABLE p_services
ADD CONSTRAINT p_services_pk
PRIMARY KEY (service_id);

ALTER TABLE p_services
ADD CONSTRAINT p_services_category_id_fk
FOREIGN KEY (category_id)
REFERENCES p_categories(category_id);
    
INSERT INTO p_services VALUES(201, 'Oil & filter', 85.75, 200);
INSERT INTO p_services VALUES(401, 'Rotate tires', 125.95, 400);
INSERT INTO p_services VALUES(202, 'Check oil and coolant levels', 99.45, 200);
INSERT INTO p_services VALUES(203, 'Change air filter', 32.75, 200);
INSERT INTO p_services VALUES(204, 'Replace transmission fluid', 89.25, 200);
INSERT INTO p_services VALUES(205, 'Coolant fluid exchange', 60.25, 200);
INSERT INTO p_services VALUES(206, 'Replace spark plugs', 44.95, 200);
INSERT INTO p_services VALUES(207, 'Replace windshield wipers', 24.95, 200);

CREATE TABLE p_work_orders (
  work_ordep_no   INTEGER
    GENERATED ALWAYS AS IDENTITY
    START WITH 1001 INCREMENT BY 1
    NOCACHE
    NOT NULL,
  service_id       INTEGER,
  car_id  VARCHAR(50),
  odometer       DECIMAL(7),
  date_scheduled  DATE,
  date_completed  DATE );
  -- total_cost      DECIMAL(7,2) );
  --hours_est
  --hours_actual
  -- mechanic_assigned

ALTER TABLE p_work_orders
ADD CONSTRAINT p_work_orders_pk
PRIMARY KEY (work_ordep_no );
    
INSERT INTO p_work_orders VALUES(DEFAULT, 201, 1, 23000, '2025-05-15', '2025-05-15');

CREATE TABLE p_dealers (
	dealer_id       INTEGER,
	dealer_name     VARCHAR(40),
  dealer_street   VARCHAR(50),    
	dealer_city     VARCHAR(30),
	dealer_state    VARCHAR(2),
  dealer_zip      DECIMAL(5),
	manager_id      INTEGER );

ALTER TABLE p_dealers
ADD CONSTRAINT p_dealers_pk
PRIMARY KEY ( dealer_id );
    
INSERT INTO p_dealers VALUES (101, 'Downtown Autos', '123 Main Street', 'Detroit', 'MI', 48208, 396);
INSERT INTO p_dealers VALUES (206, 'Eastside Better Used Cars', '1046 Sandhill Parkway', 'Troy', 'MI', 48085, 912);
INSERT INTO p_dealers VALUES (407, 'Westside Car Sales', '2745 Clearlake Circle', 'Southfield', 'MI', 48075, 912);
INSERT INTO p_dealers VALUES (681, 'Uptown Preowned Cars', '7349 Lakeview Drive', 'Dearborn', 'MI', 48228, 396);
INSERT INTO p_dealers VALUES (817, 'Lakeside Used Vehicles', '2573 Ridge Vally Drive', 'Utica', 'MI', 48315, 267);
INSERT INTO p_dealers VALUES (110, 'Notheast Auto Sales', '9134 Sunnyside Drive', 'Rochester', 'MI', 48306, NULL);
INSERT INTO p_dealers VALUES (120, 'Bayside Autos', '8364 Airport Drive', 'Ann Arbor', 'MI', 48103, 267);

/*
CREATE TABLE p_car_locations (
  location_code  VARCHAR(2),
  dealer_id      INTEGER,
  car_id          INTEGER );
--  location_fee      DECIMAL(3),
--  renewal_date  DATE,
--  renewal_period  DECIMAL(1),
-- location_date
  
  
ALTER TABLE p_car_locations
ADD CONSTRAINT p_car_locations_pk
PRIMARY KEY ( location_code );

INSERT INTO p_car_locations VALUES ('A1',101, 1001);
INSERT INTO p_car_locations VALUES ('A2',101, 1002);
INSERT INTO p_car_locations VALUES ('A3',101, NULL );
INSERT INTO p_car_locations VALUES ('A4',101, 1001);
INSERT INTO p_car_locations VALUES ('A5',101, 1002);
INSERT INTO p_car_locations VALUES ('A6',101, NULL );
INSERT INTO p_car_locations VALUES ('B1',102, 1001);
INSERT INTO p_car_locations VALUES ('B2',102, 1002);
INSERT INTO p_car_locations VALUES ('B3',102, NULL );
INSERT INTO p_car_locations VALUES ('B4',102, 1001);
INSERT INTO p_car_locations VALUES ('B5',102, 1002);
INSERT INTO p_car_locations VALUES ('B6',102, NULL );
*/

CREATE TABLE p_previous_owners (
  owner_id      INTEGER,
  first_name    VARCHAR(50),
  last_name     VARCHAR(50),
  owner_street  VARCHAR(50),
  owner_city    VARCHAR(50),
  owner_state   VARCHAR(2),
  owner_zip     DECIMAL(5),
  phone_number  DECIMAL(10) );
	
ALTER TABLE p_previous_owners
ADD CONSTRAINT p_previous_owners_pk
PRIMARY KEY ( owner_id );

insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1001, 'Michaela', 'Kinker', '5 Northport Park', 'Detroit', 'MI', '48242', '3133216444');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1002, 'Sherrie', 'Sackey', '3 Monterey Road', 'Detroit', 'MI', '48232', '3139721555');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1003, 'Erroll', 'Draper', '1 Heffernan Court', 'Detroit', 'MI', '48217', '3133119665');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1004, 'Julia', 'Yaneev', '5 Lakewood Gardens Park', 'Grand Rapids', 'MI', '49560', '6166162332');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1005, 'Mireille', 'Gerdes', '4 Schlimgen Place', 'Battle Creek', 'MI', '49018', '2695620220');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1006, 'Thacher', 'McDill', '66193 Birchwood Street', 'Lansing', 'MI', '48912', '5177888432');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1007, 'Dell', 'Buske', '162 Granby Center', 'Lansing', 'MI', '48956', '5176580980');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1008, 'Rodie', 'Mazdon', '684 Warbler Way', 'Lansing', 'MI', '48956', '5176835751');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1009, 'Dido', 'Snugg', '333 La Follette Drive', 'Detroit', 'MI', '48242', '2481230657');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1010, 'Vanda', 'Millgate', '16675 Grover Terrace', 'Detroit', 'MI', '48275', '3138716494');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1011, 'Emlynn', 'Trousdale', '30 Toban Place', 'Detroit', 'MI', '48206', '8108737741');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1012, 'Sherlocke', 'Harkess', '99438 Manitowish Hill', 'Grand Rapids', 'MI', '49505', '6161896592');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1013, 'Corie', 'Molines', '68 Golf View Street', 'Detroit', 'MI', '48217', '3136883109');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1014, 'Savina', 'Blucher', '39488 Esker Drive', 'Detroit', 'MI', '48258', '7347515667');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1015, 'Daren', 'Edmonds', '169 East Plaza', 'Lansing', 'MI', '48901', '5174847342');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1016, 'Marcille', 'Harber', '776 Thierer Circle', 'Grand Rapids', 'MI', '49510', '6167718852');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1017, 'Haleigh', 'Springthorpe', '41 Reindahl Alley', 'Warren', 'MI', '48092', '8104598348');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1018, 'Mariellen', 'Nel', '66 Erie Way', 'Detroit', 'MI', '48242', '3137155180');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1019, 'Karisa', 'Castilljo', '591 Blaine Circle', 'Lansing', 'MI', '48912', '5176519068');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1020, 'Adrianne', 'Peche', '6189 Mcbride Street', 'Lansing', 'MI', '48901', '5176712024');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1021, 'Nelli', 'Mularkey', '90695 Redwing Court', 'Saginaw', 'MI', '48604', '9897063682');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1022, 'Sarina', 'Chipping', '5 Bayside Trail', 'Grand Rapids', 'MI', '49544', '6169921788');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1023, 'Paul', 'Heasly', '6 Marcy Crossing', 'Lansing', 'MI', '48956', '5178083387');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1024, 'Tito', 'Nial', '36 Brickson Park Court', 'Detroit', 'MI', '48267', '3131104421');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1025, 'Isis', 'Scragg', '8 1st Parkway', 'Detroit', 'MI', '48267', '3137357740');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1026, 'Dane', 'Driussi', '3 Graedel Lane', 'Flint', 'MI', '48555', '8106473982');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1027, 'Pippo', 'Hugett', '234 Homewood Circle', 'Grand Rapids', 'MI', '49544', '6162441538');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1028, 'Albert', 'Widd', '0965 Old Gate Plaza', 'Battle Creek', 'MI', '49018', '2699250318');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1029, 'Morna', 'Tuminelli', '0 Hintze Avenue', 'Grand Rapids', 'MI', '49510', '6166774694');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1030, 'Anjanette', 'Cohani', '4427 Laurel Circle', 'Grand Rapids', 'MI', '49518', '6168748576');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1031, 'Dolf', 'Hutcheons', '925 Main Terrace', 'Troy', 'MI', '48098', '2483659855');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1032, 'Katharina', 'Veevers', '08463 Dwight Way', 'Troy', 'MI', '48098', '2487950505');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1033, 'Bobbi', 'Eliet', '9896 Grover Avenue', 'Detroit', 'MI', '48217', '3139082263');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1034, 'Garrett', 'Klais', '429 School Terrace', 'Grand Rapids', 'MI', '49544', '6166279297');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1035, 'Norbert', 'Sleney', '428 Menomonie Crossing', 'Southfield', 'MI', '48076', '3132063972');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1036, 'Will', 'Handscomb', '4405 Hazelcrest Trail', 'Flint', 'MI', '48550', '8103518474');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1037, 'Aldric', 'Bungey', '4 Green Point', 'Detroit', 'MI', '48295', '3133100917');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1038, 'Prince', 'Knotte', '13261 Erie Plaza', 'Detroit', 'MI', '48206', '5862636140');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1039, 'Archambault', 'Hoff', '59999 Westend Drive', 'Warren', 'MI', '48092', '8108754172');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1040, 'Murial', 'Duxbury', '6362 Loftsgordon Avenue', 'Saginaw', 'MI', '48604', '9894059322');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1041, 'Esmeralda', 'Thirsk', '656 Weeping Birch Pass', 'Lansing', 'MI', '48956', '5173466857');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1042, 'Reggie', 'Rook', '87388 Dottie Pass', 'Flint', 'MI', '48555', '8106474615');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1043, 'Dunstan', 'Pau', '515 Anderson Lane', 'Warren', 'MI', '48092', '5862681825');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1044, 'Louisa', 'Pennoni', '4 Express Street', 'Detroit', 'MI', '48275', '3139893921');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1045, 'Sammie', 'Rene', '3885 Stone Corner Crossing', 'Detroit', 'MI', '48267', '3134462271');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1046, 'Lindsy', 'Dockwra', '8 Coolidge Place', 'Detroit', 'MI', '48258', '2481831323');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1047, 'Kamilah', 'Fosbraey', '5679 Scott Crossing', 'Ann Arbor', 'MI', '48107', '7342030339');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1048, 'Durand', 'Ivanikhin', '42 Jana Drive', 'Detroit', 'MI', '48258', '2488616105');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1049, 'Hugo', 'Blakeborough', '60 Farragut Point', 'Southfield', 'MI', '48076', '8108495115');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1050, 'Wynne', 'Pierucci', '73 Nobel Drive', 'Detroit', 'MI', '48211', '7346083636');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1051, 'Jodie', 'Shaefer', '3 Crest Line Park', 'Detroit', 'MI', '48206', '5861634502');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1052, 'Nolan', 'Stock', '3041 John Wall Plaza', 'Grand Rapids', 'MI', '49544', '6164288714');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1053, 'Arline', 'Chadd', '01 Blaine Hill', 'Grand Rapids', 'MI', '49518', '6168680923');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1054, 'Ronnie', 'Adamovitch', '768 Shoshone Park', 'Detroit', 'MI', '48267', '3136340828');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1055, 'Kathye', 'McGurn', '949 Ramsey Crossing', 'Ann Arbor', 'MI', '48107', '7349824830');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1056, 'Hewet', 'Feechan', '7 Manley Drive', 'Dearborn', 'MI', '48126', '3135049486');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1057, 'Port', 'Bydaway', '8 Kingsford Junction', 'Dearborn', 'MI', '48126', '7345540142');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1058, 'Anatole', 'Gutherson', '67691 Hoffman Plaza', 'battle creek', 'MI', '49018', '2694519429');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1059, 'Ingamar', 'Gifford', '6 Longview Parkway', 'Flint', 'MI', '48550', '8101511698');
insert into p_previous_owners (owner_id, first_name, last_name, owner_street, owner_city, owner_state, owner_zip, phone_number) values (1060, 'Gillie', 'Gouthier', '88071 La Follette Hill', 'Detroit', 'MI', '48211', '8105128760');


/*
CREATE TABLE p_colors
	(	colop_id					INTEGER,
		color             VARCHAR(20) );

ALTER TABLE p_colors
ADD CONSTRAINT p_colors_pk
PRIMARY KEY (colop_id);
*/

CREATE TABLE p_cars (
  car_id              INTEGER,    
  car_make            VARCHAR(50),
  car_model           VARCHAR(50),
  model_year          DECIMAL(4),
  color               VARCHAR(20),
  odometer            DECIMAL(7),
  date_acquired       DATE,
  acquired_price      DECIMAL(7),
  selling_price       DECIMAL(7),
  next_service_date   DATE,
  dealer_id           INTEGER,
  previous_owner_id   INTEGER );
  
  -- location_code
  -- last_service_date
  -- dealer_fee
  -- vin VARCHAR(17)

ALTER TABLE p_cars
ADD CONSTRAINT p_cars_pk
PRIMARY KEY (car_id);

ALTER TABLE p_cars
ADD CONSTRAINT p_cars_dealer_id_fk
FOREIGN KEY (dealer_id)
REFERENCES p_dealers(dealer_id);

ALTER TABLE p_cars
ADD CONSTRAINT p_cars_fk
FOREIGN KEY (previous_owner_id)
REFERENCES p_previous_owners(owner_id);
	
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1001, 'Audi', '5000S', 2015, 'white', 73016, '2025-01-24', 59516, 70762, '2025-01-24', 101, 1001);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1002, 'BMW', '7 Series', 2016, 'white', 63018, '2025-09-01', 60018, 71358, '2025-09-01', 110, 1002);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1003, 'Saab', '900', 2017, 'blue', 53020, '2022-08-07', 60520, 71955, '2022-08-07', 101, 1003);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1004, 'Mitsubishi', 'Outlander', 2016, 'gray', 63020, '2025-08-19', 60020, 71361, '2025-08-19', 681, 1004);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1005, 'Jeep', 'Grand Cherokee', 2016, 'white', 63021, '2024-10-14', 60021, 71362, '2024-10-14', 817, 1005);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1006, 'Lincoln', 'Navigator L', 2019, 'red', 33025, '2021-07-07', 61525, 73150, null, 817, 1006);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1007, 'Ford', 'Thunderbird', 2018, 'white', 43025, '2022-09-12', 61025, 72556, '2022-09-12', 110, 1007);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1008, 'Mitsubishi', 'Mirage', 2016, 'white', 63024, '2023-10-12', 60024, 71366, '2023-10-12', 817, 1008);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1009, 'Nissan', '300ZX', 2020, 'gray', 23029, '2022-01-08', 62029, 73749, '2022-01-08', 206, null);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1010, 'Audi', 'A3', 2018, 'red', 43028, '2024-10-21', 61028, 72559, '2024-10-21', 407, 1010);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1011, 'Volvo', 'V70', 2019, 'gray', 33030, '2022-05-11', 61530, 73156, null, 817, 1011);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1012, 'Chevrolet', 'Suburban 2500', 2018, 'blue', 43030, '2021-08-18', 61030, 72562, '2021-08-18', 110, 1012);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1013, 'Suzuki', 'Aerio', 2019, 'red', 33032, '2025-07-23', 61532, 73158, '2025-07-23', 817, 1013);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1014, 'Chevrolet', 'Colorado', 2020, 'black', 23034, '2022-06-06', 62034, 73755, '2022-06-06', 110, 1014);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1015, 'GMC', 'Sonoma Club Coupe', 2017, 'white', 53032, '2022-08-13', 60532, 71970, '2022-08-13', 110, 1015);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1016, 'Dodge', 'Nitro', 2016, 'white', 63032, '2025-06-21', 60032, 71375, '2025-06-21', 120, 1016);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1017, 'Mazda', 'B-Series Plus', 2017, 'red', 53034, '2021-08-20', 60534, 71972, '2021-08-20', 681, 1017);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1018, 'Mitsubishi', 'Excel', 2018, 'white', 43036, '2024-03-13', 61036, 72569, '2024-03-13', 681, null);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1019, 'Mitsubishi', 'RVR', 2015, 'blue', 73034, '2023-04-25', 59534, 70783, '2023-04-25', 110, 1019);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1020, 'Oldsmobile', 'Achieva', 2015, 'silver', 73035, '2022-10-04', 59535, 70784, '2022-10-04', 206, 1020);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1021, 'Chevrolet', 'Express 1500', 2018, 'gray', 43039, '2022-06-08', 61039, 72572, '2022-06-08', 206, 1021);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1022, 'Land Rover', 'Range Rover', 2017, 'silver', 53039, '2025-01-02', 60539, 71978, '2025-01-02', 120, 1022);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1023, 'Dodge', 'Shadow', 2016, 'white', 63039, '2022-07-29', 60039, 71383, '2022-07-29', 110, 1023);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1024, 'Toyota', 'Ipsum', 2016, 'white', 63040, '2021-10-04', 60040, 71385, '2021-10-04', 101, 1024);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1025, 'Mazda', 'MX-5', 2019, 'silver', 33044, '2025-06-22', 61544, 73173, '2025-06-22', 120, null);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1026, 'Suzuki', 'XL7', 2016, 'silver', 63042, '2024-08-06', 60042, 71387, '2024-08-06', 681, 1026);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1027, 'Hyundai', 'Tucson', 2017, 'gray', 53044, '2023-01-17', 60544, 71984, '2023-01-17', 817, 1027);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1028, 'Nissan', '200SX', 2017, 'red', 53045, '2023-12-02', 60545, 71985, '2023-12-02', 120, 1028);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1029, 'Nissan', 'Sentra', 2018, 'red', 43047, '2025-03-12', 61047, 72582, '2025-03-12', 681, 1029);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1030, 'Chevrolet', 'Traverse', 2020, 'white', 23050, '2021-01-21', 62050, 73774, '2021-01-21', 101, 1030);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1031, 'Mazda', 'MPV', 2020, 'black', 23051, '2025-10-14', 62051, 73776, '2025-10-14', 407, 1031);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1032, 'Honda', 'Element', 2018, 'silver', 43050, '2022-04-25', 61050, 72585, null, 407, 1032);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1033, 'Toyota', 'Tacoma', 2017, 'gray', 53050, '2023-03-04', 60550, 71991, '2023-03-04', 101, 1033);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1034, 'Chevrolet', 'Suburban', 2018, 'white', 43052, '2024-06-20', 61052, 72588, '2024-06-20', 407, 1034);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1035, 'Infiniti', 'J', 2015, 'blue', 73050, '2022-04-26', 59550, 70802, '2022-04-26', 101, null);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1036, 'Pontiac', 'Grand Am', 2017, 'gray', 53053, '2025-02-26', 60553, 71994, '2025-02-26', 817, 1036);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1037, 'Ford', 'Tempo', 2016, 'white', 63053, '2024-08-19', 60053, 71400, '2024-08-19', 407, 1037);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1038, 'Audi', 'A3', 2016, 'gray', 63054, '2021-02-20', 60054, 71401, '2021-02-20', 817, 1038);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1039, 'Ford', 'Expedition EL', 2019, 'silver', 33058, '2021-03-02', 61558, 73189, '2021-03-02', 101, 1039);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1040, 'BMW', '530', 2017, 'silver', 53057, '2022-07-04', 60557, 71999, '2022-07-04', 120, null);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1041, 'Mitsubishi', 'Pajero', 2020, 'silver', 23061, '2024-06-20', 62061, 73787, '2024-06-20', 407, 1041);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1042, 'Lincoln', 'Continental', 2016, 'blue', 63058, '2021-11-15', 60058, 71406, '2021-11-15', 110, 1042);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1043, 'Chevrolet', 'Cavalier', 2015, 'black', 73058, '2025-10-01', 59558, 70811, '2025-10-01', 681, 1043);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1044, 'Dodge', 'Dakota Club', 2016, 'red', 63060, '2024-11-14', 60060, 71408, '2024-11-14', 407, 1044);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1045, 'Toyota', 'Avalon', 2016, 'silver', 63061, '2023-08-03', 60061, 71410, '2023-08-03', 407, 1045);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1046, 'Volvo', 'XC90', 2016, 'blue', 63062, '2023-10-07', 60062, 71411, '2023-10-07', 120, 1046);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1047, 'Chevrolet', 'Impala', 2020, 'silver', 23067, '2024-03-31', 62067, 73795, '2024-03-31', 817, 1047);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1048, 'Geo', 'Metro', 2019, 'blue', 33067, '2022-04-28', 61567, 73200, '2022-04-28', 817, 1048);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1049, 'Dodge', 'Dakota Club', 2016, 'white', 63065, '2025-08-15', 60065, 71414, '2025-08-15', 101, 1049);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1050, 'Dodge', 'Caravan', 2017, 'blue', 53067, '2025-06-16', 60567, 72011, '2025-06-16', 120, 1050);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1051, 'Maybach', '57', 2019, 'silver', 33070, '2021-11-11', 61570, 73204, '2021-11-11', 206, 1051);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1052, 'Land Rover', 'Freelander', 2020, 'red', 23072, '2024-12-11', 62072, 73801, '2024-12-11', 101, 1052);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1053, 'Ford', 'Taurus', 2019, 'white', 33072, '2021-01-02', 61572, 73206, '2021-01-02', 110, 1053);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1054, 'Toyota', 'Land Cruiser', 2016, 'silver', 63070, '2021-01-09', 60070, 71420, '2021-01-09', 407, 1054);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1055, 'Buick', 'Regal', 2018, 'white', 43073, '2023-05-27', 61073, 72613, '2023-05-27', 407, 1055);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1056, 'Lincoln', 'Navigator', 2019, 'red', 33075, '2022-09-02', 61575, 73210, null, 681, null);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1057, 'Nissan', 'Altima', 2020, 'gray', 23077, '2024-12-21', 62077, 73806, '2024-12-21', 206, 1057);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1058, 'Mazda', 'Tribute', 2018, 'white', 43076, '2023-08-31', 61076, 72616, null, 110, 1058);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1059, 'GMC', 'Sierra 2500', 2020, 'gray', 23079, '2021-03-31', 62079, 73809, '2021-03-31', 110, 1059);
insert into p_cars (car_id, car_make, car_model, model_year, color, odometer, date_acquired, acquired_price, selling_price, next_service_date, dealer_id, previous_owner_id) values (1060, 'Acura', 'Integra', 2015, 'silver', 73075, '2022-03-01', 59575, 70832, '2022-03-01', 101, 1060);

-- SELECT STATEMENT

SELECT dealer_name AS 'Dealer'
    , UPPER(dealer_street || ' ' || dealer_city || ' , ' || dealer_state || ' ' || dealer_zip) AS 'Address'
FROM p_dealers
WHERE dealer_id IN (101, 407, 120)
ORDER BY dealer_name;

SELECT first_name || ' ' || last_name || AS "Previous Owner"
    , LOWER(owner_street  || ' ' || owner_city || ' , ' || owner_state || ' ' || owner_zip) AS "Address"
FROM p_previous_owners
WHERE owner_id BETWEEN 1010 AND 1015
ORDER BY "Previous Owner";

SELECT CONCAT("Previous owner: ", UPPER(last_name)) AS "Previous Owners"
FROM p_previous_owners
WHERE owner_state = 'MI' AND owner_city = "ANN Arbor"
ORDER BY last_name;

SELECT UPPER(owner_city) AS "CITY"
    , LENGTH(owner_city) AS "CITY_LENGTH"
FROM p_previous_owners
ORDER BY owner_city;

SELECT dealer_name AS "DEALER_NAME"
    , manager_id AS "MANAGER_ID"
FROM p_dealers
WHERE manager_id IS NOT NULL
ORDER BY dealer_name;

SELECT dealer_name AS "DEALER_NAME"
FROM p_dealers
WHERE manager_id IS NOT NULL
ORDER BY dealer_name;

SELECT model_year || " " || car_make || " " || car_model AS "Cars with no previous owner"
FROM p_cars
WHERE previous_owner_id IS NOT NULL
ORDER BY model_year;

SELECT 
    SUBSTR(first_name, 1, 1) || '. ' || last_name AS name
FROM 
    previous_owners
WHERE 
    UPPER(city) = UPPER(:ENTER_CITY)
ORDER BY 
    last_name DESC;

SELECT first_name || " " || last_name AS "PREVIOUS_OWNER"
  , owner_city
FROM p_previous_owners
WHERE owner_city LIKE "B%" OR owner_city LIKE "b%"
ORDER BY "PREVIOUS_OWNER";

SELECT model_year AS "MODEL_YEAR"
  , car_make AS "CAR_MAKE"
  , car_model AS "CAR_MODEL"
  , CONCAT("$", selling_price) AS "SELLING PRICE"
FROM p_cars
WHERE car_make IN ("Dodge", "Nissan", "Lincoln") 
  AND selling_price BETWEEN IN 71000 AND 74000
ORDER BY model_year, car_make, car_model DESC;

SELECT CONCAT(first_name, CONCAT(" ", last_name)) AS "NAME"
FROM p_previous_owners
WHERE LOWER(CONCAT(first_name, last_name)) LIKE "%at%"
ORDER BY last_name;
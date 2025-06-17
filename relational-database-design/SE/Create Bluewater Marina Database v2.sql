DROP TABLE m_marinas;
DROP TABLE m_marina_slips;
DROP TABLE m_owners;
DROP TABLE m_previous_owners;
DROP TABLE m_service_categories;
DROP TABLE m_service_requests;


CREATE TABLE m_owners (
  owner_code            VARCHAR(4),
  last_name             VARCHAR(50),
  first_name            VARCHAR(20),
  address               VARCHAR(15),
  city                  VARCHAR(15),
  owner_state           VARCHAR(2),
  zip                   VARCHAR(5) );

ALTER TABLE m_owners
ADD CONSTRAINT m_owners_pk
PRIMARY KEY(owner_code);


CREATE TABLE m_previous_owners (
  owner_code            VARCHAR(4),
  last_name             VARCHAR(50),
  first_name            VARCHAR(20),
  address               VARCHAR(15),
  city                  VARCHAR(15),
  owner_state           VARCHAR(2),
  zip                   VARCHAR(5) );
  
  
CREATE TABLE m_marinas (
  marina_id             INTEGER,
  marina_name           VARCHAR(20),
  address               VARCHAR(15),
  city                  VARCHAR(15),
  marina_state          VARCHAR(2),
  zip                   DECIMAL(5) );

ALTER TABLE m_marinas
ADD CONSTRAINT m_marinas_pk
PRIMARY KEY(marina_id);


CREATE TABLE m_marina_slips (
  slip_code             VARCHAR(4),
  marina_id             INTEGER,
  slip_length           DECIMAL(4),
  rental_fee            DECIMAL(8,2),
  boat_name             VARCHAR(50),
  boat_type             VARCHAR(50),
  owner_code            VARCHAR(4) );

ALTER TABLE m_marina_slips
ADD CONSTRAINT m_marina_slips_pk
PRIMARY KEY(slip_code);

ALTER TABLE m_marina_slips 
ADD CONSTRAINT m_marina_slips_marina_id_fk
FOREIGN KEY( marina_id )
REFERENCES m_marinas( marina_id );
  
ALTER TABLE m_marina_slips 
ADD CONSTRAINT m_marina_slips_owner_code_fk
FOREIGN KEY( owner_code )
REFERENCES m_owners( owner_code );


CREATE TABLE m_service_categories (
  category_id           INTEGER,
  category_description  VARCHAR(255) );

ALTER TABLE m_service_categories
ADD CONSTRAINT m_service_categories_pk
PRIMARY KEY(category_id);


CREATE TABLE m_service_requests (
  service_id            INTEGER,
  slip_code             VARCHAR(4),
  category_id           INTEGER,
  description           VARCHAR(255),
  status                VARCHAR(255),
  est_hours             DECIMAL(4,2),
  spent_hours           DECIMAL(4,2),
  next_service_date     DATE );

ALTER TABLE m_service_requests
ADD CONSTRAINT m_service_requests_pk
PRIMARY KEY(service_id);

ALTER TABLE m_service_requests 
ADD CONSTRAINT m_service_requests_slip_code_fk
FOREIGN KEY( slip_code )
REFERENCES m_marina_slips( slip_code );

ALTER TABLE m_service_requests 
ADD CONSTRAINT m_service_requests_category_id_fk
FOREIGN KEY( category_id )
REFERENCES m_service_categories( category_id );
	  

----------------------------------------------------------------------------
INSERT INTO m_owners VALUES ('TR72','Trent','Ashton','922 Crest','Bay Shores','FL','30992');
INSERT INTO m_owners VALUES ('JU92','Juarez','Maria','8922 Oak','Rivard','FL','31062');
INSERT INTO m_owners VALUES ('BL72','Blake','Mary','2672 Commodore','Bowton','FL','31313');
INSERT INTO m_owners VALUES ('SM72','Smeltz','Becky and Dave','922 Garland','Glander Bay','FL','31044');
INSERT INTO m_owners VALUES ('FE82','Feenstra','Daniel','7822 Coventry','Kaleva','FL','32521');
INSERT INTO m_owners VALUES ('AD57','Adney','Bruce and Jean','208 Citrus','Bowton','FL','31313');
INSERT INTO m_owners VALUES ('EL25','Elend','Sandy and Bill','462 Riverside','Rivard','FL','31062');
INSERT INTO m_owners VALUES ('AN75','Anderson','Bill','18 Wilcox','Glander Bay','FL','31044');
INSERT INTO m_owners VALUES ('KE22','Kelly','Alyssa','5271 Waters','Bowton','FL','31313');
INSERT INTO m_owners VALUES ('NO27','Norton','Peter','2811 Lakewood','Lewiston','FL','32765');
INSERT INTO m_owners VALUES ('WW11','Anderson','Sandra','111 Ocean Drive','BoWton','FL','31313');
INSERT INTO m_owners VALUES ('JA31','Arnold','James','8456 River Road','Lewiston','FL','32765');
INSERT INTO m_owners VALUES ('JM44','Manis','Jake','745 Ocean Drive','Bowton','FL','31313');

INSERT INTO m_previous_owners VALUES ('YT52','Trent','HollaNd','922 Crest','Bay Shores','FL','30992');
INSERT INTO m_previous_owners VALUES ('JE28','AnDers','Maria','8922 Oak','Rivard','FL','31062');
INSERT INTO m_previous_owners VALUES ('DL37','Ndlon','Ida','2672 Commodore','Bowton','FL','31313');
INSERT INTO m_previous_owners VALUES ('SG34','Smeltz','Becky and Dave','922 Garland','Glander Bay','FL','31044');
INSERT INTO m_previous_owners VALUES ('AK32','Feenstra','harland','7822 Coventry','Kaleva','FL','32521');
INSERT INTO m_previous_owners VALUES ('LH84','Adney','Bruce and Jean','208 Citrus','Bowton','FL','31313');
INSERT INTO m_previous_owners VALUES ('ZI33','Elend','Sandy AND Bill','462 Riverside','Rivard','FL','31062');
INSERT INTO m_previous_owners VALUES ('LI74','ANDerson','Bill','18 Wilcox','Glander Bay','FL','31044');
INSERT INTO m_previous_owners VALUES ('SK55','Kelly','Alyssa','5271 Waters','Bowton','FL','31313');
INSERT INTO m_previous_owners VALUES ('DB33','Norton','ANDy','2811 Lakewood','Lewiston','FL','32765');

INSERT INTO m_marinas VALUES (2,'Bluewater Central','283 Branston','Lakeside','FL','32274');
INSERT INTO m_marinas VALUES (1,'Bluewater East','108 2nd Ave.','East Lakeside','FL','32273');
INSERT INTO m_marinas VALUES (3,'Bluewater West','854 West Ave.','West Lakeside','FL','32275');

INSERT INTO m_marina_slips VALUES ('A4',1,30,2400.00,'Gypsy','Dolphin 28','JU92');
INSERT INTO m_marina_slips VALUES ('B3',2,25,2000.00,'Listy','Dolphin 25','SM72');
INSERT INTO m_marina_slips VALUES ('A2',1,40,3800.25,'Our Toy','Ray 4025','EL25');
INSERT INTO m_marina_slips VALUES ('A3',1,40,3799.40,'Escape','Sprite 4000','KE22');
INSERT INTO m_marina_slips VALUES ('A1',1,40,3800.00,'Anderson II','Sprite 4000','AN75');
INSERT INTO m_marina_slips VALUES ('B5',2,40,4200.00,'Axxon II','Dolphin 40','NO27');
INSERT INTO m_marina_slips VALUES ('A5',1,30,2600.00,'Anderson III','Sprite 3000','AN75');
INSERT INTO m_marina_slips VALUES ('B1',2,25,1800.00,'Bravo','Dolphin 25','AD57');
INSERT INTO m_marina_slips VALUES ('B2',2,25,1800.00,'Chinook','Dolphin 22','FE82');
INSERT INTO m_marina_slips VALUES ('B4',2,30,2500.00,'Mermaid','Dolphin 28','BL72');
INSERT INTO m_marina_slips VALUES ('B6',2,40,4200.75,'Karvel','Ray 4025','TR72');
INSERT INTO m_marina_slips VALUES ('C2',3,25,1800.00,NULL,NULL,NULL);
INSERT INTO m_marina_slips VALUES ('C1',3,30,2500.00,'Freedom','Campion 30','JA31');
INSERT INTO m_marina_slips VALUES ('C3',3,40,4200.75,'My Get Away','MasterCraft 30','JM44');

INSERT INTO m_service_categories VALUES (6,'Canvas installation');
INSERT INTO m_service_categories VALUES (2,'Engine repair');
INSERT INTO m_service_categories VALUES (4,'Electrical systems');
INSERT INTO m_service_categories VALUES (7,'Canvas repair');
INSERT INTO m_service_categories VALUES (1,'Routine engine maintenance');
INSERT INTO m_service_categories VALUES (3,'Air conditioning');
INSERT INTO m_service_categories VALUES (5,'Fiberglass repair');
INSERT INTO m_service_categories VALUES (8,'Electronic systems (radar, GPS, autopilots, etc.)');

INSERT INTO m_service_requests VALUES (8,'B1',2,'Heat exchanger not operating correctly.','Technician has determined that the exchanger is faulty. New exchanger has been ordered.','4','1','2025-07-17');
INSERT INTO m_service_requests VALUES (13,'B3',2,'Customer describes engine as making a clattering sound.','Technician suspects problem with either propeller or shaft and has scheduled the boat to be pulled from the water for further investigation.','5','2','2025-05-12');
INSERT INTO m_service_requests VALUES (1,'A1',3,'Air conditioner periodically stops with code indicating low coolant level. Diagnose and repair.','Technician has verified the problem. Air conditioning specialist has been called.','4','2','2025-06-12');
INSERT INTO m_service_requests VALUES (10,'A2',8,'Install new GPS and chart plotter','Scheduled','7','0','2025-08-17');
INSERT INTO m_service_requests VALUES (2,'A5',4,'Fuse on port motor blown on two occasions. Diagnose and repair.','Open','2','0','2025-05-12');
INSERT INTO m_service_requests VALUES (12,'A4',8,'Both speed and depth readings on data unit are significantly less than the owner thinks they should be.','Technician has scheduled appointment with owner to attempt to verify the problem.','2','0','2025-07-16');
INSERT INTO m_service_requests VALUES (3,'A4',1,'Oil change and general routine maintenance (check fluid levels, clean sea strainers etc.).','Service call has been scheduled.','1','0','2026-05-16');
INSERT INTO m_service_requests VALUES (4,'A1',2,'Engine oil level has been dropping drastically. Diagnose and repair.','Open','2','0','2026-08-13');
INSERT INTO m_service_requests VALUES (9,'B2',6,'Canvas severely damaged in windstorm. Order and install new canvas.','Open','8','0','2026-07-16');
INSERT INTO m_service_requests VALUES (5,'A3',5,'Open pockets at base of two stantions.','Technician has completed the initial filling of the open pockets. Will complete the job after the initial fill has had sufficient time to dry.','4','2','2026-06-13');
INSERT INTO m_service_requests VALUES (6,'B6',4,'Electric-flush system periodically stops functioning. Diagnose and repair.','Open','2.50','0','2027-05-10');
INSERT INTO m_service_requests VALUES (11,'A2',3,'Air conditioning unit shuts down with HHH showing on the control panel.','Technician not able to replicate the problem. Air conditioning unit ran fine through multiple tests. Owner to notify technician if the problem recurs.','1','1','2027-09-25');
INSERT INTO m_service_requests VALUES (7,'B1',2,'Engine overheating. Loss of coolant. Diagnose and repair.','Open','2','0','2026-05-13');
INSERT INTO m_service_requests VALUES (14,'B2',5,'Owner accident caused damage to forward portion of port side.','Technician has scheduled repair.','6','0','2026-05-01');
INSERT INTO m_service_requests VALUES (15,'B6',7,'Canvas leaks around zippers in heavy rain. Install overlap around zippers to prevent leaks.','Overlap has been created. Installation has been scheduled.','8','3','2026-05-02');


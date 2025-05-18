-- clients table
INSERT INTO clients (client_id, name, email, phone, address) VALUES (1, 'John Doe', 'john.doe@example.com', '555-1234', '123 Main St');
INSERT INTO clients (client_id, name, email, phone, address) VALUES (2, 'Jane Smith', 'jane.smith@example.com', '555-5678', '456 Elm St');
INSERT INTO clients (client_id, name, email, phone, address) VALUES (3, 'Alice Brown', 'alice.brown@example.com', '555-9876', '789 Pine St');
INSERT INTO clients (client_id, name, email, phone, address) VALUES (4, 'Bob White', 'bob.white@example.com', '555-6543', '101 Maple Ave');
INSERT INTO clients (client_id, name, email, phone, address) VALUES (5, 'Carol Green', 'carol.green@example.com', '555-3210', '202 Oak Blvd');
INSERT INTO clients (client_id, name, email, phone, address) VALUES (6, 'Dan Black', 'dan.black@example.com', '555-2468', '303 Cedar Ln');
INSERT INTO clients (client_id, name, email, phone, address) VALUES (7, 'Eve Gray', 'eve.gray@example.com', '555-1357', '404 Birch Dr');
INSERT INTO clients (client_id, name, email, phone, address) VALUES (8, 'Frank Silver', 'frank.silver@example.com', '555-7890', '505 Walnut Rd');

-- contractors table
INSERT INTO contractors (contractor_id, name, specialization, phone, rating) VALUES (11, 'Mike Johnson', 'Electrical', '555-9876', 4.5);
INSERT INTO contractors (contractor_id, name, specialization, phone, rating) VALUES (12, 'Emily Davis', 'Plumbing', '555-4321', 4.8);
INSERT INTO contractors (contractor_id, name, specialization, phone, rating) VALUES (13, 'Steve Adams', 'Landscaping', '555-6789', 4.2);
INSERT INTO contractors (contractor_id, name, specialization, phone, rating) VALUES (14, 'Laura Bell', 'Interior Design', '555-3456', 4.7);
INSERT INTO contractors (contractor_id, name, specialization, phone, rating) VALUES (15, 'Tom Carter', 'Painting', '555-9012', 4.3);
INSERT INTO contractors (contractor_id, name, specialization, phone, rating) VALUES (16, 'Nancy Foster', 'Roofing', '555-1111', 4.6);

-- projects table
INSERT INTO projects (project_id, project_name, start_date, end_date, budget, status, client_id) VALUES (1, 'Kitchen Remodel', '2024-01-01', '2024-02-01', 15000.00, 'Planned', 1);
INSERT INTO projects (project_id, project_name, start_date, end_date, budget, status, client_id) VALUES (2, 'Bathroom Renovation', '2024-03-01', '2024-03-15', 8000.00, 'In Progress', 2);
INSERT INTO projects (project_id, project_name, start_date, end_date, budget, status, client_id) VALUES (3, 'Living Room Update', '2024-02-10', '2024-02-20', 5000.00, 'Planned', 3);
INSERT INTO projects (project_id, project_name, start_date, end_date, budget, status, client_id) VALUES (4, 'Second Bathroom Renovation', '2024-05-10', '2024-05-25', 8500.00, 'In Progress', 5);
INSERT INTO projects (project_id, project_name, start_date, end_date, budget, status, client_id) VALUES (5, 'Large Kitchen Remodel', '2024-06-01', '2024-07-15', 25000.00, 'Planned', 6);
INSERT INTO projects (project_id, project_name, start_date, end_date, budget, status, client_id) VALUES (6, 'Master Bathroom Renovation', '2024-07-20', '2024-08-10', 10000.00, 'Planned', 7);
INSERT INTO projects (project_id, project_name, start_date, end_date, budget, status, client_id) VALUES (7, 'Modern Living Room', '2024-09-01', '2024-09-20', 6000.00, 'Planned', 1);

-- subtype tables
INSERT INTO kitchens (project_id, style, appliance_type, square_footage) VALUES (1, 'Modern', 'Stainless Steel', 200);
INSERT INTO kitchens (project_id, style, appliance_type, square_footage) VALUES (5, 'Contemporary', 'Smart Appliances', 350);

INSERT INTO bathrooms (project_id, tile_type, fixture_type, square_footage) VALUES (2, 'Ceramic', 'Contemporary', 100);
INSERT INTO bathrooms (project_id, tile_type, fixture_type, square_footage) VALUES (4, 'Porcelain', 'Luxury', 120);
INSERT INTO bathrooms (project_id, tile_type, fixture_type, square_footage) VALUES (6, 'Stone', 'Modern', 150);

INSERT INTO living_rooms (project_id, flooring_type, wall_color, square_footage) VALUES (3, 'Hardwood', 'Beige', 250);
INSERT INTO living_rooms (project_id, flooring_type, wall_color, square_footage) VALUES (7, 'Laminate', 'Gray', 300);

-- project_contractor table
INSERT INTO proj_cont (project_id, contractor_id) VALUES (1, 11);
INSERT INTO proj_cont (project_id, contractor_id) VALUES (2, 12);
INSERT INTO proj_cont (project_id, contractor_id) VALUES (3, 13);
INSERT INTO proj_cont (project_id, contractor_id) VALUES (4, 14);
INSERT INTO proj_cont (project_id, contractor_id) VALUES (5, 15);
INSERT INTO proj_cont (project_id, contractor_id) VALUES (6, 16);
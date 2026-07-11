-- ==========================================================================
-- CSE 340 Service Network Database Setup Schema
-- File: src/setup.sql
-- ==========================================================================

-- 1. Create the Organization Table
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- 2. Insert Initial Sample Data for Partner Organizations
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
(
    'BrightFuture Builders', 
    'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 
    'info@brightfuturebuilders.org', 
    'brightfuture-logo.png'
),
(
    'GreenHarvest Growers', 
    'An urban farming collective promoting food sustainability and education in local neighborhoods.', 
    'contact@greenharvest.org', 
    'greenharvest-logo.png'
),
(
    'UnityServe Volunteers', 
    'A volunteer coordination group supporting local charities and service initiatives.', 
    'hello@unityserve.org', 
    'unityserve-logo.png'
);

-- ==========================================================================
-- 1. Create the Project Table with Referential Integrity (Foreign Key)
-- ==========================================================================
CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    CONSTRAINT fk_organization 
        FOREIGN KEY (organization_id) 
        REFERENCES organization(organization_id)
        ON DELETE CASCADE
);

-- ==========================================================================
-- 2. Insert 15 Sample Service Projects (5 per Organization ID)
-- ==========================================================================
INSERT INTO project (organization_id, title, description, location, date)
VALUES
-- BrightFuture Builders (Org ID: 1)
(1, 'Community Center Paint Drive', 'Freshening up the interior walls of our youth center.', '123 South Main St', '2026-08-12'),
(1, 'Sustainable Deck Assembly', 'Building a wooden mobility ramp using composite recycled materials.', 'Public Library East', '2026-08-19'),
(1, 'Park Bench Restoration', 'Sanding down and weather-proofing community park benches.', 'Liberty Park Area B', '2026-09-02'),
(1, 'Roof Shingle Repair Workshop', 'Helping low-income homeowners patch small roof leaks.', 'Neighborhood Hub', '2026-09-15'),
(1, 'Urban Greenhouse Skeleton', 'Assembling the structural metal framing for a neighborhood nursery.', 'Greenhouse Site 1', '2026-10-01'),

-- GreenHarvest Growers (Org ID: 2)
(2, 'Community Soil Turning', 'Aerating soil and adding nutrient compost blocks ahead of planting.', 'Downtown Community Plot', '2026-08-15'),
(2, 'Harvest Assembly Line', 'Sorting fresh vegetables and packaging boxes for food pantries.', 'Harvest Shed B', '2026-08-22'),
(2, 'Drip Line Irrigation Setup', 'Laying out water-saving drip hoses along vegetable rows.', 'Northside Garden Hub', '2026-09-05'),
(2, 'Fruit Tree Pruning Class', 'Trimming dead limbs from community orchards to increase crop yields.', 'Orchard Field', '2026-09-18'),
(2, 'Winter Seed Bed Prep', 'Covering active soil zones with protective tarps and mulch blankets.', 'Downtown Community Plot', '2026-10-10'),

-- UnityServe Volunteers (Org ID: 3)
(3, 'Senior Center Lunch Service', 'Plating and serving meals to elderly community members.', 'Golden Age Lounge', '2026-08-14'),
(3, 'Back-to-School Backpack Pack', 'Filling school bags with pencils, binders, and materials.', 'Unity Warehouse Room 4', '2026-08-20'),
(3, 'Downtown Clean Sweep Walk', 'Collecting litter along business pathways to beautify the blocks.', 'Main Street Commerce Zone', '2026-09-06'),
(3, 'Charity Coat Sorting Grid', 'Categorizing donated winter coats by size and fabric grade.', 'Unity Warehouse Room B', '2026-09-22'),
(3, 'Holiday Gift Wrapping Drive', 'Wrapping present packages for children in shelter housing networks.', 'Civic Center Hall', '2026-12-05');


-- ==========================================================================
-- 1. Create the Category Table
-- ==========================================================================
CREATE TABLE public.category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- ==========================================================================
-- 2. Create the Junction Table (project_category) for Many-to-Many Relationship
-- ==========================================================================
CREATE TABLE public.project_category (
    project_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (project_id, category_id),
    CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES public.project(project_id) ON DELETE CASCADE,
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON DELETE CASCADE
);

-- ==========================================================================
-- 3. Insert Initial Categories
-- ==========================================================================
INSERT INTO public.category (name) 
VALUES 
('Community Service'), 
('Educational'), 
('Environmental'), 
('Health and Wellness');

-- ==========================================================================
-- 4. Associate Each Existing Project with At Least One Category
-- (Assuming your 15 sample projects have project_ids 1 through 15)
-- ==========================================================================
INSERT INTO public.project_category (project_id, category_id)
VALUES
(1, 1),  -- Project 1 -> Community Service
(2, 1),  -- Project 2 -> Community Service
(3, 1),  -- Project 3 -> Community Service
(4, 1),  -- Project 4 -> Community Service
(5, 1),  -- Project 5 -> Community Service
(6, 1),  -- Project 6 -> Community Service (Food Drive)
(7, 3),  -- Project 7 -> Environmental (Soil Turning)
(8, 3),  -- Project 8 -> Environmental (Irrigation Setup)
(9, 3),  -- Project 9 -> Environmental (Fruit Tree Pruning)
(10, 3), -- Project 10 -> Environmental (Winter Prep)
(11, 2), -- Project 11 -> Educational (Tutoring)
(12, 4), -- Project 12 -> Health and Wellness (Senior Meals)
(13, 2), -- Project 13 -> Educational (Backpacks)
(14, 1), -- Project 14 -> Community Service (Coat Sorting)
(15, 1); -- Project 15 -> Community Service (Gift Wrapping)
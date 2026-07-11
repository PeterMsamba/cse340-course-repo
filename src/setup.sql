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


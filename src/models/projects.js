import db from './db.js'; // Imports your database connection

/**
 * Fetch all service projects belonging to a specific organization ID
 */
const getProjectsByOrganizationId = async (organization_id) => {
    const query = `
        SELECT project_id, title, description, location, date
        FROM public.project
        WHERE organization_id = $1
        ORDER BY date ASC;
    `;
    const result = await db.query(query, [organization_id]);
    return result.rows;
};

/**
 * Fetch the next N upcoming service projects from the database
 * where the project date is greater than or equal to today.
 */
const getUpcomingProjects = async (number_of_projects) => {
    const query = `
        SELECT p.project_id, p.title, p.description, p.location, p.date, 
               p.organization_id, o.name AS organization_name
        FROM public.project p
        INNER JOIN public.organization o ON p.organization_id = o.organization_id
        WHERE p.date >= CURRENT_DATE
        ORDER BY p.date ASC
        LIMIT $1;
    `;
    const result = await db.query(query, [number_of_projects]);
    return result.rows;
};

/**
 * Fetch details of a single service project by its ID
 */
const getProjectDetails = async (id) => {
    const query = `
        SELECT p.project_id, p.title, p.description, p.location, p.date, 
               p.organization_id, o.name AS organization_name
        FROM public.project p
        INNER JOIN public.organization o ON p.organization_id = o.organization_id
        WHERE p.project_id = $1;
    `;
    const result = await db.query(query, [id]);
    return result.rows[0];
};

/**
 * Fetch all service projects
 */
const getAllProjects = async () => {
    const query = `
        SELECT p.project_id, p.title, p.description, p.location, p.date, o.name AS organization_name
        FROM public.project p
        INNER JOIN public.organization o ON p.organization_id = o.organization_id
        ORDER BY p.date ASC;
    `;
    const result = await db.query(query);
    return result.rows;
};

//Make sure ALL four functions are exported here!
export { 
    getAllProjects, 
    getUpcomingProjects, 
    getProjectDetails, 
    getProjectsByOrganizationId 
};
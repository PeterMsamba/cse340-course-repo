import db from './db.js';

/**
 * 1. Fetch details of a single category by its ID
 */
const getCategoryDetails = async (id) => {
    const query = `
        SELECT category_id, name
        FROM public.category
        WHERE category_id = $1;
    `;
    const result = await db.query(query, [id]);
    return result.rows[0];
};

/**
 * 2. Fetch all service projects tagged with a specific category ID
 */
const getProjectsByCategoryId = async (category_id) => {
    const query = `
        SELECT p.project_id, p.title, p.description, p.location, p.date
        FROM public.project p
        INNER JOIN public.project_category pc ON p.project_id = pc.project_id
        WHERE pc.category_id = $1
        ORDER BY p.date ASC;
    `;
    const result = await db.query(query, [category_id]);
    return result.rows;
};

/**
 * 3. Fetch all categories assigned to a specific project ID
 */
const getCategoriesByProjectId = async (project_id) => {
    const query = `
        SELECT c.category_id, c.name
        FROM public.category c
        INNER JOIN public.project_category pc ON c.category_id = pc.category_id
        WHERE pc.project_id = $1
        ORDER BY c.name ASC;
    `;
    const result = await db.query(query, [project_id]);
    return result.rows;
};

/**
 * Fetch all categories
 */
const getAllCategories = async () => {
    const query = `
        SELECT category_id, name
        FROM public.category
        ORDER BY name ASC;
    `;
    const result = await db.query(query);
    return result.rows;
};

// Export all model functions
export {
    getAllCategories,
    getCategoryDetails,
    getProjectsByCategoryId,
    getCategoriesByProjectId
};
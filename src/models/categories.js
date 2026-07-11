import db from './db.js'; // Imports your database connection wrapper

/**
 * Fetch all categories from the database, ordered alphabetically.
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

export { getAllCategories };
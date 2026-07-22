import { 
    getAllCategories, 
    getCategoryDetails, 
    getProjectsByCategoryId 
} from '../models/categories.js';

const showCategoriesPage = async (req, res) => {
    try {
        const categories = await getAllCategories();
        const title = 'Service Categories';
        res.render('categories', { title, categories });
    } catch (error) {
        console.error('Failed to retrieve categories from database:', error);
        res.status(500).send('Internal Server Error');
    }
};

/**
 * Shows detailed page for a specific category and lists its associated projects
 */
const showCategoryDetailsPage = async (req, res, next) => {
    try {
        const categoryId = req.params.id;
        
        // Retrieve category info and associated projects
        const category = await getCategoryDetails(categoryId);
        
        if (!category) {
            const err = new Error('Category Not Found');
            err.status = 404;
            return next(err);
        }

        const projects = await getProjectsByCategoryId(categoryId);
        const title = category.name;

        res.render('category', { title, category, projects });
    } catch (error) {
        console.error('Failed to render category details page:', error);
        res.status(500).send('Internal Server Error');
    }
};

export { showCategoriesPage, showCategoryDetailsPage };
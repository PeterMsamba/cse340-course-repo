// 1. Import the model function from your models directory
import { getAllCategories } from '../models/categories.js';

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

export { showCategoriesPage };
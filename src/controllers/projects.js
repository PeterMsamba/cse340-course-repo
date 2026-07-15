// 1. Import the model function from your models directory
import { getAllProjects } from '../models/projects.js';

const showProjectsPage = async (req, res) => {
    try {
        const projects = await getAllProjects();
        // Log results to console to confirm it works under the hood
        console.log("Retrieved project dataset from database:", projects);

        const title = 'Service Projects';
        res.render('projects', { title, projects });
    } catch (error) {
        console.error("Failed to render projects route via database execution:", error);
        res.status(500).send("Internal Server Error");
    }
};

export { showProjectsPage };
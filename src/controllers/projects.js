import { getUpcomingProjects, getProjectDetails } from '../models/projects.js';

const NUMBER_OF_UPCOMING_PROJECTS = 5;

// Shows the main projects page (now displaying only the next 5 upcoming projects)
const showProjectsPage = async (req, res) => {
    try {
        const projects = await getUpcomingProjects(NUMBER_OF_UPCOMING_PROJECTS);
        const title = 'Upcoming Service Projects';
        res.render('projects', { title, projects });
    } catch (error) {
        console.error("Failed to render projects route via database execution:", error);
        res.status(500).send("Internal Server Error");
    }
};

// Shows detailed page for a specific project
const showProjectDetailsPage = async (req, res, next) => {
    try {
        const projectId = req.params.id;
        const project = await getProjectDetails(projectId);

        // If the project doesn't exist, pass control to the 404 handler
        if (!project) {
            const err = new Error('Project Not Found');
            err.status = 404;
            return next(err);
        }

        const title = project.title;
        res.render('project', { title, project });
    } catch (error) {
        console.error("Failed to render project details page:", error);
        res.status(500).send("Internal Server Error");
    }
};

export { showProjectsPage, showProjectDetailsPage };
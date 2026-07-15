// Test route for 500 errors
// Added 'next' as the third parameter so Express can catch and process the error
const testErrorPage = async (req, res, next) => {
    const err = new Error('This is a test error');
    err.status = 500;
    next(err); // Works perfectly now!
};

export { testErrorPage };
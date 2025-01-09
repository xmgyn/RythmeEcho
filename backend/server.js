const http = require('http');
const url = require('url');

const MEDIA_DIR = "D:\\Work\\Play Projects\\RythmeEcho\\media";

http.createServer((req, res) => {
    const parsedUrl = url.parse(req.url, true);
    const route = parsedUrl.pathname;
    let routeHandler;
    switch (route) {
        case '/random':
            routeHandler = require('./routes/random.js'); 
            routeHandler(req, res); 
            break;
        case '/all':
            routeHandler = require('./routes/all.js'); 
            routeHandler(req, res);
            break;
        case '/history':
            routeHandler = require('./routes/history.js'); 
            routeHandler(req, res);
            break;
        case '/play':
            routeHandler = require('./routes/play.js'); 
            const query = parsedUrl.query;
            routeHandler(req, res, query);
            break;
        default:
            res.writeHead(404, { 'Content-Type': 'text/plain' }); 
            res.write('404 Not Found\n');
            res.end(); 
            break;
    } 
}).listen(4000, () => {
    console.log('Server running at http://localhost:4000/');
});

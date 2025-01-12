const http = require('http');
const url = require('url');
const path = require('path');
const fs = require('fs');

const MEDIA_DIR = "/home/mgyn/Work/RythmeEcho/media/";

http.createServer((req, res) => {
    const parsedUrl = url.parse(req.url, true);
    const route = parsedUrl.pathname;
    let routeHandler;

    if (route === '/ping') {
        res.writeHead(200).end('OK');
    }
    else if (/^\/random(\/.*)?$/.test(route)) {
        routeHandler = require('./routes/random.js');
        routeHandler(req, res);
    }
    else if (/^\/play(\/.*)?$/.test(route)) {
        routeHandler = require('./routes/play.js');
        const query = parsedUrl.query;
        routeHandler(req, res, query, MEDIA_DIR);
    }
    else if (/^\/all(\/.*)?$/.test(route)) {
        routeHandler = require('./routes/all.js');
        routeHandler(req, res);
    }
    else if (/^\/history(\/.*)?$/.test(route)) {
        // routeHandler = require('./routes/history.js'); 
        // routeHandler(req, res);
        fs.readFile(path.join(__dirname, '/routes/test.html'), (err, data) => {
            if (err) {
                res.writeHead(500, { 'Content-Type': 'text/plain' });
                console.log(err);
                res.end('Internal Server Error');
            } else {
                res.writeHead(200, { 'Content-Type': 'text/html' });
                res.end(data);
            }
        });
    }
    else {
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.write('404 Not Found\n');
        res.end();
    }
}).listen(4000, '0.0.0.0', () => {
    console.log('Server running at http://localhost:4000/');
});

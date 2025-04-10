const http = require('http');
const url = require('url');

const MEDIA_DIR = "/usr/local/bin/RythmeEcho/Media/Videos";

http.createServer((req, res) => {
    const parsedUrl = url.parse(req.url, true);
    const route = parsedUrl.pathname;
    let routeHandler;

    if (/^\/random(\/.*)?$/.test(route)) {
        routeHandler = require('./routes/random.js');
        routeHandler(req, res);
    }
    else if (/^\/play(\/.*)?$/.test(route)) {
        routeHandler = require('./routes/play.js');
        const query = parsedUrl.query;
        routeHandler(req, res, query, MEDIA_DIR);
    }
    else {
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.write('404 Not Found\n');
        res.end();
    }
}).listen(4879, () => {
    console.log('Server running at port 4879');
});

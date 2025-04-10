const fs = require('fs');
const path = require('path');

var id;

module.exports = function(req, res, query, MEDIA_DIR) {
    const url = req.url;
    if (query.id) { 
        id = query.id;
        res.writeHead(200);
        res.end();
    }
    else if (url === '/play/manifest.mpd') {
        res.writeHead(200, { 'Content-Type': 'application/dash+xml' });
        fs.createReadStream(path.join(MEDIA_DIR, `media/${id}/manifest.mpd`)).pipe(res);
    } 
    else if (url.endsWith('.m4s') || url.endsWith('.mp4') || url.endsWith('.webm')) {
        const segmentPath = path.join(MEDIA_DIR, `media/${id}/`, url.replace('/play/', ''));
        res.writeHead(200, { 'Content-Type': 'video/mp4' });
        fs.createReadStream(segmentPath).pipe(res);
    } 
    else {
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.end('Not Found');
    }
}
module.exports = function(req, res) {
    let content = {
        1: {
            'id': "",
            'thumbnail': "",
            'loop': ""
        },
        2: {
            'id': "",
            'thumbnail': "",
            'loop': ""
        },
        3: {
            'id': "",
            'thumbnail': "",
            'loop': ""
        },
        4: {
            'id': "",
            'thumbnail': "",
            'loop': ""
        }
    }

    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.write(JSON.stringify(content));
    res.end();
};

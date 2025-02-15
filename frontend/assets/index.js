var data;
var current = 0;
var max;

const videoRef = document.getElementById('videoPlayer');
const loader = document.getElementById('loader');
const queue = document.querySelector('.queue');

function handleKeydown(event) {
    var command;
    switch (event.keyCode) {
        case 37: // ArrowLeft
            command = "ArrowLeft";
            break;
        case 39: // ArrowRight
            command = "ArrowRight";
            break;
        case 40: // ArrowDown
            command = "ArrowDown";
            break;
        case 38: // ArrowUp
            command = "ArrowUp";
            break;
        case 13: // Enter
            command = "Enter";
            break;
        default:
            break;
    }
}

function errorNotify(message) {

}

function setLoading(status) {
    loader.style.display = (status) ? 'block' : 'none';
};

function setController(element) {
    if (element === "queue") {
        data.forEach(element => {
            const blockDiv = document.createElement('div');
            blockDiv.className = 'block';
            const titleDiv = document.createElement('div');
            titleDiv.className = 'title';
            titleDiv.textContent = element["song_title"];
            const artistDiv = document.createElement('div');
            artistDiv.className = 'artist';
            artistDiv.textContent = element["artist"];
            blockDiv.appendChild(titleDiv);
            blockDiv.appendChild(artistDiv);
            queue.appendChild(blockDiv);
        });
    }
}

function setVideo(video) {
    videoRef.src = `http://rythmebox.mrigyn.shop/play?id=${video["_id"]}`;
    fetch(`http://rythmebox.mrigyn.shop/play?id=${video["_id"]}`)
        .then(response => {
            if (response.status === 200) {
                const player = dashjs.MediaPlayer().create();
                player.initialize(videoRef, `http://rythmebox.mrigyn.shop/play/manifest.mpd`, true);
            } else {
                throw new Error('Video not found');
            }
        })
        .catch(error => {
            errorNotify(`Error While Fetching Video : ${error}`);
        });
};

document.addEventListener('DOMContentLoaded', async () => {
    try {
        const response = await fetch("http://rythmebox.mrigyn.shop/random");
        const result = await response.json();
        data = result;
        setController("queue");
        max = Object.values(result).length;
        setVideo(result[current]);
    } catch (error) {
        errorNotify(`Error While Fetching Data : ${error}`);
    }

    videoRef.addEventListener('loadeddata', () => setLoading(false));
    videoRef.addEventListener('waiting', () => setLoading(true));
    videoRef.addEventListener('stalled', () => setLoading(true));
    videoRef.addEventListener('play', () => setLoading(false));
    videoRef.addEventListener('pause', () => setLoading(false));
    videoRef.addEventListener('abort', () => setLoading(true));
    videoRef.addEventListener('emptied', () => setLoading(true));
    videoRef.addEventListener('error', () => setLoading(true));
    videoRef.addEventListener('suspend', () => setLoading(true));
    videoRef.addEventListener('ended', () => setVideo(data[(++current) % max]));
});

document.addEventListener('keypress', (event) => {
    if (event.key === 'p') {
        if (videoRef.paused) {
            videoRef.play();
        } else {
            videoRef.pause();
        }
    }
});

window.addEventListener('beforeunload', () => {
    videoRef.removeEventListener('loadeddata', () => setLoading());
})
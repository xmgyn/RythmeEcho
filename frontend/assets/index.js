var data;

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

    document.getElementById("hello").textContent = command;
}

document.addEventListener('DOMContentLoaded', async() => {
    try {
        const response = await fetch("http://rythmebox.mrigyn.shop/random");
        const result = await response.json();
        data = result;
        setVideo(result[0]);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
});


function setVideo(video) {
    const videoRef = document.getElementById('videoPlayer');
    videoRef.src = `http://rythmebox.mrigyn.shop/play?id=${video["_id"]}`; // Assuming 'video' has a 'url' property


    const loader = document.getElementById('loader');

    const setLoading = (loading) => {
        loader.style.display = loading ? 'block' : 'none';
    };

    const initializePlayer = (videoId) => {
        fetch(`http://rythmebox.mrigyn.shop/play?id=${videoId}`)
            .then(response => {
                if (response.status === 200) {
                    return ""; // response.json();
                } else {
                    throw new Error('Video not found');
                }
            })
            .then(() => {
                // Initialize dash.js player
                const player = dashjs.MediaPlayer().create();
                player.initialize(videoRef, `http://rythmebox.mrigyn.shop/play/manifest.mpd`, true);
                setLoading(false);
            })
            .catch(error => {
                console.error('Error:', error);
                setLoading(false);
            });
    };

    initializePlayer(video["_id"]);

    videoRef.addEventListener('loadeddata', () => setLoading(false));
    videoRef.addEventListener('play', () => setLoading(false));
    videoRef.addEventListener('pause', () => setLoading(false));

    // Cleanup event listeners when necessary
    window.addEventListener('beforeunload', () => {
        videoRef.removeEventListener('loadeddata', () => setLoading(false));
        videoRef.removeEventListener('play', () => setLoading(false));
        videoRef.removeEventListener('pause', () => setLoading(false));
    })
};
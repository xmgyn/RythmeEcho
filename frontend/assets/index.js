var data;
var current = 0;
var max;
var fadeTimeout;
var fadeTimeoutError;
var player;
var queueitems;
var controllerIsLive = false;

const videoRef = document.getElementById('videoPlayer');
const loader = document.getElementById('loader');
const queue = document.querySelector('.queue');
const controller = document.querySelector('.controller');
const error = document.getElementById('Error');

function handleKeydown(event) {

    let currentSelect = Array.from(queueitems).findIndex(item => item.classList.contains('select'));

    // Clear any existing fade timeout
    clearTimeout(fadeTimeout);

    var command;
    switch (event.keyCode) {
        case 37: // ArrowLeft
            if (current > 0) setVideo(data[(--current) % max])
            break;
        case 39: // ArrowRight
            setVideo(data[(++current) % max])
            break;
        case 40: // ArrowDown
        	controller.style.display = 'block';
            controllerIsLive = true;
            if (currentSelect !== -1 && currentSelect < queueitems.length - 1) {
                queueitems[currentSelect].classList.remove('select');
                queueitems[++currentSelect].classList.add('select');
            } else if (currentSelect === -1) {
                queueitems[0].classList.add('select');
            }
            queueitems[currentSelect].scrollIntoView({
                behavior: 'smooth',
                block: 'center'
            });
            break;
        case 38: // ArrowUp
        	controller.style.display = 'block';
            controllerIsLive = true;
            if (currentSelect > 0) {
                queueitems[currentSelect].classList.remove('select');
                queueitems[--currentSelect].classList.add('select');
            }
            queueitems[currentSelect].scrollIntoView({
                behavior: 'smooth',
                block: 'center'
            });
            break;
        case 13: // Enter
            if (controllerIsLive) {
                setVideo(data[currentSelect % max]);
                current = currentSelect;
            } else {
                if (videoRef.paused) {
                    videoRef.play();
                } else {
                    videoRef.pause();
                    return;
                }
            }
            break;
        case 10009: // Return
            if (controllerIsLive) {
            	controller.style.display = 'none';
                controllerIsLive = false;
                return;
            } 
            break;
        default:
            break;
    }

    // Set a new fade timeout
    fadeTimeout = setTimeout(() => {
        controller.style.display = 'none';
        controllerIsLive = false;
    }, 6000);
}

function errorNotify(message) {
	error.style.display = 'flex';
	clearTimeout(fadeTimeoutError);
	document.getElementById('message').innerText = message;
	fadeTimeoutError = setTimeout(() => {
		error.style.display = 'none';
    }, 15000);
}

function markActive(title) {
    queueitems.forEach(element => {
        if (element.textContent.includes(title)) {
            element.classList.add('active');
            element.classList.add('select');
            element.scrollIntoView({
                behavior: 'smooth',
                block: 'center'
            });
        } else {
            element.classList.remove('active');
            element.classList.remove('select');
        }
    });
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
            queueitems = document.querySelectorAll('.block');
        });
    }
}

function setVideo(video) {
    fetch(`http://rythmebox.mrigyn.shop/play?id=${video["_id"]}`)
        .then(response => {
            if (response.status === 200) {
                player.initialize(videoRef, `http://rythmebox.mrigyn.shop/play/manifest.mpd`, true);
                markActive(video["song_title"]);
            } else {
                throw new Error('Video not found');
            }
        })
        .catch(error => {
            errorNotify(`Error While Fetching Video : ${error}`);
        });
};

document.addEventListener('DOMContentLoaded', async() => {
    try {
        const response = await fetch("http://rythmebox.mrigyn.shop/random");
        const result = await response.json();
        data = result;
        setController("queue");
        max = Object.values(result).length;
        player = dashjs.MediaPlayer().create();
        setVideo(result[current]);
    } catch (error) {
        errorNotify(`Error While Fetching Data : ${error}`);
    }

    videoRef.addEventListener('loadeddata', () => setLoading(false));
    videoRef.addEventListener('waiting', () => setLoading(true));
    videoRef.addEventListener('stalled', () => setLoading(true));
    videoRef.addEventListener('play', () => setLoading(false));
    videoRef.addEventListener('pause', () => setLoading(false));
    videoRef.addEventListener('ended', () => setVideo(data[(++current) % max]));
    
    //videoRef.addEventListener('abort', () => setLoading(true));
    //videoRef.addEventListener('emptied', () => setLoading(true));
    //videoRef.addEventListener('error', () => setLoading(true));
    //videoRef.addEventListener('suspend', () => setLoading(true));
});

window.addEventListener('beforeunload', () => {
    videoRef.removeEventListener('loadeddata', () => setLoading());
    // Other Unloading Jobs
})
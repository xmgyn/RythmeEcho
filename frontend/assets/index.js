var data;
var current = 0;
var max;
var fadeTimeout;
var fadeTimeoutError;
var statusTimeout;
var statusTimeoutError;
var player;
var queueitems;
var controllerIsLive = false;

const videoRef = document.getElementById('videoPlayer');
const loader = document.getElementById('loader');
const queue = document.querySelector('.queue');
const controller = document.querySelector('.controller');
const status = document.querySelector('.status');
const error = document.getElementById('Error');

function handleKeydown(event) {
	let debounceTimeout;
	let debounceDelay = 500; 

	function debounceEvent(callback, delay) {
	    clearTimeout(debounceTimeout);
	    debounceTimeout = setTimeout(callback, delay);
	}

    let currentSelect = Array.from(queueitems).findIndex(item => item.classList.contains('select'));

    // Clear any existing fade timeout
    clearTimeout(fadeTimeout);

    var command;
    switch (event.keyCode) {
        case 427: // ChannelUp
        	status.style.display = 'none';
        	++current;
        	debounceEvent(() => setVideo(data[(current) % max]), debounceDelay);
            break;
        case 428: // ChannelDown
        	status.style.display = 'none';
            if (current > 0) --current
            debounceEvent(() => setVideo(data[(current) % max]), debounceDelay);
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
        case 39: // ArrowRight
        	clearTimeout(statusTimeout);
        	clearTimeout(fadeTimeout);
        	if (controllerIsLive) {
        		controller.style.display = 'none';
                controllerIsLive = false;
        	}
        	status.innerHTML = `<svg fill="#f91eb4" viewBox="0 0 32 32" version="1.1" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <title>forward</title> <path d="M0 24q0 0.544 0.288 1.056t0.768 0.736q0.48 0.256 1.056 0.224t0.992-0.32l12-8q0.896-0.608 0.896-1.696t-0.896-1.632l-12-8q-0.448-0.32-0.992-0.352t-1.056 0.224q-0.48 0.256-0.768 0.736t-0.288 1.024v16zM16 24q0 0.544 0.288 1.056t0.768 0.736q0.48 0.256 1.056 0.224t0.992-0.32l12-8q0.896-0.608 0.896-1.696t-0.896-1.632l-12-8q-0.448-0.32-0.992-0.352t-1.056 0.224q-0.48 0.256-0.768 0.736t-0.288 1.024v16z"></path> </g></svg>`;
        	status.style.display = 'flex';
        	videoRef.currentTime += 10;
        	statusTimeout = setTimeout(() => {
        		status.style.display = 'none';
            }, 6000);
        	return;
        	break;
        case 37: // ArrowLeft
        	clearTimeout(statusTimeout);
        	clearTimeout(fadeTimeout);
        	if (controllerIsLive) {
        		controller.style.display = 'none';
                controllerIsLive = false;
        	}
        	status.innerHTML = `<svg fill="#f91eb4" viewBox="0 0 32 32" version="1.1" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <title>backward</title> <path d="M0 16q0 1.12 0.896 1.664l12 8q0.448 0.32 0.992 0.352t1.056-0.224q0.48-0.288 0.768-0.768t0.288-1.024v-16q0-0.544-0.288-1.024t-0.768-0.736-1.056-0.224-0.992 0.32l-12 8q-0.896 0.608-0.896 1.664zM16 16q0 1.12 0.896 1.664l12 8q0.448 0.32 0.992 0.352t1.056-0.224q0.48-0.288 0.768-0.768t0.288-1.024v-16q0-0.544-0.288-1.024t-0.768-0.736-1.056-0.224-0.992 0.32l-12 8q-0.896 0.608-0.896 1.664z"></path> </g></svg>`;
        	status.style.display = 'flex';
        	videoRef.currentTime -= 10;
        	statusTimeout = setTimeout(() => {
        		status.style.display = 'none';
            }, 6000);
        	return;
        	break;
        case 458: // ChannelList
        	controller.style.display = 'block';
            controllerIsLive = true;
            if (currentSelect === -1) {
                queueitems[0].classList.add('select');
            }
            queueitems[currentSelect].scrollIntoView({
                behavior: 'smooth',
                block: 'center'
            });
            break;
        case 13: // Enter
        	clearTimeout(statusTimeout);
            if (controllerIsLive) {
            	status.style.display = 'none';
                setVideo(data[currentSelect % max]);
                current = currentSelect;
            } else {
                if (videoRef.paused) {
                	status.innerHTML = `
                	<svg fill="#f91eb4" viewBox="0 0 32 32" version="1.1" xmlns="http://www.w3.org/2000/svg" stroke="#f91eb4"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <title>play</title> <path d="M5.92 24.096q0 1.088 0.928 1.728 0.512 0.288 1.088 0.288 0.448 0 0.896-0.224l16.16-8.064q0.48-0.256 0.8-0.736t0.288-1.088-0.288-1.056-0.8-0.736l-16.16-8.064q-0.448-0.224-0.896-0.224-0.544 0-1.088 0.288-0.928 0.608-0.928 1.728v16.16z"></path> </g></svg>
                	`;
                	status.style.display = 'flex';
                    videoRef.play();
                } else {
                	status.innerHTML = `<svg viewBox="-1 0 8 8" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" fill="#f91eb4" stroke="#f91eb4" style="
                	    height: 50%;
                	"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <title>pause [#1010]</title> <desc>Created with Sketch.</desc> <defs> </defs> <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g id="Dribbble-Light-Preview" transform="translate(-67.000000, -3765.000000)" fill="#f91eb4"> <g id="icons" transform="translate(56.000000, 160.000000)"> <path d="M11,3613 L13,3613 L13,3605 L11,3605 L11,3613 Z M15,3613 L17,3613 L17,3605 L15,3605 L15,3613 Z" id="pause-[#1010]"> </path> </g> </g> </g> </g></svg>
`;
                	status.style.display = 'flex';
                    videoRef.pause();
                    return;
                }
            }
            statusTimeout = setTimeout(() => {
        		status.style.display = 'none';
            }, 6000);
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
    fetch(`http://192.168.0.110:4879/play?id=${video["_id"]}`)
        .then(response => {
            if (response.status === 200) {
                player.initialize(videoRef, 'http://192.168.0.110:4879/play/manifest.mpd', true);
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
	tizen.tvinputdevice.registerKeyBatch(['ChannelUp', 'ChannelDown', 'Guide' ]); 
    try {
        const response = await fetch('http://192.168.0.110:4879/random');
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
    videoRef.addEventListener('seeked', () => setLoading(false));
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
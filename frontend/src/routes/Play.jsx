import { createEffect, createSignal, onCleanup } from 'solid-js';
import { useRef } from 'solid-js/web';
import Controller from './../components/controller';
import PingComponent from './../components/ping';

const Play = () => {
  let videoRef;
  const [loading, setLoading] = createSignal(true);
  const [controlsVisible, setControlsVisible] = createSignal(true);

  const handleMouseMove = () => {
    setControlsVisible(true);
    clearTimeout(window.fadeTimeout);
    window.fadeTimeout = setTimeout(() => setControlsVisible(false), 2000);
  };

  const MySVG = () => (
    <svg
      style={{
        left: '50%',
        top: '50%',
        position: 'absolute',
        transform: 'translate(-50%, -50%) matrix(1, 0, 0, 1, 0, 0)',
      }}
      preserveAspectRatio="xMidYMid meet"
      viewBox="0 0 187.3 93.7"
      height="300px"
      width="400px"
    >
      <path
        d="M93.9,46.4c9.3,9.5,13.8,17.9,23.5,17.9s17.5-7.8,17.5-17.5s-7.8-17.6-17.5-17.5c-9.7,0.1-13.3,7.2-22.1,17.1 c-8.9,8.8-15.7,17.9-25.4,17.9s-17.5-7.8-17.5-17.5s7.8-17.5,17.5-17.5S86.2,38.6,93.9,46.4z"
        strokeMiterlimit="10"
        strokeLinejoin="round"
        strokeLinecap="round"
        strokeWidth="4"
        fill="none"
        id="outline"
        stroke="#4E4FEB"
      ></path>
      <path
        d="M93.9,46.4c9.3,9.5,13.8,17.9,23.5,17.9s17.5-7.8,17.5-17.5s-7.8-17.6-17.5-17.5c-9.7,0.1-13.3,7.2-22.1,17.1 c-8.9,8.8-15.7,17.9-25.4,17.9s-17.5-7.8-17.5-17.5s7.8-17.5,17.5-17.5S86.2,38.6,93.9,46.4z"
        strokeMiterlimit="10"
        strokeLinejoin="round"
        strokeLinecap="round"
        strokeWidth="4"
        stroke="#4E4FEB"
        fill="none"
        opacity="0.05"
        id="outline-bg"
      ></path>
    </svg>
  );

  createEffect(() => {
    const videoElement = videoRef;
    if (videoElement) {
      videoElement.style.width = '100%';
      videoElement.style.height = '100%';
      videoElement.style.objectFit = 'cover';
      videoElement.controls = false;
      videoElement.onplaying = () => setLoading(false);
      videoElement.onwaiting = () => setLoading(true);
      videoElement.play();
    }
    window.addEventListener('mousemove', handleMouseMove);
    onCleanup(() => window.removeEventListener('mousemove', handleMouseMove));
  });

  return (
    <div style={{ width: '100vw', height: '100vh', margin: 0, overflow: 'hidden', position: 'relative' }}>
      <h1 style={{ display: 'none' }}>Play Page</h1>
      {loading() && (
        <div style={{ position: 'absolute', top: '50%', left: '50%', transform: 'translate(-50%, -50%)', zIndex: 1 }}>
          <div className="loader"><MySVG /></div>
        </div>
      )}
      <div className='ping-component' style={{ position: 'absolute', top: '10px', left: '10px' }}>
        <PingComponent />
      </div>
      <video ref={videoRef} style={{ width: '100%', height: '100%' }}>
        <source src="../temp/1.mp4" type="video/mp4" />
        Your browser does not support the video tag.
      </video>
    </div>
  );
};

export default Play;
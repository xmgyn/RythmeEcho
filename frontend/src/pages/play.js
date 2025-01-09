// pages/play.js
import { useEffect, useRef } from 'react';
import Controller from '@/components/controller';

export default function Play() {
  const videoRef = useRef(null);

  useEffect(() => {
    const videoElement = videoRef.current;
    if (videoElement) {
      videoElement.style.width = '100%';
      videoElement.style.height = '100%';
      videoElement.style.objectFit = 'cover'; // Ensures the video covers the entire area
    }
  }, []);

  return (
    <div style={{ width: '100vw', height: '100vh', margin: 0 }}>
      <h1 style={{ display: 'none' }}>Play Page</h1> {/* Hiding the heading */}
      <video ref={videoRef} style={{ width: '100%', height: '100%' }}>
        <source src="../temp/1.mp4" type="video/mp4" />
        Your browser does not support the video tag.
      </video>
      <Controller />
    </div>
  );
}

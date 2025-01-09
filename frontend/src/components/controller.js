import { useEffect, useRef, useState } from 'react';

export default function Controller({ src }) {
  const videoRef = useRef(null);
  const [visible, setVisible] = useState(true);
  let timeoutId = useRef(null);

  const handleMouseMove = () => {
    if (timeoutId.current) {
      clearTimeout(timeoutId.current);
    }
    setVisible(true);
    timeoutId.current = setTimeout(() => setVisible(false), 3000); // Hide after 3 seconds of inactivity
  };

  useEffect(() => {
    window.addEventListener('mousemove', handleMouseMove);
    return () => window.removeEventListener('mousemove', handleMouseMove);
  }, []);

  return (
    <div className="w-screen h-screen flex items-center justify-center bg-black relative">
      <div
        className={`absolute inset-0 transition-opacity duration-500 ${
          visible ? 'opacity-100' : 'opacity-0'
        }`}
      ></div>
    </div>
  );
}

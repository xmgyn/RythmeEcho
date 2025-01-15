import { useEffect, useState } from 'react';

const PingComponent = () => {
  const [status, setStatus] = useState('Status: Disconnected');
  const [pingTime, setPingTime] = useState(null);

  const pingServer = async () => {
    const start = Date.now();
    try {
      const response = await fetch('http://localhost:4000/ping');
      if (response.ok) {
        const end = Date.now();
        const time = end - start;

        setStatus('Status: Connected');
        setPingTime(time);
      } else {
        setStatus('Status: Disconnected');
        setPingTime(null);
      }
    } catch (error) {
      setStatus('Status: Disconnected');
      setPingTime(null);
    }
  };

  useEffect(() => {
    const intervalId = setInterval(pingServer, 1000); 
    return () => clearInterval(intervalId);
  }, []);

  return (
    <div>
        <div class="notiglow"></div>
        <div class="notiborderglow"></div>
        <div class="notititle">{status} {pingTime !== null && `time: ${pingTime}ms`}</div>\
    </div>
  );
};

export default PingComponent;

import { createSignal, createEffect, onCleanup } from 'solid-js';

const PingComponent = () => {
  const [status, setStatus] = createSignal('Status: Disconnected');
  const [pingTime, setPingTime] = createSignal(null);

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

  createEffect(() => {
    const intervalId = setInterval(pingServer, 1000);
    onCleanup(() => clearInterval(intervalId));
  });

  return (
    <div>
      <div class="notiglow"></div>
      <div class="notiborderglow"></div>
      <div class="notititle">{status()} {pingTime() !== null && `time: ${pingTime()}ms`}</div>
    </div>
  );
};

export default PingComponent;
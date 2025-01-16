import { createSignal, createEffect, onCleanup } from 'solid-js';
import { onMount } from 'solid-js';

const Controller = ({ src }) => {
  let videoRef;
  const [visible, setVisible] = createSignal(true);
  let timeoutId;

  const handleMouseMove = () => {
    if (timeoutId) {
      clearTimeout(timeoutId);
    }
    setVisible(true);
    timeoutId = setTimeout(() => setVisible(false), 3000); // Hide after 3 seconds of inactivity
  };

  onMount(() => {
    window.addEventListener('mousemove', handleMouseMove);
    onCleanup(() => window.removeEventListener('mousemove', handleMouseMove));
  });

  return (
    <div class="w-screen h-screen flex items-center justify-center bg-black relative">
      <div
        class={`absolute inset-0 transition-opacity duration-500 ${
          visible() ? 'opacity-100' : 'opacity-0'
        }`}
      ></div>
    </div>
  );
};

export default Controller;

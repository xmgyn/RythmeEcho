function handleKeydown(event) {
    switch (event.keyCode) {
      case tizen.tvinputdevice.getKey('ArrowLeft').code: //10252
        document.getElementById('body').style.background = 'purple';
        break;
  
      case tizen.tvinputdevice.getKey('ArrowUp').code: //403
        document.getElementById('body').style.background = 'green';
        break;
      case tizen.tvinputdevice.getKey('ArrowDown').code: //403
        document.getElementById('body').style.background = 'blue';
        break;
      case tizen.tvinputdevice.getKey('ArrowRight').code: //403
        document.getElementById('body').style.background = 'cyan';
        break;
      case tizen.tvinputdevice.getKey('VolumeUp').code: //403
        document.getElementById('body').style.background = 'red';
        break;
      case tizen.tvinputdevice.getKey('VolumeDown').code: //403
        document.getElementById('body').style.background = 'white';
        break;
      case tizen.tvinputdevice.getKey('VolumeMute').code: //403
        document.getElementById('body').style.background = 'yellow';
        break;
      case tizen.tvinputdevice.getKey('Enter').code: //403
        document.getElementById('body').style.background = 'orange';
        break;
      case tizen.tvinputdevice.getKey('Back').code: //403
        document.getElementById('body').style.background = 'DeepSkyBlue';
        break;
      default:
        break;
    }
  }

const Home = (props) => {
    return (
        <>
            { props.children }
        </>
    );
};

export default Home;  
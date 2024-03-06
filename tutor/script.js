function createAudio(src) {
  const audio = document.createElement('audio');
  const source = document.createElement('source');
  source.src = src;
  source.type = 'audio/mpeg'
  audio.style.display = 'none';
  audio.appendChild(source);
  return audio;
}

const success = createAudio('https://github.com/matheuscdd/options/raw/main/tutor/aleluia.mp3')
const fail = createAudio('');

let tax = false;
function verifyTax() {
  const old = tax;
  const container = document.querySelector('.dynamic-rate-box');
  if (!container) return;

  tax = container.innerText.includes('Redação');
  if (tax !== old) tax ? success.play() : fail.play();
  setTimeout(() => verifyTax(), 1000 * 1000)
}
setTimeout(() => verifyTax(), 20 * 1000);
console.log('executou')
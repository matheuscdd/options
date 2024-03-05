const audio = document.createElement('audio');
const source = document.createElement('source');
source.src = 'https://github.com/matheuscdd/options/raw/main/tutor/aleluia.mp3';
source.type = 'audio/mpeg'
audio.style.display = 'none';
audio.appendChild(source);

function verifyTax() {
  const container = document.querySelector('.dynamic-rate-box');
  if (!container) return;
  if (container.innerText.includes('Redação')) audio.play();
  setTimeout(() => verifyTax(), 30 * 1000)
}
setTimeout(() => verifyTax(), 20 * 1000);
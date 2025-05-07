const gif = document.getElementById('hacking-car-gif');
const dropdown = document.getElementById('hacking-car-dropdown');

gif.addEventListener('click', function () {
    if (dropdown.style.display === 'block') {
        dropdown.style.opacity = '0';
        setTimeout(() => {
            dropdown.style.display = 'none';
        }, 500);
    } else {
        dropdown.style.display = 'block';
        setTimeout(() => {
            dropdown.style.opacity = '1';
        }, 10);
    }
});

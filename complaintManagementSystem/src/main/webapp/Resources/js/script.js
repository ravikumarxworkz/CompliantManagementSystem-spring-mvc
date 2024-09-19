/**
 * 
 */
function sendOtp() {
    const email = document.getElementById('email').value;
    if (!validateEmail(email)) {
        alert('Please enter a valid email address');
        return;
    }
    // Ajax call to send OTP
    alert('OTP sent to ' + email);
}

function getCurrentAddress() {
    // Use Geolocation API to get current address
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
    } else {
        alert("Geolocation is not supported by this browser.");
    }
}

function showPosition(position) {
    // Use position.coords.latitude and position.coords.longitude to fetch address
    alert("Latitude: " + position.coords.latitude + "\nLongitude: " + position.coords.longitude);
}

function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

function loadStates(countryCode) {
    console.log("Inside loadStates - Received Country Code:", countryCode);

    if (!countryCode) {
        console.error("Country code is missing!");
        return;
    }

    $.ajax({
        url: 'https://api.countrystatecity.in/v1/countries/' + countryCode + '/states',
        method: 'GET',
        headers: {
            "X-CSCAPI-KEY": "ald3ZWVHZDNwOTZUY09KT3lLam9uQ2VkWWoyNHpBZTUwb3hjUkU0OQ=="
        },
        success: function (response) {
            console.log("States loaded for country:", countryCode);
            $('#stateFilter').empty().append(new Option("Select State", ""));
            response.forEach(state => {
                $('#stateFilter').append(new Option(state.name, state.iso2));
            });
            $('#cityFilter').empty().append(new Option("Select City", ""));
        },
        error: function (xhr, status, error) {
            console.error("Error loading states:", error);
        }
    });
}

function loadCities(stateCode) {
    const countryCode = $('#countryFilter').val();
    console.log("Selected State Code:", stateCode);

    if (!stateCode || !countryCode) {
        console.error("State code or Country code is missing!");
        return;
    }

    $.ajax({
        url: 'https://api.countrystatecity.in/v1/countries/' + countryCode + '/states/' + stateCode + '/cities',
        method: 'GET',
        headers: {
            "X-CSCAPI-KEY": "ald3ZWVHZDNwOTZUY09KT3lLam9uQ2VkWWoyNHpBZTUwb3hjUkU0OQ=="
        },
        success: function (response) {
            $('#cityFilter').empty().append(new Option("Select City", ""));
            response.forEach(city => {
                $('#cityFilter').append(new Option(city.name, city.name));
            });
        },
        error: function (xhr, status, error) {
            console.error("Error loading cities: ", error);
        }
    });
}

$(document).ready(function () {
    loadCountries();
});

function loadCountries() {
    $.ajax({
        url: 'https://api.countrystatecity.in/v1/countries',
        method: 'GET',
        headers: {
            "X-CSCAPI-KEY": "ald3ZWVHZDNwOTZUY09KT3lLam9uQ2VkWWoyNHpBZTUwb3hjUkU0OQ=="
        },
        success: function (response) {
            $('#countryFilter').empty().append(new Option("Select Country", ""));
            response.forEach(country => {
                $('#countryFilter').append(new Option(country.name, country.iso2));
            });
        },
        error: function (xhr, status, error) {
            console.error("Error loading countries: ", error);
        }
    });
}

function populateComplaintTypes() {
    $.ajax({
        url: 'http://localhost:8080/complaintManagementSystem/complaintTypes',  // Adjust URL as needed
        method: 'GET',
        dataType: 'json',
        success: function (response) {
            console.log(response);  // Inspect this to confirm the data structure
            $('#complaintTypeFilter').empty();  // Clear existing options
            $('#complaintTypeFilter').append('<option value="">Select Option</option>');  // Default option

            // Loop through the array and add each complaint type as an option
            response.forEach(type => {
                $('#complaintTypeFilter').append(new Option(type.complaintType, type.complaintType));
            });
        },
        error: function (xhr, status, error) {
            console.error("Error fetching complaint types: ", error);
        }
    });
}

// Call this function when you need to populate the dropdown
$(document).ready(function () {
    populateComplaintTypes();
});
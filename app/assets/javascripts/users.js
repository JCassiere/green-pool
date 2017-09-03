$(".users.new").ready(function() {
	$(document).ready(function() {

		var street = $("#user_street")[0];
		var city = $("#user_city")[0];
		var state = $("#user_state")[0];
		var zip = $("#user_zip_code")[0];
		var country = $("#user_country")[0];


		function getLocation() {
		  if(navigator.geolocation) {
		    navigator.geolocation.getCurrentPosition(geoSuccess, geoError);
		  } else {
		    alert("Geolocation is not supported by this browser.");
		  }
		}

		function geoSuccess(position) {
	    var lat = position.coords.latitude;
	    var lng = position.coords.longitude;
	    codeLatLng(lat, lng);
		}


		function geoError() {
	    alert("Geocoder failed.");
		}

    var geocoder = new google.maps.Geocoder();

		function codeLatLng(lat, lng) {
	    var latlng = new google.maps.LatLng(lat, lng);
	    geocoder.geocode({'latLng': latlng}, function(results, status) {
	      if(status == google.maps.GeocoderStatus.OK) {
	        if(results[1]) {
	          var addressComponents = results[0].address_components;
	          street.value = addressComponents[0].long_name + " " + addressComponents[1].short_name;
	          city.value = addressComponents[3].long_name;
	          state.value = addressComponents[5].short_name;
	          zip.value = addressComponents[7].long_name;
	          country.value = addressComponents[6].short_name;
	        } else {
	          alert("No results found");
	        }
	      } else {
	        alert("Geocoder failed due to: " + status);
	      }
	    });
		}
		getLocation();
	});
});
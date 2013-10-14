
/* Place your application-specific JavaScript functions and classes here
 This file is automatically included by javascript_include_tag :defaults */

function dragPlaceMarker(){  
   var latlng = gmarker.getLatLng().toUrlValue();  
   var tmp = latlng.split(',');  
   var px = tmp[1];  
   var py = tmp[0];  
   $('place_latitude').value = px;  
   $('place_longitude').value = py;  
}

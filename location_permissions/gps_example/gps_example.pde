/*****************************************************************************************

 Android Processing GPS example
 
 Query the phone's GPS and display the data on the screen
 
 Rolf van Gelder - v 22/02/2011 - http://cage.nl :: http://cagewebdev.com :: info@cage.nl
 
 Check the ACCESS_FINE_LOCATION permission in Sketch Permissions!
 
 *****************************************************************************************/

// Import needed Android libs
import android.content.Context;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;

// Set up the variables for the LocationManager and LocationListener
LocationManager locationManager;
MyLocationListener locationListener;

// Variables to hold the current GPS data
float currentLatitude  = 0;
float currentLongitude = 0;
float currentAccuracy  = 0;
String currentProvider = "";

// Android fonts
String[] fontList;
PFont androidFont;
Context context; 

void setup () {
  size(480, 640, P2D);
  // Sketch stays in portrait mode, even when the phone is rotated
  orientation(PORTRAIT);
  // Select a font to use
  fontList = PFont.list();
  androidFont = createFont(fontList[0], 26, true);
  textFont(androidFont);
}

void draw()
{
  background(0);
  // Display current GPS data
  text("Latitude: "+currentLatitude, 20, 40);
  text("Longitude: "+currentLongitude, 20, 75);
  text("Accuracy: "+currentAccuracy, 20, 110);
  text("Provider: "+currentProvider, 20, 145);
}

// Override the activity class methods
void onResume() {
  super.onResume();

  context = getActivity();
  //context = surface.getActivity();
  locationListener = new MyLocationListener();
  locationManager = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);    

  // Register the listener with the Location Manager to receive location updates
  locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, locationListener);
}

void onPause() {
  super.onPause();
  //locationManager.removeGpsStatusListener(locationListener);
}

/*****************************************************************/

// Class for capturing the GPS data
class MyLocationListener implements LocationListener {
  // Define all LocationListener methods
  public void onLocationChanged(Location location) {
    // Save new GPS data
    currentLatitude  = (float)location.getLatitude();
    currentLongitude = (float)location.getLongitude();
    currentAccuracy  = (float)location.getAccuracy();
    currentProvider  = location.getProvider();
  }

  public void onProviderDisabled (String provider) { 
    currentProvider = "";
  }

  public void onProviderEnabled (String provider) { 
    currentProvider = provider;
  }

  public void onStatusChanged (String provider, int status, Bundle extras) {
    // Nothing yet...
  }
}
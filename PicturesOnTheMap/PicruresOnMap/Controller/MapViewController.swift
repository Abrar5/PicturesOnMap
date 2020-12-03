//
//  ViewController.swift
//  PicruresOnMap
//
//  Created by Abrar on 14/04/1442 AH.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    static var latitudeString: String = "0"
    static var longitudeString: String = "0"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    //MARK: - Map Types
    
    @IBAction func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
            
        }
    }
    
    //MARK: - Call After Updating User's Location
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //Stop Updating Location After Getting the Last Location
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            
          mapFocus(location)
           
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    
    //MARK: - Set Map's Region
    func mapFocus(_ location: CLLocation) {
        
        //Specify coordinate (latitude & longitude)
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let coordinate = CLLocationCoordinate2D(latitude: latitude,
                                                longitude: longitude)
        print("latitude: \(latitude) longitude: \(longitude)")
        
        //Pass Location(3)
//        self.locationDelegate.latitudeString = String(latitude)
//        self.locationDelegate.longitudeString = String(longitude)
        
        MapViewController.latitudeString = String(latitude)
        MapViewController.longitudeString = String(longitude)
        print("\(MapViewController.latitudeString) , \(MapViewController.longitudeString)")
        
        //set a focusede region
        let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        let region = MKCoordinateRegion(center: coordinate,
                                        span: span)
        mapView.setRegion(region, animated: true)
        
        //Add Pin Annotation
        let annotiation = MKPointAnnotation()
        annotiation.coordinate = coordinate
        mapView.addAnnotation(annotiation)

    }
    
    //MARK: - Move to Another View Controller
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        
        case "PhotosSegue":
            let photoViewController = segue.destination as! PhotosViewController
            photoViewController.store = PhotoStore()
            
        default:
            preconditionFailure("Unexpected segue identifier.")
            
        }
    }
    
}

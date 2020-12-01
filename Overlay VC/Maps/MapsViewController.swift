//
//  MapsViewController.swift
//  Overlay VC
//
//  Created by Adwait Barkale on 01/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    var delegate: mapCoordinateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    var isZoom = false
    func zoom()
    {
        let camera = MKMapCamera(lookingAtCenter: self.mapView.userLocation.coordinate, fromEyeCoordinate: self.mapView.userLocation.coordinate, eyeAltitude: 1000)
        self.mapView.setCamera(camera, animated: true)
    }
}

extension MapsViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(manager.location?.coordinate ?? "No Location")
        self.mapView.showsUserLocation = true
        //self.zoom()
        delegate?.coordinates(coordinate: manager.location!.coordinate)
        CLLocation().address(coordinate: manager.location!.coordinate) { (address) in
            print(address ?? "Not Found")
        }
    }
    
}

extension CLLocation{
    
    //    func address(coordinate : CLLocationCoordinate2D,completion : @escaping (_ add : String) -> ())
    //    {
    //        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    //        CLGeocoder().reverseGeocodeLocation(location) { (places, error) in
    //            if error == nil {
    //                completion((places?.first?.administrativeArea)!)
    //            }
    //        }
    //    }
    
    func address(coordinate : CLLocationCoordinate2D, complition : @escaping (_ add : String?) -> ()) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (places, error) in
            if let place = places?.first {
                
                var addressString : String = ""
                if place.subLocality != nil {
                    addressString = addressString + place.subLocality! + ", "
                }
                if place.thoroughfare != nil {
                    addressString = addressString + place.thoroughfare! + ", "
                }
                if place.locality != nil {
                    addressString = addressString + place.locality! + ", "
                }
                if place.country != nil {
                    addressString = addressString + place.country! + ", "
                }
                if place.postalCode != nil {
                    addressString = addressString + place.postalCode! + " "
                }
                
                complition(addressString)
            }
        }
    }
    
}

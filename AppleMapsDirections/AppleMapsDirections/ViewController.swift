//
//  ViewController.swift
//  AppleMapsDirections
//
//  Created by Josh Asbury on 5/11/21.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBAction func buttonPressed(_ sender: UIButton) {
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: -34.05, longitude: 151.15))
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Destination"
        MKMapItem.openMaps(with: [mapItem], launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault
        ])
    }
    
}

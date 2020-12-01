//
//  ViewController.swift
//  Overlay VC
//
//  Created by Adwait Barkale on 01/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit
import OverlayContainer
import CoreLocation

protocol mapCoordinateDelegate {
    func coordinates(coordinate: CLLocationCoordinate2D)
}

class ViewController: OverlayContainerViewController {
    
    var detailsController : DetailsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mapController = storyboard.instantiateViewController(withIdentifier: "MapsViewController") as! MapsViewController
        mapController.delegate = self
        detailsController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        self.viewControllers = [mapController,detailsController]
        
        self.delegate = self
    }
}

extension ViewController: OverlayContainerViewControllerDelegate {
    
    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController, heightForNotchAt index: Int, availableSpace: CGFloat) -> CGFloat {
        switch Notched.allCases[index] {
        case .minimum:
            return availableSpace * 1/9 //1/5
        case .medium:
            return availableSpace/2
        case .maximum:
            return availableSpace * 3/4
        }
    }
    
    
    func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
        return Notched.allCases.count
    }
    
    enum Notched : Int, CaseIterable{
        case minimum,medium,maximum
    }
    
}

extension ViewController: mapCoordinateDelegate{
    
    func coordinates(coordinate: CLLocationCoordinate2D) {
        print(coordinate)
        detailsController.coordinate(coordinate: coordinate)
    }
}

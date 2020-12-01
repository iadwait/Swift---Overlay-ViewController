//
//  DetailsViewController.swift
//  Overlay VC
//
//  Created by Adwait Barkale on 01/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit
import CoreLocation

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var lblLocationDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func coordinate(coordinate: CLLocationCoordinate2D)
    {
        CLLocation().address(coordinate: coordinate) { (address) in
            print(address ?? "Not Found")
            self.lblLocationDescription.text = address
        }
    }

}

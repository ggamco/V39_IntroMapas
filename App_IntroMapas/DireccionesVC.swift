//
//  DireccionesVC.swift
//  App_IntroMapas
//
//  Created by cice on 17/2/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import CoreLocation

class DireccionesVC: UIViewController {

    //MARK: - variables locales
    var locationManager = CLLocationManager()
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myLatitudLB: UILabel!
    @IBOutlet weak var myLongitudLB: UILabel!
    @IBOutlet weak var myRumboLB: UILabel!
    @IBOutlet weak var myVelocidadLB: UILabel!
    @IBOutlet weak var myAltitudLB: UILabel!
    @IBOutlet weak var myDirecciónLB: UILabel!
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        //cargamos el delegado
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DireccionesVC : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let userLocation = locations.first{
            
            myLatitudLB.text = "\(userLocation.coordinate.latitude)"
            myLongitudLB.text = "\(userLocation.coordinate.longitude)"
            myRumboLB.text = "\(userLocation.course)"
            myVelocidadLB.text = "\(userLocation.speed)"
            myAltitudLB.text = "\(userLocation.altitude)"
            
            
            CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) in
                
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    if let placemarksDes = placemarks?[0]{
                        print(placemarksDes.thoroughfare!)
                    }
                }
                
            })
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}














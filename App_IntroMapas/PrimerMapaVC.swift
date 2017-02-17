//
//  PrimerMapaVC.swift
//  App_IntroMapas
//
//  Created by cice on 17/2/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

enum MapaType : Int {
    case standard = 0
    case hibrido = 1
    case satelite = 2
}

class PrimerMapaVC: UIViewController {

    //MARK: - variables locales
    let locationManager = CLLocationManager()
    
    
    
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var mySegmentTipoMapa: UISegmentedControl!
    @IBOutlet weak var myPrimerMapa: MKMapView!
    @IBOutlet weak var myDescripcionDatos: UILabel!
    
    //MARK: - IBActions
    @IBAction func muestraMapa(_ sender: AnyObject) {
        
        //Coordenadas
        let latitud = 40.597184
        let longitud = -3.711583
        
        //Zoom
        let latDelta = 0.005
        let lonDelta = 0.005
        
        
        //Localización
        let location = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let region = MKCoordinateRegion(center: location, span: span)
        myPrimerMapa.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Estamos en clase de iOS"
        annotation.subtitle = "Aqui currando hasta las tres de la mañana"
        
        myPrimerMapa.addAnnotation(annotation)
    }
    
    
    @IBAction func muestraNuevoMapa(_ sender: AnyObject) {
        
        let mapa = MapaType(rawValue: mySegmentTipoMapa.selectedSegmentIndex)
        
        switch mapa! {
            
        case .standard:
            myPrimerMapa.mapType = MKMapType.standard
        case .hibrido:
            myPrimerMapa.mapType = MKMapType.hybrid
        case .satelite:
            myPrimerMapa.mapType = MKMapType.satellite
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegado del mapa
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        
        //Creamos un gesto de reconocimiento para crear un chincheta
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(self.muestraGR(_ :)))
        
        longPressGR.minimumPressDuration = 2 //asignamos dos segundos al gesto
        myPrimerMapa.addGestureRecognizer(longPressGR) //se lo enchufamos al mapa
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Utils
    func muestraGR(_ gesture : UIGestureRecognizer){
        
        if gesture.state == UIGestureRecognizerState.began{
            let puntoTocado = gesture.location(in: myPrimerMapa)
            let nuevaCoordenada = myPrimerMapa.convert(puntoTocado, toCoordinateFrom: myPrimerMapa)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = nuevaCoordenada
            annotation.title = "Nueva etiqueta en el mapa"
            annotation.subtitle = "Aqui seguimos currando en iOS, ya son las 4..."
            myPrimerMapa.addAnnotation(annotation)
        }
    }
    
}

extension PrimerMapaVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.first!
        
        let latitud = userLocation.coordinate.latitude
        let longitud = userLocation.coordinate.longitude
        
        let latDelta = 0.001
        let lonDelta = 0.001
        
        let location = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: location, span: span)
        myPrimerMapa.setRegion(region, animated: true)
        myDescripcionDatos.text = "\(userLocation)"
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = userLocation.coordinate
        annotation.title = "Seguimos en iOS"
        annotation.subtitle = "dando una vuelta"
        myPrimerMapa.addAnnotation(annotation)
        
        
        
        
    }
}










//
//  HakkindaViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 26.07.2023.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class HakkindaViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var aciklamaLabel: UILabel!
    var locationManager = CLLocationManager()
      var chosenLatitude = Double()
      var chosenLongitude = Double()
      
      var selectedTitle = ""
      var selectedTitleID : UUID?
      
      var annotationTitle = ""
      var annotationSubtitle = ""
      var annotationLatitude = Double()
      var annotationLongitude = Double()
    
    
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        
        
      

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        let gestureRecongnizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecongnizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecongnizer)
        
        
        
        
        
        
    }
   
    
    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer) {
          
          if gestureRecognizer.state == .began {
              
              let touchedPoint = gestureRecognizer.location(in: self.mapView)
              let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
              
              chosenLatitude = touchedCoordinates.latitude
              chosenLongitude = touchedCoordinates.longitude
              
              let annotation = MKPointAnnotation()
              annotation.coordinate = touchedCoordinates
              annotation.title = "Akasya AVM"
              annotation.subtitle = "Üsküdar/Koşuyolu"
              self.mapView.addAnnotation(annotation)
              
              
          }
          
      }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation is MKUserLocation {
                return nil
            }
            
            let reuseId = "myAnnotation"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView?.canShowCallout = true
                pinView?.tintColor = UIColor.black
                
                let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
                pinView?.rightCalloutAccessoryView = button
                
            } else {
                pinView?.annotation = annotation
            }
            
            
            
            return pinView
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if selectedTitle == "" {
            
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        } else {
                       //
                   }
       }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
           if selectedTitle != "" {
               
               let requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
               
               
               CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                   //closure
                   
                   if let placemark = placemarks {
                       if placemark.count > 0 {
                                         
                           let newPlacemark = MKPlacemark(placemark: placemark[0])
                           let item = MKMapItem(placemark: newPlacemark)
                           item.name = self.annotationTitle
                           let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                           item.openInMaps(launchOptions: launchOptions)
                                         
                   }
               }
           }
               
               
           }
       
       
       
       
       }
       
      
   

    @IBAction func araClicked(_ sender: Any) {
        
    }
    @IBAction func yolClicked(_ sender: Any) {
    }
    
}

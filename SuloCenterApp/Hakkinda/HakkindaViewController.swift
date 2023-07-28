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
import Firebase

class HakkindaViewController: UIViewController {
    
  
    @IBOutlet weak var aciklamaLabel: UITextView!
    
    var locationManager = CLLocationManager()
      var chosenLatitude = Double()
      var chosenLongitude = Double()
    let fireStoreDatabase = Firestore.firestore()
      var selectedTitle = ""
      var selectedTitleID : UUID?
    var aciklamaArray = [String]()
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
        getDataFromFirebase()
        let gestureRecongnizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecongnizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecongnizer)
        
        
        let button = UIButton(type: .system)
                
               
                button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
                view.addSubview(button)
        
        let button1 = UIButton(type: .system)
             button1.setTitle("Haritada Göster", for: .normal)
             button1.addTarget(self, action: #selector(yolClicked), for: .touchUpInside)
             button1.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
             view.addSubview(button)
        getDataFromFirebase()
        
        
    }
    
    func getDataFromFirebase (){
        let ref = Database.database().reference().child("Hakkimizda").queryOrderedByKey().observeSingleEvent(of: .value) { snapshot in
            guard let dict = snapshot.value as? [String:Any] else {
                print("error")
                return
            }
            
            let testt = dict["Aciklama"] as? String
            print(testt)
            self.aciklamaLabel.text = testt
            
        }
     
 }
    
    
    
    
    
    
    
    
    @IBAction func araClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Telefon Numarası", message: "+905437757575", preferredStyle: .alert)

             // Kopyala aksiyonunu ekle
             let copyAction = UIAlertAction(title: "Kopyala", style: .default) { (_) in
                 // Kopyalama işlemi
                 self.copyTextToClipboard("+905437757575")
             }
             alertController.addAction(copyAction)

             // Tamam aksiyonunu ekle
             let okAction = UIAlertAction(title: "Tamam", style: .default) { (_) in
                 // Tamam butonuna tıklandığında yapılacak işlemler
             }
             alertController.addAction(okAction)

             // UIAlertController'ı görüntüle
             self.present(alertController, animated: true, completion: nil)
    }
    func copyTextToClipboard(_ text: String) {
        UIPasteboard.general.string = text
    }
    
    
    
    @IBAction func yolClicked(_ sender: Any) {
        let latitude: CLLocationDegrees = 41.001957 // Belirtilen konumun enlemi
        let longitude: CLLocationDegrees = 29.054861 // Belirtilen konumun boylamı

             let regionDistance: CLLocationDistance = 10000 // 10 km yarıçaplı bir bölge oluştur

             // Kullanıcıyı harita uygulamasına yönlendirme işlemi
             let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
             let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
             let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center)]
             let placemark = MKPlacemark(coordinate: coordinates)

             let mapItem = MKMapItem(placemark: placemark)
             mapItem.name = "Hedef Konum"
             mapItem.openInMaps(launchOptions: options)
    }
    
   
}




extension HakkindaViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
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
       
      
   

}

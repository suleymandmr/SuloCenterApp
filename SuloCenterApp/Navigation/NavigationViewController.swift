//
//  NavigationViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 24.07.2023.
//

import UIKit
import MapKit
import CoreLocation
class NavigationViewController: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    var locationMenager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let latitude: CLLocationDegrees = 41.001957
        let longitude: CLLocationDegrees = 29.054861
               
               // Koordinatları CLLocationCoordinate2D türüne dönüştürün
               let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
               
               // Harita üzerindeki yükseklik seviyesini ve yatay uzaklığı tanımlayın
               let regionRadius: CLLocationDistance = 200 // 1000 metrelik yarıçap (istenilen değeri ayarlayabilirsiniz)
               let region = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
               
               // Haritayı sabitlenmiş konum ile güncelleyin
               mapView.setRegion(region, animated: true)
               
               // Konumu haritada göstermek için bir pin oluşturun ve haritaya ekleyin
               let annotation = MKPointAnnotation()
               annotation.coordinate = locationCoordinate
               annotation.title = "Hedef Konum"
               mapView.addAnnotation(annotation)
        
        
        
        
        
        
        
        
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

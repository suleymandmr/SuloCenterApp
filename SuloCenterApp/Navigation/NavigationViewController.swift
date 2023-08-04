//
//  NavigationViewController.swift
//  SuloCenterApp
//
//  Created by eyüp yaşar demir on 24.07.2023.
//

import UIKit
import MapKit
import CoreLocation
import CoreData
import SideMenu
class NavigationViewController: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    var locationMenager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let mapView = mapView else {
                print("mapview hatası")
                return
            }
        
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

}

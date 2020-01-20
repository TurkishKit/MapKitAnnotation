//
//  ViewController.swift
//  locationMap
//
//  Created by Ufuk Köşker on 14.10.2019.
//  Copyright © 2019 Ufuk Köşker. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    let XDecodeEtkinligi = MKPointAnnotation()
    let sahibindenEtkinligi = MKPointAnnotation()
    let BKNakkatasTepeEtkinligi = MKPointAnnotation()
    let kadinlarGunuEtkinligi = MKPointAnnotation()
    let WWDCEtkinligi = MKPointAnnotation()
    let kasimOzelEtkinligi = MKPointAnnotation()
    let izmirOzelEtkinligi = MKPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        configureMapView()
        configureLocationManager()
        centerMapOnUserLocation()
        addAnnotations()

    }
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        // Cihazımızın enlem ve boylam olarak konumunu aldık. ('Print(region)' fonksiyonu içerisinde yazdırabilirsiniz.)
        mapView.setRegion(region, animated: true)
    }
    
    func configureMapView() {
        mapView.showsUserLocation = true // Bool değerini 'true' yaparak cihazın konumunu haritada gösterdik.
        mapView.userTrackingMode = .follow // Cihazın konumunun harita üzerinde takibi için gerekli olan kod.
        

    }

    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func addAnnotations() {
        XDecodeEtkinligi.title = "TurkishKit"
        XDecodeEtkinligi.subtitle = "TurkishKit X-Decode Etkinliği \n SAC X-Zone (SEV Amerikan Koleji)"
        XDecodeEtkinligi.coordinate = CLLocationCoordinate2D(latitude: 41.037941, longitude: 29.266617)
        
        sahibindenEtkinligi.title = "TurkishKit"
        sahibindenEtkinligi.subtitle = "TurkishKit Sahibinden Etkinliği \n Sahibinden"
        sahibindenEtkinligi.coordinate = CLLocationCoordinate2D(latitude: 40.961218, longitude: 29.110407)
        
        BKNakkatasTepeEtkinligi.title = "TurkishKit"
        BKNakkatasTepeEtkinligi.subtitle = "TurkishKit BK Nakkaştepe Özel Etkinliği \n BK Nakkaştepe"
        BKNakkatasTepeEtkinligi.coordinate = CLLocationCoordinate2D(latitude: 41.025820, longitude: 29.042771)
        
        kadinlarGunuEtkinligi.title = "TurkishKit"
        kadinlarGunuEtkinligi.subtitle = "TurkishKit Her Kız Kodlayabilir Etkinliği \n Levent 199"
        kadinlarGunuEtkinligi.coordinate = CLLocationCoordinate2D(latitude: 41.080441, longitude: 29.010528)
        
        WWDCEtkinligi.title = "TurkishKit"
        WWDCEtkinligi.subtitle = "TurkishKit WWDC Etkinliği \n Workinton Levent 199"
        WWDCEtkinligi.coordinate = CLLocationCoordinate2D(latitude: 41.080632, longitude: 29.009998)
        
        kasimOzelEtkinligi.title = "TurkishKit"
        kasimOzelEtkinligi.subtitle = "TurkishKit Kasım Özel Etkinliği \n Levent 199"
        kasimOzelEtkinligi.coordinate = CLLocationCoordinate2D(latitude: 41.080357, longitude: 29.010119)
        
        izmirOzelEtkinligi.title = "TurkishKit"
        izmirOzelEtkinligi.subtitle = "TurkishKit İzmir Özel Etkinliği \n TED İzmir Koleji"
        izmirOzelEtkinligi.coordinate = CLLocationCoordinate2D(latitude: 38.365648, longitude: 26.830121)

        mapView.addAnnotation(XDecodeEtkinligi)
        mapView.addAnnotation(sahibindenEtkinligi)
        mapView.addAnnotation(BKNakkatasTepeEtkinligi)
        mapView.addAnnotation(kadinlarGunuEtkinligi)
        mapView.addAnnotation(WWDCEtkinligi)
        mapView.addAnnotation(kasimOzelEtkinligi)
        mapView.addAnnotation(izmirOzelEtkinligi)
        
        
    }


    @IBAction func centerOnUserLocationTapped(_ sender: UIButton) {
        centerMapOnUserLocation()
        configureMapView()
    }
    
    @IBAction func TKAnnotationsButtonTapped(_ sender: UIButton) {
        //addAnnotations()
        mapView.showAnnotations([XDecodeEtkinligi, sahibindenEtkinligi, BKNakkatasTepeEtkinligi, kadinlarGunuEtkinligi, WWDCEtkinligi, kasimOzelEtkinligi, izmirOzelEtkinligi], animated: true)
    }
    
    
    func alertFunc(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}
extension ViewController: CLLocationManagerDelegate {
    // Uygulamamızın konum servis izinleri hakkındaki bilgileri kullanıcıya gösterebileceğimiz bir fonksiyon yazdık.

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            alertFunc(title: "Uyarı!!!", message: "Kullanıcı, uygulamanın konum servislerini kullanıp kullanamayacağını seçmedi.")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            alertFunc(title: "Uyarı!!!", message: "Uygulamanın konum servislerini kullanma yetkisi yok.")
        case .denied:
            alertFunc(title: "Uyarı!!!", message: "Kullanıcı, uygulama için konum servislerinin kullanımını reddetti veya Ayarlar'da genel olarak devre dışı bırakıldı.")
        case .authorizedAlways:
            alertFunc(title: "Uyarı!!!", message: "Kullanıcı, istediği zaman konum hizmetlerini başlatması için uygulamaya izin verdi.")
        case .authorizedWhenInUse:
            alertFunc(title: "Uyarı!!!", message: "Kullanıcı, uygulama kullanımdayken konum servislerini başlatmasına izin verdi.")
        @unknown default:
            fatalError()
        }
        
        centerMapOnUserLocation()
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        //Tıpkı TaleView'deki gibi annottation'ların görüneceği zaman çalışacak olan kodumuz. Annotation'lar ekran dışına çıktığında bellekten siler ve hafızada yer açar. Annotation'lar ekranda görünmeye başladığında tekrar belleğe çağırılır ve ekrana çizilir.
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            //Bu kod bloğumuzda ise Annotation üzerine yazdığımız açıklamaların görünmesinden sorumludur.
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        //Burada kendi Annotation'umuzu oluşturduk. Annotation Görselimizi ekledik ve görsele boyut verdik.
        let pinImage = UIImage(named: "TK")
        let size = CGSize(width: 30, height: 30)
        UIGraphicsBeginImageContext(size)
        pinImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView!.image = resizedImage
        
        return annotationView
    }
}

//
//  MapVC.swift
//  MapIvannikov
//
//  Created by WSR on 22.12.2020.
//

import UIKit
import CoreLocation
import  MapKit

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    struct Points {
        var lat = 0.0
        var lon = 0.0
        var name = ""
    }
    var pointsArray: [Points] = []
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.userLocation.title = "Im here"
        mapView.userLocation.subtitle = "You found me"
        pointsPositionalCollege()
        pointsPositions()
        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "marker")
        marker.canShowCallout = true
        let infoButton = UIButton(type: .detailDisclosure)
        infoButton.addTarget(self, action: #selector(infoAction), for: .touchUpInside)
        marker.rightCalloutAccessoryView = infoButton
        marker.calloutOffset = CGPoint(x: -5, y: 5)
        return marker
    }
    @objc func infoAction() {
        print("info")
    }

    func   mapToCoordinate(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            mapToCoordinate(coordinate: location)
        }
    }
    func pointsPositionalCollege() {
        let arrayLat = [55.818176, 55.844996, 55.860595, 55.860337]
        let arrayLon = [37.496261, 37.520960, 37.492089, 37.517689]
        let arrayName = ["ЦИКТ","ЦПиРБ","ЦАВТ","ЦТЭК"]
        for i in 0..<arrayLat.count {
            pointsArray.append(Points(lat: arrayLat[i], lon: arrayLon[i], name: arrayName[i]))
        }
    }
    func pointsPositions() {
        for i in 0..<pointsArray.count {
            let point = MKPointAnnotation()
            point.title = pointsArray[i].name
            point.coordinate = CLLocationCoordinate2D(latitude: pointsArray[i].lat, longitude: pointsArray[i].lon)
            mapView.addAnnotation(point)
        }
    }

}

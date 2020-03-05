//
//  MapView.swift
//  NobelLaureatesFinder
//
//  Created by Kristina Gelzinyte on 3/4/20.
//  Copyright © 2020 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView, MKMapViewDelegate {
    
    private var routeAnnotations = [MKPointAnnotation](repeating: .init(), count: 20)
    
    private lazy var targetAnnotation: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.title = "Your location"
        mapView.addAnnotation(annotation)
        return annotation
    }()
    
    private let mapView = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mapView.delegate = self
        
        addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func coordinatesForLocation(_ location: CGPoint) -> CLLocationCoordinate2D {
        return mapView.convert(location, toCoordinateFrom: mapView)
    }
    
    func updateRegion(_ region: MKCoordinateRegion) {
        mapView.setRegion(region, animated: true)
    }
    
    func updateTargetAnnotationCoordinates(_ coordinates: CLLocationCoordinate2D) {
        targetAnnotation.coordinate = coordinates
    }
    
    func updateRouteAnnotations(_ route: [Destination]) {
        mapView.removeAnnotations(routeAnnotations)
        routeAnnotations.removeAll()

        for destination in route {
            let annotation = MKPointAnnotation()
            annotation.shouldGroupAccessibilityChildren = false
            let nobel = destination.nobelPrizeLaureate
            annotation.title = String(format: "%.0f", nobel.year) + "\n" + "\(nobel.name)"
            annotation.coordinate = nobel.location.coordinate
            
            routeAnnotations.append(annotation)
        }

        mapView.addAnnotations(routeAnnotations)
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)

        pinView.accessibilityLabel = annotation.title ?? ""
        pinView.canShowCallout = true
        pinView.animatesDrop = true

        let isTargetAnnotation = annotation.coordinate.latitude == targetAnnotation.coordinate.latitude
            && annotation.coordinate.longitude == targetAnnotation.coordinate.longitude
        pinView.pinTintColor = isTargetAnnotation ? .systemBlue : .systemOrange

        return pinView
    }
}
 

//
//  ViewController.swift
//  NobelLaureatesFinder
//
//  Created by Kristina Gelzinyte on 3/3/20.
//  Copyright © 2020 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    private let headerView = UIView()
    private let dateTitle = UILabel()
    private let dateButton = DateButton()
    private let datePickerView = DatePickerView()
    private let coordinateTitle = UILabel()
    private let coordinatesView = CoordinatesView()
    private let mapView = MKMapView()

    private lazy var targetAnnotation: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.title = "Your location"
        mapView.addAnnotation(annotation)
        return annotation
    }()

    private var dataPickerHeightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateTitle.text = "Year"

        coordinateTitle.text = "Coordinates"
                
        headerView.layer.shadowOpacity = 0.5
        
        dateButton.addTarget(self, action: #selector(showDatePicker(_:)), for: .touchUpInside)
        
        datePickerView.onDateSelection = { [weak self] date in
            self?.dateButton.updateTitle("\(date)")
        }
        
        coordinatesView.onBecameFirstResponder = { [weak self] in
            self?.dismissDatePicker()
        }
        coordinatesView.onSearch = { [weak self] coordinates in
            self?.targetAnnotation.coordinate = coordinates
            
            let span = MKCoordinateSpan(latitudeDelta: coordinates.latitude + 10, longitudeDelta: coordinates.longitude + 10)
            let region = MKCoordinateRegion(center: coordinates, span: span)
            self?.mapView.setRegion(region, animated: true)
            
            // TODO - perform search
        }
        
        view.addSubview(mapView)
        view.addSubview(headerView)
        view.addSubview(dateTitle)
        view.addSubview(dateButton)
        view.addSubview(datePickerView)
        view.addSubview(coordinateTitle)
        view.addSubview(coordinatesView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        dateTitle.translatesAutoresizingMaskIntoConstraints = false
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        coordinateTitle.translatesAutoresizingMaskIntoConstraints = false
        coordinatesView.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false

        mapView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        dateTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dateTitle.centerYAnchor.constraint(equalTo: dateButton.centerYAnchor).isActive = true
        
        dateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        dateButton.leadingAnchor.constraint(equalTo: dateTitle.trailingAnchor, constant: 20).isActive = true
        dateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        datePickerView.topAnchor.constraint(equalTo: dateButton.bottomAnchor).isActive = true
        datePickerView.bottomAnchor.constraint(equalTo: coordinatesView.topAnchor, constant: -10).isActive = true
        datePickerView.trailingAnchor.constraint(equalTo: dateButton.trailingAnchor).isActive = true
        datePickerView.leadingAnchor.constraint(equalTo: dateButton.leadingAnchor).isActive = true

        dataPickerHeightConstraint = datePickerView.heightAnchor.constraint(equalToConstant: 0)
        dataPickerHeightConstraint?.isActive = true
        
        coordinatesView.leadingAnchor.constraint(equalTo: dateButton.leadingAnchor).isActive = true
        coordinatesView.trailingAnchor.constraint(equalTo: dateButton.trailingAnchor).isActive = true
        coordinatesView.heightAnchor.constraint(equalTo: dateButton.heightAnchor).isActive = true
        coordinatesView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20).isActive = true

        coordinateTitle.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        coordinateTitle.leadingAnchor.constraint(equalTo: dateTitle.leadingAnchor).isActive = true
        coordinateTitle.widthAnchor.constraint(equalTo: dateTitle.widthAnchor).isActive = true
        coordinateTitle.centerYAnchor.constraint(equalTo: coordinatesView.centerYAnchor).isActive = true
                
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        tapGestureRecognizer.delegate = self
        mapView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Actions

    @objc private func showDatePicker(_ sender: UIControl) {
        coordinatesView.endEditing()
        
        guard !datePickerView.isPresented else {
            return dismissDatePicker()
        }
        
        datePickerView.isPresented = true
        
        dataPickerHeightConstraint?.constant = 200
        UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func dismissDatePicker() {
        guard datePickerView.isPresented else { return }
        datePickerView.isPresented = false
        
        dataPickerHeightConstraint?.constant = 0
        UIView.animate(withDuration: 0.2, delay: 0, options: .beginFromCurrentState, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }

    // MARK: - Gestures handler
    
    @objc private func tapGestureHandler(_ sender: UITapGestureRecognizer) {
        if datePickerView.isPresented || coordinatesView.isEditing {
            dismissDatePicker()
            coordinatesView.endEditing()
            return
        }
       
        let location = sender.location(in: mapView)
        let coordinates = mapView.convert(location, toCoordinateFrom: mapView)
        
        coordinatesView.updateCoordinates(coordinates)
        targetAnnotation.coordinate = coordinates
    }
}

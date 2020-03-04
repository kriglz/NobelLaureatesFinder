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

class ViewController: UIViewController {

    private let headerView = UIView()
    private let dateTitle = UILabel()
    private let dateButton = DateButton()
    private let datePickerView = DatePickerView()
    private let coordinateTitle = UILabel()
    private let coordinatesView = CoordinatesView()
    private let mapView = MKMapView()
    private let searchButton = UIButton()
    // todo - list view button

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

        headerView.backgroundColor = .tertiarySystemBackground
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowOffset = CGSize(width: 0, height: 2)

        dateButton.addTarget(self, action: #selector(showDatePicker(_:)), for: .touchUpInside)
        
        datePickerView.onDateSelection = { [weak self] date in
            self?.dateButton.updateTitle("\(date)")
        }
        
        coordinatesView.onBecameFirstResponder = { [weak self] in
            self?.dismissDatePicker()
        }

        coordinatesView.onSearch = { [weak self] coordinates in
            self?.targetAnnotation.coordinate = coordinates

            let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
            let region = MKCoordinateRegion(center: coordinates, span: span)
            self?.mapView.setRegion(region, animated: true)
            
            self?.searchAction(nil)
        }
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.backgroundColor = .systemBlue
        searchButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        searchButton.layer.shadowOpacity = 0.1
        searchButton.layer.cornerRadius = 25
        searchButton.addTarget(self, action: #selector(searchAction(_:)), for: .touchUpInside)
        
        view.addSubview(mapView)
        view.addSubview(headerView)
        view.addSubview(dateTitle)
        view.addSubview(dateButton)
        view.addSubview(datePickerView)
        view.addSubview(coordinateTitle)
        view.addSubview(coordinatesView)
        view.addSubview(searchButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        dateTitle.translatesAutoresizingMaskIntoConstraints = false
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        coordinateTitle.translatesAutoresizingMaskIntoConstraints = false
        coordinatesView.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false

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

        searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true        
        searchButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        mapView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Actions

    @objc private func searchAction(_ sender: Any?) {
        guard let date = dateButton.date,
            let coordinates = coordinatesView.coordinates else {
                return UINotificationFeedbackGenerator().notificationOccurred(.warning)
        }
        
        // Perform search
    }
    
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

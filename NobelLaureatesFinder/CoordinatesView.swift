//
//  CoordinatesView.swift
//  NobelLaureatesFinder
//
//  Created by Kristina Gelzinyte on 3/3/20.
//  Copyright © 2020 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import CoreLocation

class CoordinatesView: UIView {
    
    var onBecameFirstResponder: (() -> Void)?
    var onSearch: ((CLLocationCoordinate2D) -> Void)?
    
    var isEditing: Bool {
        return nCoordinateField.isEditing || eCoordinateField.isEditing
    }

    private let nCoordinateField = CoordinateView(title: "N")
    private let eCoordinateField = CoordinateView(title: "E")
    
    private let nRange = -90.0...90.0
    private let eRange = -180.0...180.0

    private var coordinates: CLLocationCoordinate2D? {
        guard let n = nCoordinateField.coordinate,
            let e = eCoordinateField.coordinate,
            nRange.contains(n),
            eRange.contains(e) else {
                let alert = UIAlertController(title: "Invalid coordinates", message: "Please enter valid coordinates.\n'N' range from 0 to 90 degrees,\n'E' range from -180 to 180.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                viewController()?.present(alert, animated: true, completion: nil)
                return nil
        }

        return CLLocationCoordinate2D(latitude: n, longitude: e)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        nCoordinateField.onBecameFirstResponder = { [weak self] in
            self?.onBecameFirstResponder?()
        }
        nCoordinateField.onSearch = { [weak self] in
            guard let coordinates = self?.coordinates else { return }
            self?.onSearch?(coordinates)
        }
        
        eCoordinateField.onBecameFirstResponder = { [weak self] in
            self?.onBecameFirstResponder?()
        }
        eCoordinateField.onSearch = { [weak self] in
            guard let coordinates = self?.coordinates else { return }
            self?.onSearch?(coordinates)
        }
        
        addSubview(nCoordinateField)
        addSubview(eCoordinateField)
        
        nCoordinateField.translatesAutoresizingMaskIntoConstraints = false
        eCoordinateField.translatesAutoresizingMaskIntoConstraints = false
        
        nCoordinateField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nCoordinateField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        nCoordinateField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nCoordinateField.trailingAnchor.constraint(equalTo: eCoordinateField.leadingAnchor, constant: -10).isActive = true
        
        nCoordinateField.widthAnchor.constraint(equalTo: eCoordinateField.widthAnchor).isActive = true
        
        eCoordinateField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        eCoordinateField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        eCoordinateField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func endEditing() {
        nCoordinateField.endEditing()
        eCoordinateField.endEditing()
    }
    
    func updateCoordinates(_ coordinates: CLLocationCoordinate2D) {
        nCoordinateField.updateCoordinate(coordinates.latitude)
        eCoordinateField.updateCoordinate(coordinates.longitude)
    }
}

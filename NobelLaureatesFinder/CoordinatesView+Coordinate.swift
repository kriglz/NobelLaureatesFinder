//
//  CoordinatesView+TextField.swift
//  NobelLaureatesFinder
//
//  Created by Kristina Gelzinyte on 3/3/20.
//  Copyright © 2020 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import CoreLocation

extension CoordinatesView {
    class CoordinateView: UIView, UITextFieldDelegate {
        
        var onBecameFirstResponder: (() -> Void)?
        var onSearch: (() -> Void)?

        var isEditing: Bool {
            return textField.isFirstResponder
        }
        
        var coordinate: CLLocationDegrees? {
            guard let coordinate = textField.text else {
                return nil
            }
            return CLLocationDegrees(coordinate)
        }
        
        private let textField = UITextField()
        private let titleLabel = UILabel()
        private let borderView = UIView()

        convenience init(title: String) {
            self.init(frame: .zero)
            
            titleLabel.text = title
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
                        
            borderView.layer.cornerRadius = 10
            borderView.layer.borderColor = UIColor.gray.cgColor
            borderView.layer.borderWidth = 1
            
            textField.placeholder = "Decimal degrees" // "Enter coordinate in decimal degrees (DD)"
            textField.adjustsFontSizeToFitWidth = true
            textField.keyboardType = .numbersAndPunctuation
            textField.returnKeyType = .search
            textField.delegate = self
            
            addSubview(borderView)
            addSubview(titleLabel)
            addSubview(textField)
            
            borderView.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            titleLabel.setContentHuggingPriority(.required, for: .horizontal)
            titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            borderView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5).isActive = true
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            borderView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            
            textField.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 6).isActive = true
            textField.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -6).isActive = true
            textField.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 1).isActive = true
            textField.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -1).isActive = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func endEditing() {
            guard textField.isFirstResponder else { return }
            textField.resignFirstResponder()
        }
        
        func updateCoordinate(_ coordinate: CLLocationDegrees) {
            textField.text = "\(coordinate)"
        }
        
        // MARK: - UITextFieldDelegate
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            // TODO show alert about tap to select and DD precision
            
            onBecameFirstResponder?()
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string == "\n" {
                endEditing()
                onSearch?()
                return false
            }
            
            return true
        }
    }
}

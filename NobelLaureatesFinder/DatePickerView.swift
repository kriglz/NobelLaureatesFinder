//
//  DatePickerView.swift
//  NobelLaureatesFinder
//
//  Created by Kristina Gelzinyte on 3/3/20.
//  Copyright © 2020 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class DatePickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var isPresented = false
    var onDateSelection: ((Int) -> Void)?
    
    private let minDate = 1900
    private let maxDate = 2020

    private let datePicker = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .white
        clipsToBounds = true

        datePicker.dataSource = self
        datePicker.delegate = self
        
        addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        datePicker.topAnchor.constraint(lessThanOrEqualTo: topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxDate - minDate + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(maxDate - row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        onDateSelection?(maxDate - row)
    }
}

//
//  ControlsView.swift
//  NobelLaureatesFinder
//
//  Created by Kristina Gelzinyte on 3/3/20.
//  Copyright © 2020 Kristina Gelzinyte. All rights reserved.
//

//import UIKit
//
//class ControlsView: UIView {
//    
//    var isSelectingDate: Bool {
//        return datePickerView.isPresented
//    }
//    
//    private let headerView = UIView()
//    private let dateTitle = UILabel()
//    private let dateButton = DateButton()
//    private let datePickerView = DatePickerView()
//    private let coordinateTitle = UILabel()
//    private let coordinatesView = CoordinatesView()
//
//    private var dataPickerHeightConstraint: NSLayoutConstraint?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        dateTitle.text = "Travel year"
//        coordinateTitle.text = "Travel coordinates"
//                
//        headerView.backgroundColor = .white
//        
//        dateButton.addTarget(self, action: #selector(showDatePicker(_:)), for: .touchUpInside)
//        
//        datePickerView.onDateSelection = { [weak self] date in
//            self?.dateButton.updateTitle("\(date)")
//        }
//        
//        addSubview(headerView)
//        addSubview(dateTitle)
//        addSubview(dateButton)
//        addSubview(datePickerView)
//        addSubview(coordinateTitle)
//        addSubview(coordinatesView)
//        
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        dateTitle.translatesAutoresizingMaskIntoConstraints = false
//        dateButton.translatesAutoresizingMaskIntoConstraints = false
//        datePickerView.translatesAutoresizingMaskIntoConstraints = false
//        coordinateTitle.translatesAutoresizingMaskIntoConstraints = false
//        coordinatesView.translatesAutoresizingMaskIntoConstraints = false
//        
//        headerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        headerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
//        headerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        
//        dateTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
//        dateTitle.centerYAnchor.constraint(equalTo: dateButton.centerYAnchor).isActive = true
//        
//        dateButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        dateButton.leadingAnchor.constraint(equalTo: dateTitle.trailingAnchor, constant: 20).isActive = true
//        dateButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
//        
//        datePickerView.topAnchor.constraint(equalTo: dateButton.bottomAnchor).isActive = true
//        datePickerView.bottomAnchor.constraint(equalTo: coordinatesView.topAnchor, constant: -10).isActive = true
//        datePickerView.trailingAnchor.constraint(equalTo: dateButton.trailingAnchor).isActive = true
//        datePickerView.leadingAnchor.constraint(equalTo: dateButton.leadingAnchor).isActive = true
//
//        dataPickerHeightConstraint = datePickerView.heightAnchor.constraint(equalToConstant: 0)
//        dataPickerHeightConstraint?.isActive = true
//        
//        coordinatesView.leadingAnchor.constraint(equalTo: dateButton.leadingAnchor).isActive = true
//        coordinatesView.trailingAnchor.constraint(equalTo: dateButton.trailingAnchor).isActive = true
//        coordinatesView.heightAnchor.constraint(equalTo: dateButton.heightAnchor).isActive = true
//        coordinatesView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20).isActive = true
//
//        coordinateTitle.setContentCompressionResistancePriority(.required, for: .horizontal)
//        
//        coordinateTitle.leadingAnchor.constraint(equalTo: dateTitle.leadingAnchor).isActive = true
//        coordinateTitle.widthAnchor.constraint(equalTo: dateTitle.widthAnchor).isActive = true
//        coordinateTitle.centerYAnchor.constraint(equalTo: coordinatesView.centerYAnchor).isActive = true
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        guard let subview = super.hitTest(point, with: event) else {
//            return nil
//        }
//        
//        if datePickerView.isPresented && datePickerView.frame.contains(point) {
//            return subview
//        }
//
//        return subviews.contains(subview) ? subview : nil
//    }
//    
//    @objc private func showDatePicker(_ sender: UIControl) {
//        guard !datePickerView.isPresented else {
//            return dismissDatePicker()
//        }
//
//        datePickerView.isPresented = true
//
//        dataPickerHeightConstraint?.constant = 200
//        UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: { [weak self] in
//            self?.layoutIfNeeded()
//        }, completion: nil)
//    }
//    
//    private func dismissDatePicker() {
//        guard datePickerView.isPresented else { return }
//        datePickerView.isPresented = false
//        
//        dataPickerHeightConstraint?.constant = 0
//        UIView.animate(withDuration: 0.2, delay: 0, options: .beginFromCurrentState, animations: { [weak self] in
//            self?.layoutIfNeeded()
//        }, completion: nil)
//    }
//    
//    func dismissDatePickerIfNeeded() {
//        dismissDatePicker()
//    }
//}

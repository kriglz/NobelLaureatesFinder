//
//  DateButton.swift
//  NobelLaureatesFinder
//
//  Created by Kristina Gelzinyte on 3/3/20.
//  Copyright © 2020 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class DateButton: UIControl {
    
    var date: String? {
        if titleLabel.text == DateButton.placeholderMessage {
            return nil
        }
        
        return titleLabel.text
    }
    
    private let titleLabel = UILabel()
    static private let placeholderMessage = "Select a year"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemGray.cgColor
        layer.borderWidth = 1
        
        titleLabel.text = DateButton.placeholderMessage
        titleLabel.textAlignment = .center
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTitle(_ title: String) {
        titleLabel.text = title
    }
}

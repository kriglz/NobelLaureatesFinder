//
//  ListViewController+CellView.swift
//  NobelLaureatesFinder
//
//  Created by Kristina Gelzinyte on 3/4/20.
//  Copyright © 2020 Kristina Gelzinyte. All rights reserved.
//

import UIKit

extension ListViewController {
    class Cell: UITableViewCell {
        
        static let identifier = "cellIdentifier"
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

//
//  UIView+Extension.swift
//  NobelLaureatesFinder
//
//  Created by Kristina Gelzinyte on 3/3/20.
//  Copyright © 2020 Kristina Gelzinyte. All rights reserved.
//

import UIKit

extension UIView {
    func viewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
            
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.viewController()
            
        } else {
            return nil
        }
    }
}

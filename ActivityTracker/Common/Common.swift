//
//  Common.swift
//  ActivityTracker
//
//  Created by Antony Raphel on 04/12/18.
//  Copyright © 2018 Antony Raphel. All rights reserved.
//

import Foundation
import UIKit

extension UIToolbar {
    func Toolbar(done: Selector, cancel: Selector) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: cancel)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: done)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }
}

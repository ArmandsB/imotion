//
//  UIController+ContentView.swift
//  iMotion
//
//  Created by Armands Baurovskis on 27/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//

import UIKit

protocol ViewControllerContentView: UIViewController {
    associatedtype ContentView
    var contentView: ContentView { get }
}

extension ViewControllerContentView {

    var contentView: ContentView {
        guard let view = self.view as? ContentView else { fatalError("Should not be optional") }
        return view
    }
}

//
//  Color.swift
//  iMotion
//
//  Created by Armands Baurovskis on 27/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//

import UIKit

enum Color: String {
    case dashboardBackground
    case text
    case background
}

extension Color {

    var uiColor: UIColor {
        guard let color = UIColor(named: self.rawValue) else {
            fatalError("Non existing color")
        }
        return color
    }
}

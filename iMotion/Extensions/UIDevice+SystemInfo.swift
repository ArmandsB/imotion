//
//  UIDevice+SystemInfo.swift
//  iMotion
//
//  Created by Armands Baurovskis on 27/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//

import UIKit

extension UIDevice {
    var systemInfo: SystemInfo {
        return SystemInfo(name: self.name,
                          systemName: self.systemName,
                          systemVersion: self.systemVersion,
                          model: self.model,
                          batteryLevel: self.batteryLevel,
                          proximityState: self.proximityState,
                          identifierForVendor: self.identifierForVendor)
    }
}

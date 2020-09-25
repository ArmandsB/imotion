//
//  SystemInfo+DashboardInfoItem.swift
//  iMotion
//
//  Created by Armands Baurovskis on 27/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//

import Foundation

extension SystemInfo: AsDashboardInfo {
    var info: [DashboardInfoItem] {
        var items: [DashboardInfoItem] = [
            DashboardInfoItem(title: "Name", description: self.name),
            DashboardInfoItem(title: "System Name", description: self.systemName),
            DashboardInfoItem(title: "System Version", description: self.systemVersion),
            DashboardInfoItem(title: "Model", description: self.model),
            DashboardInfoItem(title: "Proximity State", description: "\(self.proximityState)")
        ]

        // If data is not available, then system is responding with -1
        if self.batteryLevel != -1 {
            items.append(DashboardInfoItem(title: "Battery level",
                                           description: "\(self.batteryLevel * 100)%"))
        }

        if let identifierForVendor = self.identifierForVendor {
            items.append(DashboardInfoItem(title: "Identifier For Vendor",
                                           description: identifierForVendor.uuidString))
        }

        return items
    }
}

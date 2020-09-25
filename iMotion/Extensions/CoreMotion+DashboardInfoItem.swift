//
//  CoreMotion+DashboardInfoItem.swift
//  iMotion
//
//  Created by Armands Baurovskis on 27/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//
import CoreMotion
import Foundation

extension CMAccelerometerData: AsDashboardInfo {
    var info: [DashboardInfoItem] {
        return [
            DashboardInfoItem(title: "X", description: "\(self.acceleration.x)"),
            DashboardInfoItem(title: "Y", description: "\(self.acceleration.y)"),
            DashboardInfoItem(title: "Z", description: "\(self.acceleration.z)")
        ]
    }
}

extension CMGyroData: AsDashboardInfo {
    var info: [DashboardInfoItem] {
        return [
            DashboardInfoItem(title: "X", description: "\(self.rotationRate.x)"),
            DashboardInfoItem(title: "Y", description: "\(self.rotationRate.y)"),
            DashboardInfoItem(title: "Z", description: "\(self.rotationRate.z)")
        ]
    }
}

extension CMMagnetometerData: AsDashboardInfo {
    var info: [DashboardInfoItem] {
        return [
            DashboardInfoItem(title: "X", description: "\(self.magneticField.x)"),
            DashboardInfoItem(title: "Y", description: "\(self.magneticField.y)"),
            DashboardInfoItem(title: "Z", description: "\(self.magneticField.z)")
        ]
    }
}

extension CMDeviceMotion: AsDashboardInfo {
    var info: [DashboardInfoItem] {
        return [
            DashboardInfoItem(title: "Roll", description: "\(self.attitude.roll)"),
            DashboardInfoItem(title: "Pitch", description: "\(self.attitude.pitch)"),
            DashboardInfoItem(title: "Yaw", description: "\(self.attitude.yaw)")
        ]
    }
}

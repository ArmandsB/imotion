//
//  SystemInfo.swift
//  iMotion
//
//  Created by Armands Baurovskis on 27/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//

import Foundation

struct SystemInfo {
    let name: String
    let systemName: String
    let systemVersion: String
    let model: String
    let batteryLevel: Float
    let proximityState: Bool
    let identifierForVendor: UUID?
}

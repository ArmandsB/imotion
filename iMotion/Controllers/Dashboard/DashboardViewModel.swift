//
//  DashboardViewModel.swift
//  iMotion
//
//  Created by Armands Baurovskis on 25/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol PDashboardViewModel {
    var accelerometer: Driver<[DashboardInfoItem]> { get }
    var gyroscope: Driver<[DashboardInfoItem]> { get }
    var magnetometer: Driver<[DashboardInfoItem]> { get }
    var deviceMotion: Driver<[DashboardInfoItem]> { get }
    var systemInfo: Driver<[DashboardInfoItem]> { get }

    func startUpdates()
    func stopUpdates()
}

struct DashboardViewModel: PDashboardViewModel {
    private let motionManager: PMotionManager
    private let systemInfoManager: PSystemInfoManager
    init(motionManager: PMotionManager, systemInfoManager: PSystemInfoManager) {
        self.motionManager = motionManager
        self.systemInfoManager = systemInfoManager
    }

    func startUpdates() {
        motionManager.startUpdates()
        systemInfoManager.startUpdates()
    }

    func stopUpdates() {
        motionManager.stopUpdates()
        systemInfoManager.stopUpdates()
    }
}

extension DashboardViewModel {
    var accelerometer: Driver<[DashboardInfoItem]> {
        return motionManager.accelerometer.map { $0.info }.asDriver(onErrorJustReturn: [])
    }
    var gyroscope: Driver<[DashboardInfoItem]> {
        return motionManager.gyroscope.map { $0.info }.asDriver(onErrorJustReturn: [])
    }
    var magnetometer: Driver<[DashboardInfoItem]> {
        return motionManager.magnetometer.map { $0.info }.asDriver(onErrorJustReturn: [])
    }
    var deviceMotion: Driver<[DashboardInfoItem]> {
        return motionManager.deviceMotion.map { $0.info }.asDriver(onErrorJustReturn: [])
    }
    var systemInfo: Driver<[DashboardInfoItem]> {
        return systemInfoManager.systemInfo.map { $0.info }.asDriver(onErrorJustReturn: [])
    }
}

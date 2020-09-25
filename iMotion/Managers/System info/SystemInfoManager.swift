//
//  SystemInfoManager.swift
//  iMotion
//
//  Created by Armands Baurovskis on 27/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//
import RxRelay
import RxSwift
import UIKit

protocol PSystemInfoManager {
    var systemInfo: Observable<SystemInfo> { get }
    func startUpdates()
    func stopUpdates()
}

final class SystemInfoManager: PSystemInfoManager {
    private let device: UIDevice
    private let _systemInfo: BehaviorRelay<SystemInfo>
    private var updateDispose: Disposable?

    init(device: UIDevice = UIDevice.current) {
        self.device = device
        _systemInfo = BehaviorRelay(value: device.systemInfo)
    }

    func startUpdates() {
        bindUpdates()
        device.isBatteryMonitoringEnabled = true
        device.isProximityMonitoringEnabled = true
    }

    func stopUpdates() {
        device.isBatteryMonitoringEnabled = false
        device.isProximityMonitoringEnabled = false
        updateDispose = nil
    }

    private func bindUpdates() {
        let batteryChange = NotificationCenter.default.rx
            .notification(UIDevice.batteryStateDidChangeNotification)
        let proximityStateChange = NotificationCenter.default.rx
            .notification(UIDevice.proximityStateDidChangeNotification)

        updateDispose = Observable.merge(batteryChange, proximityStateChange)
            .withLatestFrom(Observable.of(device))
            .map { $0.systemInfo }
            .bind(to: self._systemInfo)
    }
}

extension SystemInfoManager {

    var systemInfo: Observable<SystemInfo> {
        return _systemInfo.asObservable()
    }
}

//
//  MotionManager.swift
//  iMotion
//
//  Created by Armands Baurovskis on 25/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//

import CoreMotion
import Foundation
import RxSwift
import RxRelay

protocol PMotionManager {
    var motionManager: CMMotionManager { get }
    var accelerometer: Observable<CMAccelerometerData> { get }
    var gyroscope: Observable<CMGyroData> { get }
    var magnetometer: Observable<CMMagnetometerData> { get }
    var deviceMotion: Observable<CMDeviceMotion> { get }
    func startUpdates()
    func stopUpdates()
}

struct MotionManager: PMotionManager {
    let motionManager: CMMotionManager
    private let _accelerometer: PublishRelay<CMAccelerometerData> = PublishRelay()
    private let _gyroscope: PublishRelay<CMGyroData> = PublishRelay()
    private let _magnetometer: PublishRelay<CMMagnetometerData> = PublishRelay()
    private let _deviceMotion: PublishRelay<CMDeviceMotion> = PublishRelay()

    init(motionManager: CMMotionManager, updateIntervals: MotionUpdateIntervals) {
        self.motionManager = motionManager
        setUpdateIntervals(motionManager: motionManager, updateIntervals: updateIntervals)
    }

    private func setUpdateIntervals(
        motionManager: CMMotionManager,
        updateIntervals: MotionUpdateIntervals
    ) {
        motionManager.accelerometerUpdateInterval = updateIntervals.accelerometer
        motionManager.gyroUpdateInterval = updateIntervals.gyroscope
        motionManager.magnetometerUpdateInterval = updateIntervals.magnetometer
        motionManager.deviceMotionUpdateInterval = updateIntervals.deviceMotion
    }
}

extension MotionManager {

    var accelerometer: Observable<CMAccelerometerData> {
        return _accelerometer.asObservable()
    }

    var gyroscope: Observable<CMGyroData> {
        return _gyroscope.asObservable()
    }

    var magnetometer: Observable<CMMagnetometerData> {
        return _magnetometer.asObservable()
    }

    var deviceMotion: Observable<CMDeviceMotion> {
        return _deviceMotion.asObservable()
    }
}

extension MotionManager {

    func startUpdates() {
        startAccelerometerUpdates(motionManager: motionManager, updater: _accelerometer)
        startGyroUpdates(motionManager: motionManager, updater: _gyroscope)
        startMagnetometerUpdates(motionManager: motionManager, updater: _magnetometer)
        startDeviceMotionUpdates(motionManager: motionManager, updater: _deviceMotion)
    }

    func stopUpdates() {
        if motionManager.isAccelerometerActive {
            motionManager.stopAccelerometerUpdates()
        }
        if motionManager.isGyroActive {
            motionManager.stopGyroUpdates()
        }
        if motionManager.isMagnetometerActive {
            motionManager.stopMagnetometerUpdates()
        }
        if motionManager.isDeviceMotionActive {
            motionManager.stopDeviceMotionUpdates()
        }
    }
}

extension MotionManager {

    private func startAccelerometerUpdates(
        motionManager: CMMotionManager,
        updater: PublishRelay<CMAccelerometerData>
    ) {
        guard motionManager.isAccelerometerAvailable, !motionManager.isAccelerometerActive else { return }
        motionManager.startAccelerometerUpdates(to: createOperationQueue()) { data, error in
            if let error = error {
                print("Accelerometer updates erorr: \(error)")
            }
            guard let data = data else { return }
            updater.accept(data)
        }
    }

    private func startGyroUpdates(
        motionManager: CMMotionManager,
        updater: PublishRelay<CMGyroData>
    ) {
        guard motionManager.isGyroAvailable, !motionManager.isGyroActive else { return }
        motionManager.startGyroUpdates(to: createOperationQueue()) { data, error in
            if let error = error {
                print("Gryro updates erorr: \(error)")
            }
            guard let data = data else { return }
            updater.accept(data)
        }
    }

    private func startMagnetometerUpdates(
        motionManager: CMMotionManager,
        updater: PublishRelay<CMMagnetometerData>
    ) {
        guard motionManager.isMagnetometerAvailable, !motionManager.isMagnetometerActive else { return }
        motionManager.startMagnetometerUpdates(to: createOperationQueue()) { data, error in
            if let error = error {
                print("Magnetome updates erorr: \(error)")
            }
            guard let data = data else { return }
            updater.accept(data)
        }
    }

    private func startDeviceMotionUpdates(
        motionManager: CMMotionManager,
        updater: PublishRelay<CMDeviceMotion>
    ) {
        guard motionManager.isDeviceMotionAvailable, !motionManager.isDeviceMotionActive else { return }
        motionManager.startDeviceMotionUpdates(to: createOperationQueue()) { data, error in
            if let error = error {
                print("DeviceMotion updates erorr: \(error)")
            }
            guard let data = data else { return }
            updater.accept(data)
        }
    }

    private func createOperationQueue() -> OperationQueue {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }
}

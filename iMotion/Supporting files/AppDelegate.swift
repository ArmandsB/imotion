//
//  AppDelegate.swift
//  iMotion
//
//  Created by Armands Baurovskis on 25/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//
import CoreMotion
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        let motionManager = MotionManager(
            motionManager: CMMotionManager(),
            updateIntervals: MotionUpdateIntervals(accelerometer: 1.0,
                                                   gyroscope: 1.0,
                                                   magnetometer: 1.0,
                                                   deviceMotion: 1.0))

        let viewModel = DashboardViewModel(motionManager: motionManager,
                                           systemInfoManager: SystemInfoManager())
        self.window?.rootViewController = DashboardViewController(viewModel: viewModel)
        self.window?.makeKeyAndVisible()
        return true
    }

}

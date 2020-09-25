//
//  DashboardView.swift
//  iMotion
//
//  Created by Armands Baurovskis on 25/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//
import PinLayout
import UIKit

protocol PDashboardView: UsesPinLayout {
    var accelerometerView: PDashboardInfoView { get }
    var gyroscopeView: PDashboardInfoView { get }
    var magnetometerView: PDashboardInfoView { get }
    var deviceMotionView: PDashboardInfoView { get }
    var systemInfoView: PDashboardInfoView { get }
    func bounceViews()
}

final class DashboardView: UIView, PDashboardView {
    let accelerometerView: PDashboardInfoView = DashboardInfoView(title: "Accelerometer")
    let gyroscopeView: PDashboardInfoView = DashboardInfoView(title: "Gyroscope")
    let magnetometerView: PDashboardInfoView = DashboardInfoView(title: "Magnetometer")
    let deviceMotionView: PDashboardInfoView = DashboardInfoView(title: "Device Motion")
    let systemInfoView: PDashboardInfoView = DashboardInfoView(title: "System Info")

    init() {
        super.init(frame: .zero)
        addSubview(accelerometerView)
        addSubview(gyroscopeView)
        addSubview(magnetometerView)
        addSubview(deviceMotionView)
        addSubview(systemInfoView)
        self.backgroundColor = Color.background.uiColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    //swiftlint:disable function_body_length
    func layout() {
        let spacing = pin.layoutMargins.left
        let motionElementWidth = (self.frame.width
                                    - spacing
                                    - pin.layoutMargins.left
                                    - pin.layoutMargins.right
                                 ) / 2.0

        let elementHeight = (self.frame.height
                                - 2 * spacing
                                - pin.layoutMargins.top
                                - pin.layoutMargins.bottom
                            )
                            * 0.33

        accelerometerView.pin
            .left(pin.layoutMargins.left)
            .top(pin.layoutMargins.top)
            .height(elementHeight)
            .width(motionElementWidth)

        gyroscopeView.pin
            .right(pin.layoutMargins.right)
            .top(pin.layoutMargins.top)
            .after(of: accelerometerView)
            .marginLeft(spacing)
            .height(elementHeight)
            .width(motionElementWidth)

        magnetometerView.pin
            .left(pin.layoutMargins.left)
            .below(of: accelerometerView)
            .marginTop(spacing)
            .height(elementHeight)
            .width(motionElementWidth)

        deviceMotionView.pin
            .right(pin.layoutMargins.right)
            .below(of: gyroscopeView)
            .marginTop(spacing)
            .after(of: magnetometerView)
            .marginLeft(spacing)
            .height(elementHeight)
            .width(motionElementWidth)

        systemInfoView.pin
            .left(pin.layoutMargins.left)
            .below(of: magnetometerView)
            .marginTop(spacing)
            .bottom(pin.layoutMargins.bottom)
            .right(pin.layoutMargins.right)
    }
    //swiftlint:enable function_body_length
}

extension DashboardView {

    func bounceViews() {
        let animationOrder = [
            accelerometerView,
            gyroscopeView,
            magnetometerView,
            deviceMotionView,
            systemInfoView
        ]

        for (idx, view) in animationOrder.enumerated() {
            self.bounceView(delay: TimeInterval(idx) * 0.5, view: view)
        }
    }

    private func bounceView(delay: TimeInterval, view: UIView) {
        UIView.animateKeyframes(withDuration: 0.3, delay: delay, options: [], animations: {
            view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.2,
                           initialSpringVelocity: 5,
                           options: .curveEaseInOut, animations: {
                            view.transform = CGAffineTransform.identity
            })
        })
    }
}

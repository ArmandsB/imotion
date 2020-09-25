//
//  DashboardViewController.swift
//  iMotion
//
//  Created by Armands Baurovskis on 25/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//

import RxSwift
import UIKit

class DashboardViewController: UIViewController, ViewControllerContentView {
    typealias ContentView = PDashboardView
    private let viewModel: PDashboardViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: PDashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        viewModel.stopUpdates()
    }

    override func loadView() {
        self.view = DashboardView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel(viewModel: viewModel)
        viewModel.startUpdates()
        bounceViews()
    }

    private func bindViewModel(viewModel: PDashboardViewModel) {
        viewModel.accelerometer
            .drive(onNext: { [weak self] items in
                self?.contentView.accelerometerView.updateWithItems(items)
            })
            .disposed(by: disposeBag)

        viewModel.gyroscope
            .drive(onNext: { [weak self] items in
                self?.contentView.gyroscopeView.updateWithItems(items)
            })
            .disposed(by: disposeBag)

        viewModel.magnetometer
            .drive(onNext: { [weak self] items in
                self?.contentView.magnetometerView.updateWithItems(items)
            })
            .disposed(by: disposeBag)

        viewModel.deviceMotion
            .drive(onNext: { [weak self] items in
                self?.contentView.deviceMotionView.updateWithItems(items)
            })
            .disposed(by: disposeBag)

        viewModel.systemInfo
            .drive(onNext: { [weak self] items in
                self?.contentView.systemInfoView.updateWithItems(items)
            })
            .disposed(by: disposeBag)
    }

    private func bounceViews() {
        self.rx
            .methodInvoked(#selector(UIViewController.viewWillAppear))
            .take(1)
            .subscribe(onNext: { [weak self] _ in
                self?.contentView.bounceViews()
            })
            .disposed(by: disposeBag)
    }
}

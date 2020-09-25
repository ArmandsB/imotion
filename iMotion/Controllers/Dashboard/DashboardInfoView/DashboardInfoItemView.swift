//
//  DashboardInfoItemView.swift
//  iMotion
//
//  Created by Armands Baurovskis on 25/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//

import PinLayout
import UIKit

protocol PDashboardInfoItemView: UsesPinLayout {
    func updateViewWithItem(_ item: DashboardInfoItem)
}

final class DashboardInfoItemView: UIView, PDashboardInfoItemView {
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    init() {
        super.init(frame: .zero)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    func layout() {
        titleLabel.pin
            .left()
            .top()
            .sizeToFit()

        descriptionLabel.pin
            .after(of: titleLabel)
            .marginLeft(8)
            .vCenter()
            .right()
            .sizeToFit(.width)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        self.pin.width(size.width)
        layout()
        return CGSize(width: size.width, height: titleLabel.frame.height)
    }
}

extension DashboardInfoItemView {

    func updateViewWithItem(_ item: DashboardInfoItem) {
        titleLabel.attributedText = NSAttributedString(string: "\(item.title):", attributes: [
            .foregroundColor: Color.text.uiColor,
            .font: UIFont.systemFont(ofSize: 12, weight: .light)
        ])

        descriptionLabel.attributedText = NSAttributedString(string: item.description, attributes: [
            .foregroundColor: Color.text.uiColor,
            .font: UIFont.systemFont(ofSize: 12, weight: .light)
        ])

        self.setNeedsLayout()
    }
}

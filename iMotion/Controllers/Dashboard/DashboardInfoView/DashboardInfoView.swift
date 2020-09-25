//
//  DashboardInfoView.swift
//  iMotion
//
//  Created by Armands Baurovskis on 25/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//

import UIKit

protocol PDashboardInfoView: UsesPinLayout {
    func updateWithItems(_ items: [DashboardInfoItem])
}

final class DashboardInfoView: UIView, PDashboardInfoView {

    private static let spacingBetweenInfoItems: CGFloat = 8.0
    private static let backgroundRoundedCornerSize: CGFloat = 16.0
    private static let contentInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

    // A lot faster than layer corner radius
    private lazy var backgroundView = CustomDrawRectView { rect, _ in
        let bezierPath = UIBezierPath(roundedRect: rect,
                                      cornerRadius: DashboardInfoView.backgroundRoundedCornerSize)
        Color.dashboardBackground.uiColor.setFill()
        bezierPath.fill()
    }

    private let titleLabel = UILabel()
    private var infoItemViews: [PDashboardInfoItemView] = []

    init(title: String) {
        super.init(frame: .zero)
        addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        setup(title: title)
    }

    private func setup(title: String) {
        titleLabel.attributedText = NSAttributedString(string: title, attributes: [
            .foregroundColor: Color.text.uiColor,
            .font: UIFont.systemFont(ofSize: 20, weight: .ultraLight)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    func layout() {
        let contentInsets = DashboardInfoView.contentInsets
        backgroundView.pin.all()

        titleLabel.pin
            .left(contentInsets.left)
            .right(contentInsets.right)
            .top(contentInsets.top)
            .sizeToFit(.width)

        for (idx, view) in infoItemViews.enumerated() {
            let infoPin = view.pin
                .left(contentInsets.left)
                .right(contentInsets.right)

            if idx == 0 {
                infoPin.below(of: titleLabel)
                    .marginTop(contentInsets.top)
            } else {
                infoPin
                    .below(of: infoItemViews[idx - 1])
                    .marginTop(DashboardInfoView.spacingBetweenInfoItems)
            }

            infoPin.sizeToFit(.width)
        }
    }
}

extension DashboardInfoView {

    func updateWithItems(_ items: [DashboardInfoItem]) {
        let itemCountDidChange = items.count != infoItemViews.count

        if items.count > infoItemViews.count {
            for _ in (infoItemViews.count...items.count - 1) {
                let view = DashboardInfoItemView()
                backgroundView.addSubview(view)
                infoItemViews.append(view)
            }
        } else if items.count < infoItemViews.count {
            for idx in (items.count...infoItemViews.count - 1).reversed() where idx < infoItemViews.count {
                infoItemViews[idx].removeFromSuperview()
                infoItemViews.remove(at: idx)
            }
        }

        for (idx, item) in items.enumerated() {
            infoItemViews[idx].updateViewWithItem(item)
        }

        if itemCountDidChange {
            self.setNeedsLayout()
        }
    }
}

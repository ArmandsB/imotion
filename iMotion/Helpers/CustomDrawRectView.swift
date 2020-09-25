//
//  CustomDrawRectView.swift
//  iMotion
//
//  Created by Armands Baurovskis on 27/09/2020.
//  Copyright © 2020 Armands Baurovskis. All rights reserved.
//

import UIKit

public class CustomDrawRectView: UIView {
    public var onDrawRect: (CGRect, UIView) -> Void

    public init(onDrawRect: @escaping (CGRect, UIView) -> Void = { _, _ in }) {
        self.onDrawRect = onDrawRect
        super.init(frame: .zero)
        backgroundColor = .clear
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func draw(_ rect: CGRect) {
        backgroundColor = .clear
        onDrawRect(rect, self)
    }
}

//
//  LVGLSlider.swift
//  
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

public protocol LVGLSliderProtocol: LVGLObjectProtocol {
    func setValue(value: Int32, enableAnimation: Bool)
}

public struct LVGLSlider: LVGLSliderProtocol {
    public let label: LVGLLabel
    public var pointer: UnsafeMutablePointer<lv_obj_t>?

    public init(
        _ text: String = "0%", alignment: LVAlignment = .center, xOffset: Int32 = 0,
        yOffset: Int32 = 0
    ) {
        guard let slider = lv_slider_create(lv_screen_active()) else {
            fatalError("Failed to create slider")
        }
        self.pointer = slider
        self.label = LVGLLabel(text, alignment: alignment)

        align(alignment: alignment, xOffset: xOffset, yOffset: yOffset)

        self.label.setParent(parentPointer: slider)
    }

    public func setValue(value: Int32 = 0, enableAnimation: Bool = true) {

    }

}


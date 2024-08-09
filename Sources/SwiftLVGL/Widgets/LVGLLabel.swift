//
//  LVGLLabel.swift
//
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

public protocol LVGLLabelProtocol: LVGLObjectProtocol {
  func setText(_ text: String)
}

public struct LVGLLabel: LVGLLabelProtocol {
  public var pointer: UnsafeMutablePointer<lv_obj_t>?

  public init(
    _ text: String, alignment: LVAlignment = .center, xOffset: Int32 = 0, yOffset: Int32 = 0
  ) {
    guard let label = lv_label_create(lv_screen_active()) else {
      fatalError("Failed to create label")
    }
    self.pointer = label
    setText(text)
    align(alignment: alignment, xOffset: xOffset, yOffset: yOffset)
  }

  public func setText(_ text: String) {
    text.withCString { cString in
      lv_label_set_text(pointer, cString)
    }
  }
}

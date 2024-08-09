//
//  LVGLLabel.swift
//
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

/// A protocol that defines the interface for LVGL label objects.
public protocol LVGLLabelProtocol: LVGLObjectProtocol {
  /// Sets the text of the label.
  /// - Parameter text: The new text to be displayed on the label.
  func setText(_ text: String)
}

/// A struct representing an LVGL label object.
public struct LVGLLabel: LVGLLabelProtocol {
  /// The pointer to the underlying LVGL object.
  public var pointer: UnsafeMutablePointer<lv_obj_t>?

  /// Creates a new LVGL label.
  /// - Parameters:
  ///   - text: The initial text to be displayed on the label.
  ///   - alignment: The alignment of the label. Defaults to `.center`.
  ///   - xOffset: The x-offset of the label. Defaults to 0.
  ///   - yOffset: The y-offset of the label. Defaults to 0.
  public init(
    _ text: String,
    alignment: LVAlignment = .center,
    xOffset: Int32 = 0,
    yOffset: Int32 = 0
  ) {
    guard let label = lv_label_create(lv_screen_active()) else {
      fatalError("Failed to create label")
    }
    self.pointer = label
    setText(text)
    align(alignment: alignment, xOffset: xOffset, yOffset: yOffset)
  }

  /// Sets the text of the label.
  /// - Parameter text: The new text to be displayed on the label.
  public func setText(_ text: String) {
    text.withCString { cString in
      lv_label_set_text(pointer, cString)
    }
  }
}

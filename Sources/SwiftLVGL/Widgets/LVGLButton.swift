//
//  LVGLButton.swift
//
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

public protocol LVGLButtonProtocol: LVGLObjectProtocol {

}

/// A struct representing an LVGL button object.
public struct LVGLButton: LVGLButtonProtocol {
  /// The label associated with the button.
  public let label: LVGLLabel

  /// The pointer to the underlying LVGL object.
  public var pointer: UnsafeMutablePointer<lv_obj_t>?

  /// Creates a new LVGL button.
  /// - Parameters:
  ///   - text: The text to be displayed on the button.
  ///   - alignment: The alignment of the button. Defaults to `.center`.
  ///   - textColor: The color of the button text. Defaults to `.blue`.
  ///   - xSize: The width of the button. Defaults to 120.
  ///   - ySize: The height of the button. Defaults to 50.
  ///   - xOffset: The x-offset of the button. Defaults to 0.
  ///   - yOffset: The y-offset of the button. Defaults to 0.
  ///   - eventType: The type of event to listen for. Defaults to `.all`.
  ///   - callback: The callback function to be called when the specified event occurs. Defaults to an empty closure.
  public init(
    _ text: String,
    alignment: LVAlignment = .center,
    textColor: Color = .blue,
    xSize: Int32 = 120,
    ySize: Int32 = 50,
    xOffset: Int32 = 0,
    yOffset: Int32 = 0,
    eventType: LVEventCode = .all,
    callback: @escaping (UnsafeMutablePointer<lv_event_t>?) -> Void = { _ in }
  ) {
    guard let button = lv_button_create(lv_screen_active()) else {
      fatalError("Failed to create button")
    }
    self.pointer = button
    self.label = LVGLLabel(
      text,
      alignment: alignment,
      xOffset: xOffset,
      yOffset: yOffset
    )
    self.label.setParent(parentPointer: pointer!)
    align(alignment: alignment, xOffset: xOffset, yOffset: yOffset)
    setSize(width: xSize, height: ySize)
    setCallback(eventType: eventType, callback: callback)
  }
}

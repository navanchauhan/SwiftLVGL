//
//  LVGLButton.swift
//
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

public protocol LVGLButtonProtocol: LVGLObjectProtocol {

}

public struct LVGLButton: LVGLButtonProtocol {
  public let label: LVGLLabel
  public var pointer: UnsafeMutablePointer<lv_obj_t>?

  public init(
    _ text: String, alignment: LVAlignment = .center, textColor: Color = .blue,
    xSize: Int32 = 120, ySize: Int32 = 50, xOffset: Int32 = 0, yOffset: Int32 = 0,
    eventType: LVEventCode = .all,
    callback: @escaping (UnsafeMutablePointer<lv_event_t>?) -> Void = { _ in }
  ) {
    guard let button = lv_button_create(lv_screen_active()) else {
      fatalError("Failed to create button")
    }
    self.pointer = button
    self.label = LVGLLabel(
      text, alignment: alignment, xOffset: xOffset, yOffset: yOffset
    )
    self.label.setParent(parentPointer: pointer!)
    align(alignment: alignment, xOffset: xOffset, yOffset: yOffset)
    setSize(width: xSize, height: ySize)
    setCallback(eventType: eventType, callback)

  }

}

//
//  LVGLSwitch.swift
//
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

public protocol LVGLSwitchProtocol: LVGLObjectProtocol {
  var checked: Bool { get set }
  func isChecked() -> Bool
  mutating func setChecked(_ to: Bool)
}

public struct LVGLSwitch: LVGLSwitchProtocol {
  public var checked: Bool
  public var pointer: UnsafeMutablePointer<lv_obj_t>?

  public init(
    _ checked: Bool = false, alignment: LVAlignment = .center, xOffset: Int32 = 0,
    yOffset: Int32 = 0
  ) {
    guard let mySwitch = lv_switch_create(lv_screen_active()) else {
      fatalError("Failed to create switch")
    }
    self.pointer = mySwitch
    self.checked = checked

    align(alignment: alignment, xOffset: xOffset, yOffset: yOffset)
    setChecked(checked)

  }

  public func isChecked() -> Bool {
    return checked
  }

  mutating public func setChecked(_ to: Bool) {
    if to {
      lv_obj_add_state(pointer, 1)
    } else {
      lv_obj_remove_state(pointer, 1)
    }
    self.checked = to
  }
}

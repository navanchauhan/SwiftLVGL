//
//  LVGLSpinner.swift
//
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

public protocol LVGLSpinnerProtocol: LVGLObjectProtocol {
  func setAnimation(animationTime: UInt32, arcAngle: UInt32)
}

public struct LVGLSpinner: LVGLSpinnerProtocol {
  public var pointer: UnsafeMutablePointer<lv_obj_t>?

  public init(
    animationTime: UInt32 = 100,
    arcAngle: UInt32 = 200, alignment: LVAlignment = .center, xSize: UInt32 = 100,
    ySize: UInt32 = 100
  ) {
    guard let spinner = lv_spinner_create(lv_screen_active()) else {
      fatalError("Failed to create spinner")
    }
    self.pointer = spinner
    align(alignment: alignment)
    setSize(width: 100, height: 100)
    lv_spinner_set_anim_params(spinner, 1000, 200)
  }

  public func setAnimation(animationTime: UInt32 = 1000, arcAngle: UInt32 = 200) {
    lv_spinner_set_anim_params(pointer, animationTime, arcAngle)
  }
}

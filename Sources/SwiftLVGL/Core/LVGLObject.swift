//
//  LVGLObject.swift
//
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

extension LVGLObjectProtocol {

  public func setPosition(x: Int32) {
    lv_obj_set_x(pointer, x)
  }

  public func setPosition(y: Int32) {
    lv_obj_set_y(pointer, y)
  }

  public func setPosition(x: Int32, y: Int32) {
    lv_obj_set_pos(pointer, x, y)
  }

  public func setSize(width: Int32) {
    lv_obj_set_width(pointer, width)
  }

  public func setSize(height: Int32) {
    lv_obj_set_height(pointer, height)
  }

  public func setSize(width: Int32, height: Int32) {
    lv_obj_set_size(pointer, width, height)
  }

  public func getDimension(dimension: LVGLDimension) -> Int32 {
    switch dimension {
    case .width:
      return lv_obj_get_width(pointer)
    case .height:
      return lv_obj_get_height(pointer)
    }
  }

  public func getContentDimension(dimension: LVGLDimension) -> Int32 {
    switch dimension {
    case .width:
      return lv_obj_get_content_width(pointer)
    case .height:
      return lv_obj_get_content_height(pointer)
    }
  }

  public func getSelfDimension(dimension: LVGLDimension) -> Int32 {
    switch dimension {
    case .width:
      return lv_obj_get_self_width(pointer)
    case .height:
      return lv_obj_get_self_height(pointer)
    }
  }

  public func setContentSize(width: Int32, height: Int32) {
    lv_obj_set_content_width(pointer, width)
    lv_obj_set_content_height(pointer, height)
  }

  public func setContentSize(width: Int32) {
    lv_obj_set_content_width(pointer, width)
  }

  public func setContentSize(height: Int32) {
    lv_obj_set_content_height(pointer, height)
  }

  public func align(alignment: LVAlignment) {
    lv_obj_set_align(pointer, alignment.rawValue)
  }

  public func align(alignment: LVAlignment, xOffset: Int32, yOffset: Int32) {
    lv_obj_align(pointer, alignment.rawValue, xOffset, yOffset)
  }

  public func center() {
    lv_obj_center(pointer)
  }

  public func getParent() -> UnsafeMutablePointer<lv_obj_t>? {
    let parentPointer: UnsafeMutablePointer<lv_obj_t>? = lv_obj_get_parent(pointer)
    return parentPointer
  }

  public func setParent(parentPointer: UnsafeMutablePointer<lv_obj_t>) {
    lv_obj_set_parent(pointer, parentPointer)
  }

  public func setCallback(
    eventType: LVEventCode,
    _ callback: @escaping (UnsafeMutablePointer<lv_event_t>?) -> Void
  ) {
    callbackStore[UnsafeMutableRawPointer(pointer!)] = callback

    lv_obj_add_event_cb(
      pointer,
      { cCallback($0) },
      eventType.toLVEventCode(),
      nil
    )
  }

  public func removeCallback() {
    callbackStore.removeValue(forKey: UnsafeMutableRawPointer(pointer!))
  }

  public mutating func delete() {
    if pointer == nil {
      print("Pointer already exists")
      print("This will be a fatal error in the future")
    } else {
      lv_obj_delete(pointer)
      pointer = nil

    }
  }

  public func exists() -> Bool {
    if pointer == nil {
      return false
    }
    return true
  }
}

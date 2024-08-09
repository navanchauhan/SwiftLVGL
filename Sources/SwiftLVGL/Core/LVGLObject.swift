//
//  LVGLObject.swift
//
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

/// Extension providing default implementations for `LVGLObjectProtocol`.
extension LVGLObjectProtocol {

  /// Sets the x-coordinate of the object's position.
  /// - Parameter x: The new x-coordinate.
  public func setPosition(x: Int32) {
    lv_obj_set_x(pointer, x)
  }

  /// Sets the y-coordinate of the object's position.
  /// - Parameter y: The new y-coordinate.
  public func setPosition(y: Int32) {
    lv_obj_set_y(pointer, y)
  }

  /// Sets both x and y coordinates of the object's position.
  /// - Parameters:
  ///   - x: The new x-coordinate.
  ///   - y: The new y-coordinate.
  public func setPosition(x: Int32, y: Int32) {
    lv_obj_set_pos(pointer, x, y)
  }

  /// Sets the width of the object.
  /// - Parameter width: The new width.
  public func setSize(width: Int32) {
    lv_obj_set_width(pointer, width)
  }

  /// Sets the height of the object.
  /// - Parameter height: The new height.
  public func setSize(height: Int32) {
    lv_obj_set_height(pointer, height)
  }

  /// Sets both width and height of the object.
  /// - Parameters:
  ///   - width: The new width.
  ///   - height: The new height.
  public func setSize(width: Int32, height: Int32) {
    lv_obj_set_size(pointer, width, height)
  }

  /// Gets a specific dimension of the object.
  /// - Parameter dimension: The dimension to retrieve.
  /// - Returns: The value of the specified dimension.
  public func getDimension(dimension: LVGLDimension) -> Int32 {
    switch dimension {
    case .width:
      return lv_obj_get_width(pointer)
    case .height:
      return lv_obj_get_height(pointer)
    }
  }

  /// Gets a specific content dimension of the object.
  /// - Parameter dimension: The dimension to retrieve.
  /// - Returns: The value of the specified content dimension.
  public func getContentDimension(dimension: LVGLDimension) -> Int32 {
    switch dimension {
    case .width:
      return lv_obj_get_content_width(pointer)
    case .height:
      return lv_obj_get_content_height(pointer)
    }
  }

  /// Gets a specific self dimension of the object.
  /// - Parameter dimension: The dimension to retrieve.
  /// - Returns: The value of the specified self dimension.
  public func getSelfDimension(dimension: LVGLDimension) -> Int32 {
    switch dimension {
    case .width:
      return lv_obj_get_self_width(pointer)
    case .height:
      return lv_obj_get_self_height(pointer)
    }
  }

  /// Sets both width and height of the object's content.
  /// - Parameters:
  ///   - width: The new content width.
  ///   - height: The new content height.
  public func setContentSize(width: Int32, height: Int32) {
    lv_obj_set_content_width(pointer, width)
    lv_obj_set_content_height(pointer, height)
  }

  /// Sets the width of the object's content.
  /// - Parameter width: The new content width.
  public func setContentSize(width: Int32) {
    lv_obj_set_content_width(pointer, width)
  }

  /// Sets the height of the object's content.
  /// - Parameter height: The new content height.
  public func setContentSize(height: Int32) {
    lv_obj_set_content_height(pointer, height)
  }

  /// Aligns the object according to the specified alignment.
  /// - Parameter alignment: The alignment to apply.
  public func align(alignment: LVAlignment) {
    lv_obj_set_align(pointer, alignment.rawValue)
  }

  /// Aligns the object with an offset.
  /// - Parameters:
  ///   - alignment: The alignment to apply.
  ///   - xOffset: The x-offset from the aligned position.
  ///   - yOffset: The y-offset from the aligned position.
  public func align(alignment: LVAlignment, xOffset: Int32, yOffset: Int32) {
    lv_obj_align(pointer, alignment.rawValue, xOffset, yOffset)
  }

  /// Centers the object within its parent.
  public func center() {
    lv_obj_center(pointer)
  }

  /// Gets the parent object.
  /// - Returns: A pointer to the parent object, or nil if there is no parent.
  public func getParent() -> UnsafeMutablePointer<lv_obj_t>? {
    let parentPointer: UnsafeMutablePointer<lv_obj_t>? = lv_obj_get_parent(pointer)
    return parentPointer
  }

  /// Sets the parent of the object.
  /// - Parameter parentPointer: A pointer to the new parent object.
  public func setParent(parentPointer: UnsafeMutablePointer<lv_obj_t>) {
    lv_obj_set_parent(pointer, parentPointer)
  }

  /// Sets a callback for a specific event type.
  /// - Parameters:
  ///   - eventType: The type of event to listen for.
  ///   - callback: The callback function to be called when the event occurs.
  public func setCallback(
    eventType: LVEventCode,
    callback: @escaping (UnsafeMutablePointer<lv_event_t>?) -> Void
  ) {
    callbackStore[UnsafeMutableRawPointer(pointer!)] = callback

    lv_obj_add_event_cb(
      pointer,
      { cCallback($0) },
      eventType.toLVEventCode(),
      nil
    )
  }

  /// Removes the previously set callback.
  public func removeCallback() {
    callbackStore.removeValue(forKey: UnsafeMutableRawPointer(pointer!))
  }

  /// Deletes the object.
  public mutating func delete() {
    if pointer == nil {
      print("Pointer already deleted")
      print("This will be a fatal error in the future")
    } else {
      lv_obj_delete(pointer)
      pointer = nil
    }
  }

  /// Checks if the object still exists.
  /// - Returns: `true` if the object exists, `false` otherwise.
  public func exists() -> Bool {
    if pointer == nil {
      return false
    }
    return true
  }
}

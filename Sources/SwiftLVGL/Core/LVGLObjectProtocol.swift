//
//  LVGLObjectProtocol.swift
//
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

/// A protocol that defines the interface for LVGL objects.
public protocol LVGLObjectProtocol {
  /// The pointer to the underlying LVGL object.
  var pointer: UnsafeMutablePointer<lv_obj_t>? { get set }

  /// Sets the x-coordinate of the object's position.
  /// - Parameter x: The new x-coordinate.
  func setPosition(x: Int32)

  /// Sets the y-coordinate of the object's position.
  /// - Parameter y: The new y-coordinate.
  func setPosition(y: Int32)

  /// Sets both x and y coordinates of the object's position.
  /// - Parameters:
  ///   - x: The new x-coordinate.
  ///   - y: The new y-coordinate.
  func setPosition(x: Int32, y: Int32)

  /// Sets the size of the object.
  /// - Parameters:
  ///   - width: The new width.
  ///   - height: The new height.
  func setSize(width: Int32, height: Int32)

  /// Sets the height of the object.
  /// - Parameter height: The new height.
  func setSize(height: Int32)

  /// Sets the width of the object.
  /// - Parameter width: The new width.
  func setSize(width: Int32)

  /// Gets a specific dimension of the object.
  /// - Parameter dimension: The dimension to retrieve.
  /// - Returns: The value of the specified dimension.
  func getDimension(dimension: LVGLDimension) -> Int32

  /// Gets a specific content dimension of the object.
  /// - Parameter dimension: The dimension to retrieve.
  /// - Returns: The value of the specified content dimension.
  func getContentDimension(dimension: LVGLDimension) -> Int32

  /// Gets a specific self dimension of the object.
  /// - Parameter dimension: The dimension to retrieve.
  /// - Returns: The value of the specified self dimension.
  func getSelfDimension(dimension: LVGLDimension) -> Int32

  /// Sets the content size of the object.
  /// - Parameters:
  ///   - width: The new content width.
  ///   - height: The new content height.
  func setContentSize(width: Int32, height: Int32)

  /// Sets the content width of the object.
  /// - Parameter width: The new content width.
  func setContentSize(width: Int32)

  /// Sets the content height of the object.
  /// - Parameter height: The new content height.
  func setContentSize(height: Int32)

  /// Aligns the object according to the specified alignment.
  /// - Parameter alignment: The alignment to apply.
  func align(alignment: LVAlignment)

  /// Aligns the object with an offset.
  /// - Parameters:
  ///   - alignment: The alignment to apply.
  ///   - xOffset: The x-offset from the aligned position.
  ///   - yOffset: The y-offset from the aligned position.
  func align(alignment: LVAlignment, xOffset: Int32, yOffset: Int32)

  /// Centers the object within its parent.
  func center()

  /// Gets the parent object.
  /// - Returns: A pointer to the parent object, or nil if there is no parent.
  func getParent() -> UnsafeMutablePointer<lv_obj_t>?

  /// Sets the parent of the object.
  /// - Parameter parentPointer: A pointer to the new parent object.
  func setParent(parentPointer: UnsafeMutablePointer<lv_obj_t>)

  /// Sets a callback for a specific event type.
  /// - Parameters:
  ///   - eventType: The type of event to listen for.
  ///   - callback: The callback function to be called when the event occurs.
  func setCallback(
    eventType: LVEventCode,
    callback: @escaping (UnsafeMutablePointer<lv_event_t>?) -> Void)

  /// Removes the previously set callback.
  func removeCallback()

  /// Deletes the object.
  mutating func delete()

  /// Checks if the object still exists.
  /// - Returns: `true` if the object exists, `false` otherwise.
  func exists() -> Bool

  /*
      TODO:
      func refreshSize() -> bool // lv_obj_refr_size
      func setLayout(layout: UInt32) // lv_obj_set_layout
      func isLayoutPositioned() -> bool // lv_obj_is_layout_positioned
      func setLayoutAsDirty() // lv_obj_mark_layout_as_dirty
      func updateLayout() // lv_obj_update_layout
      func align(to: UnsafeMutablePointer<lv_obj_t>? = nil, alignment: LVAlignment, xOffset: Int32, yOffset: Int32) // lv_obj_align_to
      func copyCoords(area to: UnsafeMutablePointer<lv_area_t>) // lv_obj_get_coords

      // Get Coords lv_obj_get_x, lv_obj_get_x2, lv_obj_get_y, lv_obj_get_y2, lv_obj_get_x_aligned, lv_obj_get_y_aligned

      and a few more...

      */
}

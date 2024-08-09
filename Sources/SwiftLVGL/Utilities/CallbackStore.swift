//
//  CallbackStore.swift
//
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

/// A global dictionary that stores callback functions for LVGL objects.
///
/// The key is a raw pointer to the LVGL object, and the value is the callback function.
public var callbackStore: [UnsafeMutableRawPointer: (UnsafeMutablePointer<lv_event_t>?) -> Void] =
  [:]

/// A C-compatible callback function that bridges LVGL events to Swift callbacks.
///
/// This function is used as the actual callback for LVGL events. It looks up the appropriate
/// Swift callback in the `callbackStore` based on the event target, and then calls that callback.
///
/// - Parameter event: A pointer to the LVGL event structure.
public func cCallback(_ event: UnsafeMutablePointer<lv_event_t>?) {
  guard let event = event else { return }
  let target = lv_event_get_target(event)
  if let targetPointer = UnsafeMutableRawPointer(target),
    let callback = callbackStore[targetPointer]
  {
    callback(event)
  }
}

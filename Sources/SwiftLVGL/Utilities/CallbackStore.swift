//
//  CallbackStore.swift
//
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

public var callbackStore: [UnsafeMutableRawPointer: (UnsafeMutablePointer<lv_event_t>?) -> Void] =
  [:]

public func cCallback(_ event: UnsafeMutablePointer<lv_event_t>?) {
  guard let event = event else { return }
  let target = lv_event_get_target(event)
  if let targetPointer = UnsafeMutableRawPointer(target),
    let callback = callbackStore[targetPointer]
  {
    callback(event)
  }
}

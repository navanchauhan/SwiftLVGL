//
//  LVGLObject.swift
//
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

public extension LVGLObjectProtocol {

    func setPosition(x: Int32) {
        lv_obj_set_x(pointer, x)
    }

    func setPosition(y: Int32) {
        lv_obj_set_y(pointer, y)
    }

    func setPosition(x: Int32, y: Int32) {
        lv_obj_set_pos(pointer, x, y)
    }

    func setSize(width: Int32) {
        lv_obj_set_width(pointer, width)
    }

    func setSize(height: Int32) {
        lv_obj_set_height(pointer, height)
    }

    func setSize(width: Int32, height: Int32) {
        lv_obj_set_size(pointer, width, height)
    }

    func getDimension(dimension: LVGLDimension) -> Int32 {
        switch dimension {
        case .width:
            return lv_obj_get_width(pointer)
        case .height:
            return lv_obj_get_height(pointer)
        }
    }

    func getContentDimension(dimension: LVGLDimension) -> Int32 {
        switch dimension {
        case .width:
            return lv_obj_get_content_width(pointer)
        case .height:
            return lv_obj_get_content_height(pointer)
        }
    }

    func getSelfDimension(dimension: LVGLDimension) -> Int32 {
        switch dimension {
        case .width:
            return lv_obj_get_self_width(pointer)
        case .height:
            return lv_obj_get_self_height(pointer)
        }
    }

    func setContentSize(width: Int32, height: Int32) {
        lv_obj_set_content_width(pointer, width)
        lv_obj_set_content_height(pointer, height)
    }

    func setContentSize(width: Int32) {
        lv_obj_set_content_width(pointer, width)
    }

    func setContentSize(height: Int32) {
        lv_obj_set_content_height(pointer, height)
    }

    func align(alignment: LVAlignment) {
        lv_obj_set_align(pointer, alignment.rawValue)
    }

    func align(alignment: LVAlignment, xOffset: Int32, yOffset: Int32) {
        lv_obj_align(pointer, alignment.rawValue, xOffset, yOffset)
    }

    func center() {
        lv_obj_center(pointer)
    }

    func getParent() -> UnsafeMutablePointer<lv_obj_t>? {
        let parentPointer: UnsafeMutablePointer<lv_obj_t>? = lv_obj_get_parent(pointer)
        return parentPointer
    }

    func setParent(parentPointer: UnsafeMutablePointer<lv_obj_t>) {
        lv_obj_set_parent(pointer, parentPointer)
    }

    func setCallback(
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

    func removeCallback() {
        callbackStore.removeValue(forKey: UnsafeMutableRawPointer(pointer!))
    }

    mutating func delete() {
        if pointer == nil {
            print("Pointer already exists")
            print("This will be a fatal error in the future")
        } else {
            lv_obj_delete(pointer)
            pointer = nil

        }
    }

    func exists() -> Bool {
        if pointer == nil {
            return false
        }
        return true
    }
}

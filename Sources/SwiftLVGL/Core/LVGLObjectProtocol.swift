//
//  LVGLObjectProtocol.swift
//  
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

public protocol LVGLObjectProtocol {
    var pointer: UnsafeMutablePointer<lv_obj_t>? { get set }

    func setPosition(x: Int32)
    func setPosition(y: Int32)
    func setPosition(x: Int32, y: Int32)

    func setSize(width: Int32, height: Int32)
    func setSize(height: Int32)
    func setSize(width: Int32)

    func getDimension(dimension: LVGLDimension) -> Int32
    func getContentDimension(dimension: LVGLDimension) -> Int32
    func getSelfDimension(dimension: LVGLDimension) -> Int32

    func setContentSize(width: Int32, height: Int32)
    func setContentSize(width: Int32)
    func setContentSize(height: Int32)

    func align(alignment: LVAlignment)
    func align(alignment: LVAlignment, xOffset: Int32, yOffset: Int32)
    func center()

    func getParent() -> UnsafeMutablePointer<lv_obj_t>?
    func setParent(parentPointer: UnsafeMutablePointer<lv_obj_t>)

    func setCallback(
        eventType: LVEventCode, _ callback: @escaping (UnsafeMutablePointer<lv_event_t>?) -> Void)
    func removeCallback()

    mutating func delete()
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

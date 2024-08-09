//
//  LVEventCode.swift
//  
//
//  Created by Navan Chauhan on 8/9/24.
//

import CLVGL

public enum LVEventCode: Int {
    case all = 0
    case pressed
    case pressing
    case pressLost
    case shortClicked
    case longPressed
    case longPressedRepeat
    case clicked
    case released
    case scrollBegin
    case scrollThrowBegin
    case scrollEnd
    case scroll
    case gesture
    case key
    case rotary
    case focused
    case defocused
    case leave
    case hitTest
    case indevReset
    case hoverOver
    case hoverLeave
    case coverCheck
    case refreshExtDrawSize
    case drawMainBegin
    case drawMain
    case drawMainEnd
    case drawPostBegin
    case drawPost
    case drawPostEnd
    case drawTaskAdded
    case valueChanged
    case insert
    case refresh
    case ready
    case cancel
    case create
    case delete
    case childChanged
    case childCreated
    case childDeleted
    case screenUnloadStart
    case screenLoadStart
    case screenLoaded
    case screenUnloaded
    case sizeChanged
    case styleChanged
    case layoutChanged
    case getSelfSize
    case invalidateArea
    case resolutionChanged
    case colorFormatChanged
    case refreshRequest
    case refreshStart
    case refreshReady
    case renderStart
    case renderReady
    case flushStart
    case flushFinish
    case flushWaitStart
    case flushWaitFinish
    case vsync
    case preprocess
    case last = 1000

    func toLVEventCode() -> lv_event_code_t {
        return lv_event_code_t(rawValue: UInt32(self.rawValue)) // UInt16 on Pi Pico
    }
}


public extension UnsafeMutablePointer<lv_event_t> {
    var eventCode: LVEventCode? {
        let rawValue = Int(lv_event_get_code(self).rawValue)
        return LVEventCode(rawValue: rawValue)
    }
}

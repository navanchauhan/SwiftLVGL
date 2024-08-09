import CLVGL
import SwiftLVGL

@main
struct Main {
    static func main() {
        lv_init()
        let _ = lv_sdl_window_create(480, 480)
        let _ = lv_sdl_mouse_create()
        
        var myCounter: Int = 0
        
        let label = LVGLLabel("", alignment: .bottomMid)
        let button = LVGLButton("Click Me", eventType: .pressed) { event in
                    if let event = event, event.eventCode == .pressed {
                        myCounter += 1
                        label.setText("You clicked the button \(myCounter) times")
                    }
                }
        let _ = LVGLButton("Shift Button", alignment: .bottomRight, eventType: .pressed) { event in
            button.align(alignment: .leftMid)
        }
        
        let _ = LVGLSlider("", alignment: .topMid, yOffset: 50)

                let _ = LVGLSwitch(alignment: .rightMid)
        
        while true {
            lv_timer_handler()
            usleep(5000)
        }
    }
}

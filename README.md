# SwiftLVGL

Yet another Swift wrapper for LVGL

```swift
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
```

You can run this example by running the `SwiftLVGLDemo` target.

## Dependencies

For running `SwiftLVGLDemo` you will need to install the SDL2 library.


On macOS, you can install SDL2 using Homebrew:

```
brew install sdl2
```

On Debian based distros, you can install SDL2 by using apt:

```
sudo apt update && sudo apt install libsdl2-dev
```

This package defaults to using a minimal lvgl configuration with SDL2 enabled. To provide your own `LV_CONF.h` set `LV_CONF_PATH=<path_to_conf>` in your environment (I think you will have to disable building LVGLSwiftDemo)


## Using with Embedded Swift

Since the `SwiftLVGL` target build requires sdl2, I haven't tried to directly use this as a Swift package for embedded Swift. 

Instead, the `combine.py` script dumps the content of SwiftLVGL into a single file named `SwiftyLVGL`. You can then integrate this in your CMakefile by building it with your custom `LV_CONF.h` file residing in the include directory in your project root.

Example CMakeLists.txt

```
cmake_minimum_required(VERSION 3.29)
set(ENV{TOOLCHAINS} "Swift Development Snapshot")
...
include_directories(./include)
add_subdirectory(lib/lvgl)
include_directories(./lib/lvgl)
...
add_definitions(-DLV_CONF_PATH="${PROJECT_SOURCE_DIR}/include/lv_conf.h")
...
add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
    COMMAND
        ${SWIFTC}
        -target armv6m-none-none-eabi -Xcc -mfloat-abi=soft -Xcc -fshort-enums
        -Xcc -DCYW43_LWIP
        -Xcc -DPICO_CYW43_ARCH_THREADSAFE_BACKGROUND
        -Xcc -I$ENV{PICO_SDK_PATH}/lib/lwip/src/include
        -Xcc -I${CMAKE_CURRENT_LIST_DIR}/include
        -Xfrontend -function-sections -enable-experimental-feature Embedded -wmo -parse-as-library
        #-no-allocations
        $$\( echo '$<TARGET_PROPERTY:pico-swift-display,INCLUDE_DIRECTORIES>' | tr '\;' '\\n' | sed -e 's/\\\(.*\\\)/-Xcc -I\\1/g' \)
        $$\( echo '${CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES}'             | tr ' '  '\\n' | sed -e 's/\\\(.*\\\)/-Xcc -I\\1/g' \)
        -import-bridging-header ${CMAKE_CURRENT_LIST_DIR}/BridgingHeader.h
        ${CMAKE_CURRENT_LIST_DIR}/Main.swift
        ${CMAKE_CURRENT_LIST_DIR}/SwiftyLVGL.swift
        -c -o ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
    DEPENDS
        ${CMAKE_CURRENT_LIST_DIR}/BridgingHeader.h
        ${CMAKE_CURRENT_LIST_DIR}/Main.swift
        ${CMAKE_CURRENT_LIST_DIR}/SwiftyLVGL.swift
)

```

Where `./lib/lvgl` contains the git repository for `lvgl` and your `BridgingHeader.h` contains 

```
...
#include "lvgl.h"
...
```

// swift-tools-version: 5.10
import PackageDescription

let lvConfPath: String = Context.environment["LV_CONF_PATH"] ?? "\(Context.packageDirectory)/Sources/CLVGL/lv_conf.h"

#if os(macOS)
let sdlCFlags = [Context.environment["SDL_INCLUDE_PATH"] ?? "-I/opt/homebrew/include"]
#else
let sdlCFlags = [Context.environment["SDL_INCLUDE_PATH"] ?? ""]
#endif

let package = Package(
    name: "SwiftLVGL",
    products: [
    .library(name: "CLVGL", targets: ["CLVGL"]),
        .library(name: "SwiftLVGL", targets: ["SwiftLVGL"]),
    ],
    targets: [
        .target(
            name: "CLVGL",
            dependencies: [],
            exclude: ["lvgl/demos", "lvgl/examples", "lvgl/tests"],
            cSettings: [
                .headerSearchPath("lvgl"),
                .headerSearchPath("."),
                .define("LV_CONF_INCLUDE_SIMPLE"),
                .define("LV_CONF_PATH", to: lvConfPath),
                .unsafeFlags(sdlCFlags)
            ],
            linkerSettings: [.unsafeFlags(["-L/opt/homebrew/lib", "-lSDL2"])]
        ),
        .target(
            name: "SwiftLVGL",
            dependencies: ["CLVGL"]
        ),
        .executableTarget(
            name: "SwiftLVGLDemo",
            dependencies: ["SwiftLVGL"]
        )
    ]
)

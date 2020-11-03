// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ArrayPlusTuple",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(name: "ArrayPlusTuple", targets: ["ArrayPlusTuple"])
    ],
    dependencies: [
        .package(url: "https://github.com/CuratoOpenSource/InjectableLoggers", from: "2.1.1"),
    ],
    targets: [
        .target(
            name: "ArrayPlusTuple",
            dependencies: [.byName(name: "InjectableLoggers")],
            path: "ArrayPlusTuple"
        ),
    ],
    swiftLanguageVersions: [.v5]
)

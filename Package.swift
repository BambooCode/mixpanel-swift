// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Mixpanel",
    platforms: [
      .iOS(.v11),
      .tvOS(.v11),
      .macOS(.v10_13),
      .watchOS(.v4)
    ],
    products: [
        .library(name: "Mixpanel", targets: ["Mixpanel"])
    ],
     dependencies: [
        .package(url: "https://github.com/duckduckgo/GRDB.swift", from: "2.3.0"),
    ],
    targets: [
        .target(
            name: "Mixpanel",
            path: "Sources",
            dependencies: ["SQLCipher"],
            resources: [
                .copy("Mixpanel/PrivacyInfo.xcprivacy")
            ]
        )
    ]
)

// swift-tools-version:5.7


import Foundation
import PackageDescription

// Don't rely on those environment variables. They are ONLY testing conveniences:
// $ SQLITE_ENABLE_FTS5=1 SQLITE_ENABLE_PREUPDATE_HOOK=1 make test_SPM
var swiftSettings: [SwiftSetting] = []
var cSettings: [CSetting] = []
if ProcessInfo.processInfo.environment["SQLITE_ENABLE_FTS5"] == "1" {
    swiftSettings.append(.define("SQLITE_ENABLE_FTS5"))
}
if ProcessInfo.processInfo.environment["SQLITE_ENABLE_PREUPDATE_HOOK"] == "1" {
    swiftSettings.append(.define("SQLITE_ENABLE_PREUPDATE_HOOK"))
}

swiftSettings.append(contentsOf: [
    .define("SQLITE_HAS_CODEC"),
    .define("SQLITE_ENABLE_FTS5")
])

cSettings.append(contentsOf: [
    .define("SQLITE_HAS_CODEC"),
    .define("SQLITE_TEMP_STORE", to: "2"),
    .define("SQLITE_SOUNDEX"),
    .define("SQLITE_THREADSAFE"),
    .define("SQLITE_ENABLE_RTREE"),
    .define("SQLITE_ENABLE_STAT3"),
    .define("SQLITE_ENABLE_STAT4"),
    .define("SQLITE_ENABLE_COLUMN_METADATA"),
    .define("SQLITE_ENABLE_MEMORY_MANAGEMENT"),
    .define("SQLITE_ENABLE_LOAD_EXTENSION"),
    .define("SQLITE_ENABLE_FTS4"),
    .define("SQLITE_ENABLE_FTS4_UNICODE61"),
    .define("SQLITE_ENABLE_FTS3_PARENTHESIS"),
    .define("SQLITE_ENABLE_UNLOCK_NOTIFY"),
    .define("SQLITE_ENABLE_JSON1"),
    .define("SQLITE_ENABLE_FTS5"),
    .define("SQLCIPHER_CRYPTO_CC"),
    .define("HAVE_USLEEP", to: "1"),
    .define("SQLITE_MAX_VARIABLE_NUMBER", to: "99999")
])

let sqlCipherCSettings = cSettings + [
    .define("NDEBUG"),
    .define("HAVE_GETHOSTUUID", to: "0")
]

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
    targets: [
        .target(
            name: "Mixpanel",
            dependencies: ["SQLCipher"],
            path: "Sources",
            resources: [
                .copy("Mixpanel/PrivacyInfo.xcprivacy")
            ],
            cSettings: cSettings,
            swiftSettings: swiftSettings
        ),
        .target(
            name: "SQLCipher",
            path: "SQLCipher",
            cSettings: sqlCipherCSettings)
    ],
    swiftLanguageVersions: [.v5]
)

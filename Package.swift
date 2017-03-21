import PackageDescription

let package = Package(
    name: "PerfectREST",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/SwiftORM/Postgres-StORM.git", majorVersion: 1, minor: 0),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2, minor: 1)
        ]
)

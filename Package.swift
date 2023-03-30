// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "HackAssembler",
  products: [
    .executable(
      name: "HackAssembler",
      targets: ["HackAssembler"]),
  ],
  dependencies: [
    .package(url: "https://github.com/EZabolotniy/files.git", from: "0.1.0"),
    .package(url: "https://github.com/EZabolotniy/string-utils.git", from: "0.1.1"),
  ],
  targets: [
    .executableTarget(
      name: "HackAssembler",
      dependencies: [
        .product(name: "Files", package: "Files"),
        .product(name: "RemoveComments", package: "string-utils"),
      ]
    )
  ]
)

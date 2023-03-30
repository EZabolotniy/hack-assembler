//
//  Utils.swift
//  HackAssembler
//
//  Created by Evgeniy Zabolotniy on 30.03.2023.
//

import Foundation

func writeToStdErr(_ str: String) {
  let handle = FileHandle.standardError
  if let data = str.data(using: .utf8) {
    handle.write(data)
  }
}

extension String {
  var isInteger: Bool {
    Int(self) != nil
  }

  func toBinary(size: Int? = nil) -> String? {
    let binary = Int(self).flatMap { String($0, radix: 2) }
    if let size, let binary {
      return String(
        [Character](repeating: "0", count: size - binary.count)
      ) + binary
    }
    return binary
  }
}

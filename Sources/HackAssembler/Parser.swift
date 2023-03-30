//
//  Parser.swift
//  HackAssembler
//
//  Created by Evgeniy Zabolotniy on 29.03.2023.
//

import Foundation
import RemoveComments

func parse(_ line: String) throws -> AssemblyCommand? {
  let commandString = line.removeComments()
  guard !commandString.isEmpty else { return nil }
  return try AssemblyCommand(string: commandString)
}

extension AssemblyCommand {
  fileprivate init(string: String) throws {
    guard let firstChar = string.first else {
      preconditionFailure("Command string should not be empty")
    }
    if firstChar == "(" {
      let startIndex = string.index(after: string.startIndex)
      let endIndex = string.index(before: string.endIndex)
      self = .label(String(string[startIndex..<endIndex]))
    }
    else {
      self = .instruction(try Instruction(string: string))
    }
  }
}

extension Instruction {
  fileprivate init(string: String) throws {
    guard let firstChar = string.first else {
      preconditionFailure("Instruction string should not be empty")
    }
    if firstChar == "@" {
      let startIndex = string.index(after: string.startIndex)
      self = .A(symbol: String(string.suffix(from: startIndex)))
    } else {
      let destAndOther = string.split(separator: "=")
      let compAndJump = destAndOther.last!.split(separator: ";")

      var dest: Destination?
      if string.contains("="), let destMnemonic = destAndOther.first {
        dest = Destination(rawValue: String(destMnemonic))
        if dest == nil {
          throw ParserError.failedToParse("\(destMnemonic) in \(string)")
        }
      }

      var jump: Jump?
      if string.contains(";"), let jumpMnemonic = compAndJump.last {
        jump = Jump(rawValue: String(jumpMnemonic))
        if jump == nil {
          throw ParserError.failedToParse("\(jumpMnemonic) in \(string)")
        }
      }

      guard let comp = Computation(rawValue: String(compAndJump.first!)) else {
        throw ParserError.failedToParse("\(compAndJump.first!) in \(string)")
      }

      self = .C(dest: dest, comp: comp, jump: jump)
    }
  }
}

enum ParserError: Error {
  case failedToParse(String)
}

//
//  SymbolTable.swift
//  HackAssembler
//
//  Created by Evgeniy Zabolotniy on 30.03.2023.
//

import Foundation

class SymbolTable {
  private var table = [String: Int]()

  private init(_ table: [String: Int]) {
    self.table = table
  }

  func contains(_ symbol: String) -> Bool {
    table[symbol] != nil
  }

  func add(symbol: String, address: Int) {
    table[symbol] = address
  }

  func address(of symbol: String) -> Int? {
    table[symbol]
  }
}

extension SymbolTable {
  static let shared = SymbolTable([
    "SP":     0,
    "LCL":    1,
    "ARG":    2,
    "THIS":   3,
    "THAT":   4,
    "R0":     0,
    "R1":     1,
    "R2":     2,
    "R3":     3,
    "R4":     4,
    "R5":     5,
    "R6":     6,
    "R7":     7,
    "R8":     8,
    "R9":     9,
    "R10":    10,
    "R11":    11,
    "R12":    12,
    "R13":    13,
    "R14":    14,
    "R15":    15,
    "SCREEN": 16384,
    "KBD":    24576,
  ])
}

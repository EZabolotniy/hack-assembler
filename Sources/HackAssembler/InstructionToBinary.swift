//
//  InstructionToBinary.swift
//  HackAssembler
//
//  Created by Evgeniy Zabolotniy on 29.03.2023.
//

import Foundation

extension Instruction {
  func toBinary(
    symbolTable: inout SymbolTable,
    variableAdrress: inout Int
  ) -> String {
    switch self {
    case .A(var symbol):
      if !symbol.isInteger {
        if let address = symbolTable.address(of: symbol) {
          symbol = String(address)
        } else {
          symbolTable.add(symbol: symbol, address: variableAdrress)
          symbol = String(variableAdrress)
          variableAdrress += 1
        }
      }
      return "0\(symbol.toBinary(size: 15)!)"
    case .C(let dest, let comp, let jump):
      return "111\(comp.binary)\(dest?.binary ?? "000")\(jump?.binary ?? "000")"
    }
  }
}

extension Instruction.Destination {
  var binary: String {
    switch self {
    case .M:   return "001"
    case .D:   return "010"
    case .MD:  return "011"
    case .A:   return "100"
    case .AM:  return "101"
    case .AD:  return "110"
    case .AMD: return "111"
    }
  }
}

extension Instruction.Jump {
  var binary: String {
    switch self {
    case .JGT: return "001"
    case .JEQ: return "010"
    case .JGE: return "011"
    case .JLT: return "100"
    case .JNE: return "101"
    case .JLE: return "110"
    case .JMP: return "111"
    }
  }
}

extension Instruction.Computation {
  var binary: String {
    switch self {
    case .zero:      return "0101010"
    case .one:       return "0111111"
    case .minusOne:  return "0111010"
    case .D:         return "0001100"
    case .A:         return "0110000"
    case .M:         return "1110000"
    case .notD:      return "0001101"
    case .notA:      return "0110001"
    case .notM:      return "1110001"
    case .minusD:    return "0001111"
    case .minusA:    return "0110011"
    case .minusM:    return "1110011"
    case .DPlusOne:  return "0011111"
    case .APlusOne:  return "0110111"
    case .MPlusOne:  return "1110111"
    case .DMinusOne: return "0001110"
    case .AMinusOne: return "0110010"
    case .MMinusOne: return "1110010"
    case .DPlusA:    return "0000010"
    case .DPlusM:    return "1000010"
    case .DMinusA:   return "0010011"
    case .DMinusM:   return "1010011"
    case .AMinusD:   return "0000111"
    case .MMinusD:   return "1000111"
    case .DAndA:     return "0000000"
    case .DAndM:     return "1000000"
    case .DOrA:      return "0010101"
    case .DOrM:      return "1010101"
    }
  }
}

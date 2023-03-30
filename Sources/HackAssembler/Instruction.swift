//
//  Instruction.swift
//  HackAssembler
//
//  Created by Evgeniy Zabolotniy on 29.03.2023.
//

import Foundation

/**
 Instruction is an enum that represents Hack computer Instructions
 - A – Address instruction
 - C – Computation instruction
 */
enum Instruction {
  case A(symbol: String)
  case C(dest: Destination?, comp: Computation, jump: Jump?)
}

extension Instruction {
  /// Assembly Mnemonics of Destination
  enum Destination: String {
    case M, D, MD, A, AM, AD, AMD
  }

  /// Assembly Mnemonics of Computation
  enum Computation: String {
    case zero = "0"
    case one = "1"
    case minusOne = "-1"
    case D
    case A
    case M
    case notD = "!D"
    case notA = "!A"
    case notM = "!M"
    case minusD = "-D"
    case minusA = "-A"
    case minusM = "-M"
    case DPlusOne = "D+1"
    case APlusOne = "A+1"
    case MPlusOne = "M+1"
    case DMinusOne = "D-1"
    case AMinusOne = "A-1"
    case MMinusOne = "M-1"
    case DPlusA = "D+A"
    case DPlusM = "D+M"
    case DMinusA = "D-A"
    case DMinusM = "D-M"
    case AMinusD = "A-D"
    case MMinusD = "M-D"
    case DAndA = "D&A"
    case DAndM = "D&M"
    case DOrA = "D|A"
    case DOrM = "D|M"
  }

  /// Assembly Mnemonics of Jumn
  enum Jump: String {
    case JGT, JEQ, JGE, JLT, JNE, JLE, JMP
  }
}

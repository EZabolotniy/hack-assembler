//
//  HackAssembler.swift
//  HackAssembler
//
//  Created by Evgeniy Zabolotniy on 29.03.2023.
//

import Foundation
import Files

@main
public struct HackAssembler {

  private static var symbolTable = SymbolTable.shared
  private static let variablesStartAddress = 16

  public static func main() {
    // Setup
    checkNumberOfArguments()
    tryOpenInputFile()
    tryCreateOutputFile()

    // First Pass – build symbol table with labels
    addLabelsToSymbolTable(
      lines: FileLineReader.readLines(path: inputFilePath)!,
      symbolTable: symbolTable
    )

    // Second Pass – translate each line to binary
    translateLinesToBinary(
      lines: FileLineReader.readLines(path: inputFilePath)!,
      symbolTable: &symbolTable,
      variablesStartAddress: variablesStartAddress,
      fileWriter: FileLineWriter.createFile(atPath: outputFilePath)!
    )
  }
}

// MARK: - Setup
private func checkNumberOfArguments() {
  guard CommandLine.arguments.count == 2 else {
    writeToStdErr("Expecting file name as an argument!\n")
    exit(EXIT_FAILURE)
  }
}

private func tryOpenInputFile() {
  guard FileLineReader.readLines(path: inputFilePath) != nil else {
    writeToStdErr("Can not read file at path: \(inputFilePath)!\n")
    exit(EXIT_FAILURE)
  }
}

private func tryCreateOutputFile() {
  guard FileLineWriter.createFile(atPath: outputFilePath) != nil else {
    writeToStdErr("Can not write file at path: \(outputFilePath)!\n")
    exit(EXIT_FAILURE)
  }
}

private var inputFilePath: String {
  let currentDirectory = FileManager.default.currentDirectoryPath
  let inputFile = CommandLine.arguments[1]
  return currentDirectory + "/" + inputFile
}

private var inputFile: String {
  CommandLine.arguments[1]
}

private var outputFilePath: String {
  guard let inputFileName = inputFile.split(separator: ".").first else {
    writeToStdErr("Invalid file name: \(inputFile)!\n")
    exit(EXIT_FAILURE)
  }
  let currentDirectory = FileManager.default.currentDirectoryPath
  return currentDirectory + "/" + inputFileName + ".hack"
}

// MARK: - Parsing

private func addLabelsToSymbolTable(
  lines: AnySequence<String>,
  symbolTable: SymbolTable
) {
  var pc = 0
  for line in lines {
    if let command = try? parse(line) {
      switch command {
      case .label(let label):
        symbolTable.add(symbol: label, address: pc)
      case .instruction:
        pc += 1
      }
    }
  }
}

private func translateLinesToBinary(
  lines: AnySequence<String>,
  symbolTable: inout SymbolTable,
  variablesStartAddress: Int,
  fileWriter: FileLineWriter
) {
  var variableAdrress = variablesStartAddress
  for line in lines {
    guard let command = tryParse(line) else {
      continue
    }
    switch command {
    case let .instruction(instruction):
      let binaryCommand = instruction.toBinary(
        symbolTable: &symbolTable,
        variableAdrress: &variableAdrress
      )
      fileWriter.writeLine(binaryCommand)
    case .label:
      break
    }
  }
}

private func tryParse(_ line: String) -> AssemblyCommand? {
  do {
    return try parse(line)
  } catch {
    writeToStdErr("Parser error: \(error)!\n")
    exit(EXIT_FAILURE)
  }
}

//
//  AssemblyCommand.swift
//  HackAssembler
//
//  Created by Evgeniy Zabolotniy on 30.03.2023.
//

import Foundation

enum AssemblyCommand {
  case instruction(Instruction)
  case label(String)
}

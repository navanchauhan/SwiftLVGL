//
//  Color.swift
//
//
//  Created by Navan Chauhan on 8/9/24.
//

public enum Color: UInt32 {
  case blue = 0x003a57
  case white = 0xffffff
  case red = 0xff0000
  case green = 0x00ff00
  case black = 0x000000

  func toHex() -> UInt32 {
    return self.rawValue
  }
}

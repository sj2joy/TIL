

import Foundation

class Dog: NSObject
//CustomStringConvertible, CustomDebugStringConvertible (nsobject를 쓰면 이거 두갠 지워줘야함)
{
    
  let name = "Tory"
  let age = 5
  let feature: [String: String] = [
    "breed": "Poodle",
    "tail": "short"
  ]
    override var description: String {
        "Dog's name: \(name), age: \(age)"
    }
    override var debugDescription: String {
        "Dog's name: \(name), age: \(age), feature: \(feature)"
    }
}

struct Cat {
  let name = "Lilly"
  let age = 2
  let feature: [String: String] = [
    "breed": "Koshort",
    "tail": "short"
  ]
}

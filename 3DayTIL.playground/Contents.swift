import UIKit



/*
 옵셔널 타입의 문자열 파라미터 3개를 입력받은 뒤, 옵셔널을 추출하여 Unwrapped 된 하나의 문자열로 합쳐서 반환하는 함수
 */

// Optional Binding을 이용한 방식
func combineString1(str1: String?, str2: String?, str3: String?) -> String {
  var combinedString = ""
  if let unwrappedString = str1 {
    combinedString += unwrappedString
  }
  if let unwrappedString = str2 {
    combinedString += unwrappedString
  }
  if let unwrappedString = str3 {
    combinedString += unwrappedString
  }
  return combinedString
}

// Nil-coalescing Operator 를 이용한 방식
func combineString2(str1: String?, str2: String?, str3: String?) -> String {
  let string1 = str1 ?? ""
  let string2 = str2 ?? ""
  let string3 = str3 ?? ""
  return string1 + string2 + string3
}

combineString1(str1: "AB", str2: "CD", str3: "EF")
combineString1(str1: "AB", str2: nil, str3: "EF")
combineString2(str1: "AB", str2: "CD", str3: "EF")
combineString2(str1: "AB", str2: nil, str3: "EF")





/*
 2개의 자연수와 사칙연산(+, -, *, /)을 가진 enum 타입 Arithmetic 을 입력 파라미터로 받아 해당 연산의 결과를 반환하는 함수 구현
 enum Arithmetic {
   case addition, subtraction, multiplication, division
 }
 func calculator(operand1: Int, operand2: Int, op: Arithmetic) -> Int {
   // 코드
 }
 */

print("\n--------------------\n")

enum Arithmetic {
  case addition, subtraction, multiplication, division
}

func calculator(operand1: Int, operand2: Int, op: Arithmetic) -> Int {
  switch op {
  case .addition:
    return operand1 + operand2
  case .subtraction:
    return operand1 - operand2
  case .multiplication:
    return operand1 * operand2
  case .division:
    return Int(operand1 / operand2)
  }
}
print(calculator(operand1: 11, operand2: 5, op: .multiplication))
print(calculator(operand1: 15, operand2: 25, op: .addition))
print(calculator(operand1: 30, operand2: 10, op: .subtraction))
print(calculator(operand1: 12, operand2: 10, op: .multiplication))
print(calculator(operand1: 24, operand2: 6, op: .division))




//: ### 도전과제


/*
 celcius, fahrenheit, kelvin 온도 3가지 케이스를 가진 Temperature enum 타입을 정의
 각 케이스에는 Double 타입의 Associated Value 를 받도록 함
 
 추가로 각 온도를 섭씨 온도로 변환해주는 toCelcius() 함수 구현
 섭씨 = (화씨 - 32) * 5 / 9
 섭씨 = 켈빈 + 273
 */

enum Temperature {
  case celcius(Double)
  case fahrenheit(Double)
  case kelvin(Double)
  
  func toCelcius() -> Double {
    switch self {
    case .celcius(let value): return value
    case .fahrenheit(let value): return (value - 32) * 5 / 9
    case .kelvin(let value): return value + 273
    }
  }
}

var temperature: Temperature = .celcius(30)
temperature.toCelcius()

temperature = .fahrenheit(86)
temperature.toCelcius()

temperature = .kelvin(-273)
temperature.toCelcius()



/*
 각 케이스별로 연산을 수행하고 그 값을 반환하는 evalue 함수 구현
 */

indirect enum ArithmeticExpression {
  case number(Int)
  case addition(ArithmeticExpression, ArithmeticExpression)
  case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
  switch expression {
  case let .number(value):
    return value
  case let .addition(left, right):
    return evaluate(left) + evaluate(right)
  case let .multiplication(left, right):
    return evaluate(left) * evaluate(right)
  }
}

evaluate(five)
evaluate(sum)
evaluate(product)





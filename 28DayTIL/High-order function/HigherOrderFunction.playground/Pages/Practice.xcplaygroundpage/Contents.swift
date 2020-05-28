//: [Previous](@previous)
import Foundation

// 키노트 문제 참고
/*:
 ---
 ## Practice 1
 ---
 */
print("\n---------- [ Practice 1 ] ----------\n")
//정답 및 풀이과정은 ppt에 있음. 내가 한거보다 최적화 할 수 있으니 나중에라도 봐둘 것
struct Pet {
    enum PetType {
        case dog, cat, snake, pig, bird
    }
    var type: PetType
    var age: Int
}

let myPet = [
    Pet(type: .dog, age: 13),
    Pet(type: .dog, age: 2),
    Pet(type: .dog, age: 7),
    Pet(type: .cat, age: 9),
    Pet(type: .snake, age: 4),
    Pet(type: .pig, age: 5),
]

// 1번
//[ 1번 문제 ]
//Pet 타입의 배열을 파라미터로 받아 그 배열에 포함된 Pet 중 강아지의 나이만을 합산한 결과를 반환하는 sumDogAge 함수 구현 func sumDogAge(pets: [Pet]) -> Int

//[ 2번 문제 ]
//Pet 타입의 배열을 파라미터로 받아 모든 Pet이 나이를 1살씩 더 먹었을 때의
//상태를 지닌 새로운 배열을 반환하는 oneYearOlder 함수 구현 func oneYearOlder(of pets: [Pet]) -> [Pet]
func sumDogAge(pets: [Pet]) -> Int {
    return myPet.filter { $0.type == .dog }.reduce(0) { $0 + $1.age }
}
sumDogAge(pets: myPet)

// 2번
func oneYearOlder(of pets: [Pet]) -> [Pet] {
    return pets.map { Pet(type: $0.type, age: $0.age + 1)//여기서 $0  = of pets임
    }
}
oneYearOlder(of: myPet)



/*:
 ---
 ## Practice 2
 ---
 */
print("\n---------- [ Practice 2 ] ----------\n")
//정답 및 풀이과정은 ppt에 있음. 내가 한거보다 최적화 할 수 있으니 나중에라도 봐둘 것
//immutableArray 배열의 각 인덱스와 해당 인덱스의 요소를 곱한 값 중 홀수는 제외하고 짝수에 대해서만 모든 값을 더하여 결과 출력
//단, 아래 1 ~ 3번에 해당하는 함수를 각각 정의하고 이것들을 함께 조합하여 위 문제의 결과를 도출할 것
let immutableArray = Array(1...40)
//1. 배열의 각 요소 * index 값을 반환하는 함수
func multiplyIndex(index: Int, multiply: Int) -> Int {
    index * multiply
}
//2. 짝수 여부를 판별하는 함수
func ismultiplyNumber(number: Int) -> Bool {
    number.isMultiple(of: 2)
}
//func isEven(number: Int) -> Bool {
//    return number & 1 == 0 //이렇게 해도 됨
//}
//3. 두 개의 숫자를 더하여 반환하는 함수
func addSomeNumber(number1: Int, number2: Int) -> Int{
    number1 + number2
}
immutableArray.enumerated()
    .map{ $0 * $1 }
    .filter{ $0.isMultiple(of: 2)}
    .reduce(0){ $0 + $1 }


let array = ["1j", "2d", "3", "4"]

let m1 = array.map({ Int($0) })
print("m1:", m1)

let f1 = array.compactMap({ Int($0) })
print("f1:", f1)

let m2 = array.map({ Int($0) })[0]
print("m2:", m2)

let f2 = array.compactMap({ Int($0) })[0]
print("f2:", f2)

//: [Next](@next)

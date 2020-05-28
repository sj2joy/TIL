//: [Previous](@previous)
/*:
 ---
 ## forEach
 - 컬렉션의 각 요소(Element)에 동일 연산을 적용하며, 반환값이 없는 형태
 ---
 */
print("\n---------- [ forEach ] ----------\n")
//합친거
let immutableArray = [1, 2, 3, 4]

for num in immutableArray {
    print(num, terminator: " ")
}
print()


immutableArray.forEach { num in
    print(num, terminator: " ")
}
print()


immutableArray.forEach {
    print($0, terminator: " ")
}
print()


func printParam(_ num: Int) {
    print(num, terminator: " ")
}
immutableArray.forEach(printParam(_:))
print()


/*:
 ---
 ### Question
 - forEach 와 for 문의 차이점은?
 - 1~10 까지의 숫자 중 짝수만 출력하다가 9가 되면 종료되도록 forEach를 이용해 구현해본 뒤 for 와 비교하여 설명
 ---
 */

for i in 1...10 {
//    print(i)
    guard i != 9 else { break } //9가 됐을 때 종료(10 안찍힘), // 반복문이라서 break, continue같은 명령어 사용
    guard i % 2 == 0 else { continue }
    print(i, terminator: " ")
}
print()


(1...10).forEach {
//    print($0)
    guard $0 < 9 else { return } //9보다 작으면 실행 아니면 return(10찍힘) , // 함수라서 반환값 return 사용
    guard $0 % 2 == 0 else { return }
    print($0, terminator: " ")
}
print()

/*:
 ---
 ## map
 - 컬렉션의 각 요소(Element)에 동일 연산을 적용하여, 변형된 새 컬렉션 반환
 ---
 */

print("\n---------- [ Map ] ----------\n")

let names = ["Chris", "Alex", "Bob", "Barry"]
names
    .map { $0 + "'s name" }
    .forEach { print($0) }

let intArr = Array<Int>(repeating: 2, count: 10)
//for (idx, value) in intArr.enumerated() {
//  idx + value
//}

//형변환
//let ages = ["1", "2", "3"]
//let y = ages.map{ Int($0) } //y가 값이 있을 수도 있고 없을 수도 있으므로 optional타입
//print(ages)
//print(y)

// for 문 비교
var numArr = [Int]()
for (idx, value) in intArr.enumerated() {
    numArr.append(idx + value)
}
print(numArr)

// map
//여기서 intArr은 위에 [2,2,2,2,2,2,2,2] 이거임. 즉 아래는 [ 2+0, 2+1 ... 2+9]를 하는 작업
let indexPlusElement = intArr.enumerated().map {
    return $0 + $1 //return 생략해도 상관없음
} //$0 = idx , $1 = value
let indexPlusElement1 = intArr.enumerated().map{ $0 + $1 }
print(indexPlusElement)
print(indexPlusElement1)
//let indexPlusElement3 = intArr.enumerated().map { (arg: ((Int, Int))) -> Int in
//    let (offset, element) = arg
//    print(offset)
//    return offset + element
//}
//print(indexPlusElement3) //indexPlusElement3 방식은 intArr의 index를 보고 싶을 때 사용

/*:
 ---
 ## filter
 - 컬렉션의 각 요소를 평가하여 조건을 만족하는 요소만을 새로운 컬렉션으로 반환
 ---
 */
print("\n---------- [ filter ] ----------\n")

// let names = ["Chris", "Alex", "Bob", "Barry"]

let containBNames = names //B가 들어간 string만 꺼내는
    .filter { (name) -> Bool in
        return name.contains("B")
}
print(containBNames)

names.filter { $0.contains("B") }
//let x = names.filter { _ in false } //false일 땐 아무것도 출력하지않음
//print(x)
//let y = names.filter { _ in true } // true일 때는 전부 다 출력
//print(y)

let countAlexNames = names
    .filter { $0 == "Alex" }
    .count
print(countAlexNames) //names 배열에 Alex가 몇번 들어가있는지 카운트해주는

let countSomeName = ["jin","jin","jin","jang"]
//let containsName = countSomeName
//    .filter { (name) -> Bool in
//        return name.contains("i")
//}
//print(containsName)
let someCountName = countSomeName
    .filter { $0 == "jin" }
    .count //names 배열에 jin이 몇번 들어가있는지 카운트해주는
print(someCountName)
/*:
 ---
 ## reduce
 - 컬렉션의 각 요소들을 결합하여 단 하나의 타입을 지닌 값으로 반환.   e.g. Int, String 타입
 ---
 */
print("\n---------- [ reduce ] ----------\n")

/*
 (1...100)
 .reduce(<#T##initialResult: Result##Result#>, <#T##nextPartialResult: (Result, Int) throws -> Result##(Result, Int) throws -> Result#>)
 
 Result Type - 결과로 얻고자하는 값의 타입
 
 initialResult - 초기값
 nextPartialResult - (이전 요소까지의 결과값, 컬렉션이 지닌 현재 요소)
 */

let sum1to100 = (1...100).reduce(0) { (sum: Int, next: Int) in
    return sum + next
}
print(sum1to100)
// 0 + 1 = 1
// 1 + 2 = 3
// 3 + 3 = 6
// 6 + 4 = 10
// ....

//더 최소화 할 경우
print((1...100).reduce(0) { $0 + $1 }) //reduce()에서 ()안에는 들어갈 값의 초기값을 넣는거
print((1...100).reduce(0, +))


//직접 더하는 형태 X , return값이 sum이 되는것
//(1...100).reduce(0) { (sum, next) in
//  sum += next
//}

//100은 초기값(타입까지) = int타입의 초기값 100 , 결과값도 Int형이 되어야함
["123","456"].reduce(100) {
    $0 + Int($1)! // 100 + 123 , 223 + 456
}

/*:
 ---
 ### Question
 - 문자열 배열을 reduce를 이용해 하나의 문자열로 합치기
 - 숫자 배열을 reduce를 이용해 하나의 문자열로 합치기
 ---
 */
// 아래 둘 모두 reduce를 이용해 "123" 이라는 문자열이 되도록 만들기
["1", "2", "3"]

let someNum = ["1", "2","3"].reduce("") { $0 + $1 }
print(someNum)
[1, 2, 3]
let someNum2 = [1, 2, 3].reduce("") { $0 + String($1) }
print(someNum2)


/*:
 ---
 ## compactMap
 - 컬렉션의 각 요소(Element)에 동일 연산을 적용하여 변형된 새 컬렉션 반환
 - 옵셔널 제거
 ---
 */
print("\n---------- [ compactMap ] ----------\n")

let optionalStringArr = ["A", nil, "B", nil, "C"]
print(optionalStringArr)
print(optionalStringArr.compactMap { $0 })

//compactMap을 쓰면 nil값은 제거됨
let numbers = [-2, -1, 0, 1, 2]
let positiveNumbers = numbers.compactMap { $0 >= 0 ? $0 : nil }//nil값은 제거되고 0보다 큰수만 출력
print(positiveNumbers)

print(numbers.map { $0 >= 0 ? $0 : nil })

/*:
 ---
 ## flatMap
 - 중첩된 컬렉션을 하나의 컬렉션으로 병합
 ---
 */
print("\n---------- [ flatMap ] ----------\n")

let nestedArr: [[Int]] = [[1, 2, 3], [9, 8, 7], [-1, 0, 1]]
print(nestedArr)
print(nestedArr.flatMap { $0 })

//3중배열에서 flatMap을 쓰면 2중배열이 되고 한번 더 하면 1중배열이 됨
let nestedArr2: [[[Int]]] = [[[1, 2], [3, 4], [5, 6]], [[7, 8], [9, 10]]]
let flattenNumbers1 = nestedArr2.flatMap { $0 }
print(flattenNumbers1)

let flattenNumbers2 = flattenNumbers1.flatMap { $0 }
print(flattenNumbers2)

//위의 과정을 한번에 정리(한번에 2개의 배열을 벗길 때)
let flattenNumber3 = nestedArr2
    .flatMap { $0 }
    .flatMap { $0 }
print(flattenNumber3)




/*:
 ---
 ### Answer
 ---
 */

print("\n---------- [ A. for vs forEach ] ----------\n")

/*
 for문은 반복문이므로 break, continue 키워드 사용
 forEach문은 함수(클로져)이므로 break, continue 대신 return 키워드 사용
 */

for i in 1...10 {
    guard i != 9 else { break } //9가 됐을 때 종료
    guard i % 2 == 0 else { continue }
    print(i, terminator: " ")
}
print()

(1...10).forEach {
    guard $0 < 9 else { return } //9보다 작으면 실행 아니면 return
    guard $0 % 2 == 0 else { return }
    print($0, terminator: " ")
}
print()
print("\n---------- [ A. reduce ] ----------\n")

let merge1 = ["1", "2", "3"].reduce("") { $0 + $1 }
print(merge1)

let merge2 = [1, 2, 3].reduce("") { $0 + String($1) }
print(merge2)

//위 내용을 Full Syntax 로 표현했을 때
//[1, 2, 3]
//  .reduce("") { (str: String, num: Int) in
//    return str + String(num)
//  }






//: [Next](@next)

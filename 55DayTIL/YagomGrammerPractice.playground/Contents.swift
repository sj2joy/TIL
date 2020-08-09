import UIKit

func doSomething() {
    print("do Something")
}
func doAnotherthing() {
    print("do Anotherthing")
}
func excute(tasks: [() -> Void]) {
    for task in tasks {
        task()
    }
}
excute(tasks: [doSomething, doAnotherthing])

enum School: CaseIterable {
    case primary
    case elementary
    case middle
    case high
    case college
    case university
}
let allCases: [School] = School.allCases
print(allCases)

func sayHello(me: String, friends names: String...) -> String {
    var result: String = " "
    
    for friend in names {
        result += "Hello \(friend)" + " "
    }
    result += "I'm " + me + " ! "
    return result
}
print(sayHello(me: "yagom", friends: "sjss", "sjsj"))
print(sayHello(me: "jin"))

struct CoordinatePoint {
    var x: Int
    var y: Int
}
let myPoint = CoordinatePoint(x: 10, y: 5)
class Position {
    var point: CoordinatePoint
    let name: String
    
    init(name: String, currentPoint: CoordinatePoint) {
        self.name = name
        self.point = currentPoint
    }
}
let myPosition: Position = Position(name: "seokjin", currentPoint: myPoint)

class Account {
    var credit: Int = 0 {
        willSet {
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        didSet {
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
        }
    }
    var dollarValue: Double {
        get {
            return Double(credit) / 1000.0
        }
        set {
            credit = Int(newValue * 1000)
            print("잔액을 \(newValue)달러로 변경 중입니다.")
        }
    }
}
class ForeignAccount: Account {
    override var dollarValue: Double {
        willSet {
            print("잔액이 \(dollarValue)에서 \(newValue)로 변경될 예정입니다")
        }
        didSet {
            print("잔액이 \(oldValue)에서 \(dollarValue)로 변경되었습니다.")
        }
    }
}
let myAccount = ForeignAccount()
myAccount.credit = 1000
print("-------------------------------------------------------")
myAccount.dollarValue = 2

class myInfo {
    var height: Double = 143.5 {
        didSet {
            print("내 키가 \(oldValue)에서 \(height)로 성장했습니다")
        }
    }
    var weight: Double = 54.3 {
        didSet {
            print("내 키가 \(oldValue)에서 \(weight)로 증가했습니다")
        }
    }
    
}
var myInfo1 = myInfo()
myInfo1.height = 179.7
myInfo1.weight = 77.3

struct SystemVolume {
    static var volume: Int = 5
    static func mute() {
        self.volume = 0
    }
}
class Navigation {
    var volume: Int = 5
    func guideWay() {
        SystemVolume.mute()
    }
    func finishGuideWay() {
        SystemVolume.volume = self.volume
    }
}

SystemVolume.volume = 10
let myNavi = Navigation()
myNavi.guideWay()
print(SystemVolume.volume)
myNavi.finishGuideWay()
print(SystemVolume.volume)

struct Size {
    var weight = 15.0
    var height = 1111.11
}

enum Student {
    case elementary, middle, high
    case none
    
    init() {
        self = .none
    }
    init?(koreanAge: Int) {
        switch koreanAge {
        case 8...13:
            self = .elementary
        case 14...16:
            self = .middle
        case 17...19:
            self = .high
        default:
            self = .none
        }
    }
    init?(bornAt: Int, currentYear: Int) {
        self.init(koreanAge: currentYear - bornAt + 1)
    }
}
var younger = Student(koreanAge: 16)

younger = Student(bornAt: 1998, currentYear: 2016)

let names: [String] = ["wizplan", "eric", "jin", "chan"]

//일반 함수로 정렬할 때

func backwards(first: String , second: String) -> Bool {
    print("\(first) \(second) 비교중")
    return first > second
}

let reversedByfunc: [String] = names.sorted(by: backwards)
print(reversedByfunc)

//클로저로 정렬할 때
let reversed: [String] = names.sorted (by: { (first: String, second: String) -> Bool in
    return first > second
})
let reversed2: [String] = names.sorted { (first: String, second: String) -> Bool in //하나의 클로저만 있을 경우 소괄호 생략가능 (후행클로저)
    return first > second
}
let reversed3: [String] = names.sorted {//클로저 표현간소화 ( 타입, 매개변수, 리턴값 생략가능 )
     $0 > $1  //클로저 표현식이 한줄일 경우 return 도 생략가능
}
print(reversed)
print(reversed3)
// ----[escaping Closure] --------
print("----------------Escaping Closure----------------")
var completionHandlers: [() -> Void] = []

//func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
//    completionHandlers.append(completionHandler)
//}
typealias VoidClosure = () -> Void
let firstClosure: VoidClosure = {
    print("Closure A")
}
let secondClosure: VoidClosure = {
    print("Closure B")
}
func returnOneClosure(first: @escaping VoidClosure, second: @escaping VoidClosure, shouldReturnFirstClosure: Bool) -> VoidClosure {
    return shouldReturnFirstClosure ? first : second
}
let returnedClosure: VoidClosure = returnOneClosure(first: firstClosure, second: secondClosure, shouldReturnFirstClosure: true)
returnedClosure()
var closures: [VoidClosure] = []
func appendClosure(closure: @escaping VoidClosure) {
    closures.append(closure)
}
print("------------escaping closuer22222------------")

typealias VoidVoidClosure = () -> Void
func withoutClosure(closure: VoidVoidClosure) {
    closure()
}
func withClosure(completionHandler: @escaping VoidVoidClosure) -> VoidVoidClosure {
    return completionHandler
}
class SomeClass {
    var x = 10
    func noEscapeClosure() {
        withoutClosure { x = 200 }
    }
    func escapeClosure() -> VoidVoidClosure {
        return withClosure { self.x = 100 }
    }
}
let instance: SomeClass = SomeClass()
instance.noEscapeClosure()
print(instance.x)
let returnClosure: VoidVoidClosure = instance.escapeClosure()
returnClosure()
print(instance.x)
//AutoClosure
print("--------Auto Closure--------")

var customersInLine: [String] = ["jin","chang","chan","won"]

func serveCustomer(_ customerProvide: @autoclosure () -> String) {
    print("serving \(customerProvide())")
}
serveCustomer(customersInLine.removeFirst())

//guard, optionalBinding
print("--------------guard, optionalBinding------------------")

func greet(_ person:[String: String]) {
    guard let name: String = person["name"] else {
        return
    }
    print("Hello \(name)")
    
    guard let location: String = person["location"] else {
        return
    }
    print("my location is \(location)")
}
var personInfo: [String: String] = [String: String]()
personInfo["name"] = "Jin"
personInfo["location"] = "Incheon"
greet(personInfo)


//map
print("---------------------------map---------------------------")
let numbers: [Int] = [0, 1, 2, 3, 4]
var doubleNumbers: [Int] = []
var stringNumbers: [String] = []

//doubleNumbers = numbers.map({ (number: Int) -> Int in
//    return number * 2
//})
doubleNumbers = numbers.map({
    return $0 * 2
})
stringNumbers = numbers.map({ (number: Int) -> String in
    return "\(number)"
})
print(doubleNumbers)
print(stringNumbers)

let alphabetDict: [String:String] = ["a":"A","b":"B"]
var keys: [String] = alphabetDict.map { (tuple: (String, String)) -> String in
    return tuple.0
}
print(keys)
var values: [String] = alphabetDict.map { $0.1 }
print(values)

//filter
print("------------------filter------------------")
//let evenNumbers: [Int] = numbers.filter { (number:Int) -> Bool in
//    return number % 2 == 0
//}
let evenNumbers: [Int] = numbers.filter { $0 % 2 == 0 }
print(evenNumbers)
let mappedNumbers: [Int] = numbers.map { $0 + 3 }
let filteredNumbers: [Int] = mappedNumbers.filter { $0 % 2 == 0 }
let chainNumbers: [Int] = numbers.map{$0 + 3}.filter{$0 % 2 == 0}
print(filteredNumbers)
print(chainNumbers)

//reduce
print("------------------reduce------------------")

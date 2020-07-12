import UIKit

typealias infoResult = (Int, Character, String)

func getUserInfo() -> infoResult {
    let gender: Character = "M"
    let height = 180
    let name = "JSJ"
    return (height, gender, name)
}


func printHello(to name: String, _ msg: String) {
    print("\(name)님, \(msg)ㅇㅇㅇ")
}
printHello(to: "tjrwls", "hi")

func avg(score:Int...) -> Double {
    var total = 0
    for i in score {
        total += i
    }
    return (Double(total) / Double(score.count))
}
print(avg(score: 10,30,50,70))

var value = [1 ,4 ,7 ,3 ,9]

//func order(s1: Int, s2: Int) -> Bool {
//    if s1 > s2 {
//        return true
//    } else {
//        return false
//    }
//}
//let sortedValue = value.sorted(by: { (s1: Int, s2: Int) in return s1 > s2 })
let sortedValue = value.sorted(by:{ $0 > $1 })
let sortValue = value.sorted{$0 > $1}
print(sortedValue)
print(sortValue)

func callback(fn: @escaping() -> Void) {
    let f = fn
    f()
}

callback {
    print("success")
}

struct Resolution {
    var width = 0
    var height = 0
    
}

let insRes = Resolution(width: 33, height: 10)
insRes.width
var insRes2 = insRes
insRes2.width = 1230

class VideoMode {
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
let insVideo = VideoMode()
insVideo.name = "Class Property name"
let insVideo2 = insVideo
insVideo2.name = "hello"

//class User {
//    var name: String
//
//    init() {
//        self.name = ""
//    }
//}
//let userInfo = User()
//userInfo.name = "333"

//MARK: - Lazy var

class OnCreate {
    init() {
        print("OnCreate")
    }
}

class LazyTest {
    var base = 0
    lazy var late = OnCreate()
    
    init() {
        print("Lazy Test")
    }
}
let lz = LazyTest()
lz.late
//MARK: - Get, Set

struct UserInfo {
    var birth: Int!
    
    var thisYear: Int! {
        get {
            let df = DateFormatter()
            df.dateFormat = "yyyy"
            return Int(df.string(from: Date()))
        }
    }
    var age: Int {
        get {
            return (self.thisYear - self.birth) + 1
        }
    }
}
let info = UserInfo(birth: 1989)
print(info.age)

struct Position {
    var x: Double = 0.0
    var y: Double = 0.0
}
struct Size {
    var width: Double = 0.0
    var height: Double = 0.0
}

struct Rect {
    var origin = Position()
    var size = Size()
    var center: Position {
        get {
            let centerX = self.origin.x + (self.size.width / 2)
            let centerY = self.origin.y + (self.size.height / 2)
            return Position(x: centerX, y: centerY)
        }
        set(newValue) {
            self.origin.x = newValue.x - (size.width / 2)
            self.origin.y = newValue.y - (size.height / 2)
        }
    }
}

let p = Position(x: 20.0, y: 20.0)
let s = Size(width: 10.0, height: 10.0)
var square = Rect(origin: p, size: s)
square.center = Position(x: 20, y: 20)
square.center.x
square.center.y
square.origin.x
square.origin.y

//MARK: - willSet , didSet

struct Job {
    var income: Int = 0 {
        willSet(newIncome) {
            print("이번달 월급은 \(newIncome)원 입니다.")
        }
        didSet {
            if income > oldValue {
                print("월급이 \(income - oldValue)원 증가되셨습니다. 축하드림당")
            } else {
                print("월급이 삭감되셨습니다. 유감이에여ㅋㅋㅋ")
            }
        }
    }
}
var job = Job(income: 3150000)
job.income = 3300000

struct asdf {
    var width = 10
    var height = 11
    
    func judge() -> Bool {
        let width = 30
        return self.width == width
    }
}
var asdd = asdf()
asdd.judge()
//MARK: - mutating

struct Point {
    var x = 0.0
    var y = 0.0
    
    mutating func moveByX(x deltaX: Double, y deltaY: Double) {
        self.x += deltaX
        self.y += deltaY
    }
}
var point = Point(x: 10.5, y: 12.0)
point.moveByX(x: 3.0, y: 4.5)

class Location {
    var x = 0.0
    var y = 0.0
    
    func moveByX(xx deltaX: Double, yy deltaY: Double) {
        self.x += deltaX
        self.y += deltaY
    }
}
var loc = Location()
loc.x = 10.3
loc.y = 11.3
loc.moveByX(xx: 3, yy: 4)


//MARK: - 타입 프로퍼티

class typeProperty {
    class func innerProperty() {
        print("success")
    }
}
let typeP = typeProperty()
//typeP.innerProperty  <--- 타입프로퍼티라 인스턴스적용해서 호출 불가능
typeProperty.innerProperty()

//MARK: - 상속(Inheritance)

class A {
    var name = "Class A"
    
    var description: String {
        return "This class name is \(self.name)"
    }
    func foo() {
        print("\(self.name)'s method foo is called")
    }
}
let a = A()
a.description
a.name
a.foo()

class B: A {
    var prop = "Class B"
    
    func boo() -> String {
        return "Class B prop = \(self.prop)"
    }
}
let b = B()
b.prop
b.boo()
b.name
b.name = "Class C"
b.foo()


//MARK: - overriding

class Vehicle {
    var currentSpeed = 0.0
    
    var description: String {
        return "시간당 \(self.currentSpeed)의 속도로 이동 중"
    }
    func makeNoise() {
    }
}
let baseVehicle = Vehicle()
baseVehicle.description

class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 10.2
print("\(bicycle.description)의 속도로 이동중")


class Car: Vehicle {
    var gear = 0
    var engineLevel = 0
    
    override var currentSpeed: Double {
        get {
            return Double(self.engineLevel * 50)
        }
        set {
            
        }
    }
    override var description: String {
        get {
            return ""
        }
        set {
            print("New Value is \(newValue)")
        }
    }
}
let c = Car()
c.engineLevel = 5
c.currentSpeed
c.description = "Tucson"

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            self.gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
class Bike: Vehicle {
    override func makeNoise() {
        print("BBang BBang")
    }
}
let bk = Bike()
bk.makeNoise()

//MARK: - overloading

class HybridCar: Car {
    
}
class KickBoard: Vehicle {
    
}
let h = HybridCar()
h.description
let k = KickBoard()
k.description

//MARK: - OptionalChain

struct Human {
    var name: String?
    var man: Bool = true
}
var boy: Human? = Human(name: "진", man: true)

struct Company {
    var ceo: Human?
    var companyName: String?
}
var startup: Company? = Company(ceo: Human(name: "jin", man: true), companyName: "company")

//MARK: - Enum

enum Direction {
    case east
    case west
    case north, south
}
var directionToHead = Direction.north //초기화
directionToHead = .east //값을 변경할 때

switch directionToHead {
case Direction.east:
    print("동쪽")
case .west:
    print("서쪽")
case .south:
    print("남쪽")
default:
    print("북쪽")
}

enum HTTPCode: Int {
    case OK             = 200
    case NotModify      = 304
    case IncorrectPage  = 404
    case ServerError    = 500
    
    var value: String {
        return "HTTPCode number is \(self.rawValue)"
    }
    func getDescription() -> String {
        switch self {
        case .OK:
            return "응답성공. HTTP 코드는 \(self.rawValue) 입니다"
        case .NotModify:
            return "변경내용없음. HTTP 코드는 \(self.rawValue)입니다"
        case .IncorrectPage:
            return "존재하지 않는 페이지. HTTP 코드는 \(self.rawValue)입니다"
        default:
            return "서버오류. HTTP 코드는\(self.rawValue)입니다"
        }
    }
    static  func getName() -> String {
        return "This Enumeration is HTTPCode"
    }
}
var response = HTTPCode.OK
response = .NotModify
response.value
response.rawValue
response.getDescription()
HTTPCode.getName()
HTTPCode.OK.rawValue
HTTPCode.OK

enum Rank: Int {
    case one = 1
    case two, three, four, five
}
Rank.one.rawValue //시작 값을 10으로 놓으면 two, three 는 11, 12가 됨
Rank.two.rawValue
Rank.three.rawValue

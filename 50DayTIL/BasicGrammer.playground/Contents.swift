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


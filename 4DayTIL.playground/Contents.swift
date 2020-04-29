import UIKit

// 1. width, height 속성을 가진 Rectangle 클래스 정의bbbvc
class Rectangle {
    var width: Double = 1.1
    var height : Double = 2.2
}
let Rec = Rectangle()
Rec.width
Rec.height
// 2. 생성자에서 width, height 프로퍼티 값을 설정할 수 있도록 구현
class Constructor {
    var width: Double = 5.5
    var height: Double = 4.4

    func con(width: Double, height: Double){
        self.width = width
        self.height = height
    }
}
let Construct = Constructor()
Construct.width
Construct.height
// 3. 사각형의 가로 세로 길이를 설정할 수 있는 메서드 구현
class Rectangle1 {
    var width: Int
    var height : Int
    init(_ width : Int ,_ height: Int ) {
        self.width = width
        self.height = height
    }

}

// 4. 사각형 가로와 세로의 길이를 반환하는 메서드 구현

class Rectangle2 {
       var width: Int = 0
      var height : Int = 0
    func aaa() -> Int{
        return width
    }
    func bbb() -> Int{
        return height
    }
 
}
// 5. 사각형의 넓이를 반환하는 메서드 구현
class Rectangle3 {
    var width: Int
    var height: Int
        init(width:Int, height: Int) {
              self.width = width
            self.height = height
            
    }
    func ddd() -> Int {
        return width * height
    }
}
let qqq = Rectangle3(width: 4, height: 5)
qqq.ddd()
// 6. 다음과 같은 속성을 지닌 인스턴스 생성
// - 직사각형 1개 속성: width = 10, height = 5
class square{
    var width = 10
    var height = 5
    
}
let ww = Rectangle3(width: 10, height: 5)
ww.ddd()
// - 정사각형 1개 속성: width = 7, height = 7

let gg = Rectangle3(width: 7, height: 7)
gg.ddd()



// 1. 채널 정보, Volume 값, 전원 설정여부를 속성으로 가지는 클래스 정의
// 2. TV 의 현재 채널 및 볼륨을 변경 가능한 메서드 구현
// 3. TV 의 현재 채널 및 볼륨을 확인할 수 있는 메서드 구현
// 4. TV 전원이 꺼져있을 때는 채널과 볼륨 변경을 할 수 없도록 구현
//    (직접 프로퍼티에 값을 설정할 수 없다고 가정)
// 5. TV 전원이 꺼져있을 때는 채널과 볼륨 정보를 확인했을 때 -1 이 반환되도록 구현
class TV{
    var channelInfo: String
    var volumeValue: Int
    var isOn: Bool
    init(channelInfo:String, volumeValue:Int, isOn:Bool) {
        self.channelInfo = channelInfo
        self.volumeValue = volumeValue
        self.isOn = isOn
    }
    func channelChange(_ channelInfo: String) {
         self.channelInfo = channelInfo
    }
    func isOn(_ isOn: Bool){
        self.isOn = isOn
    }
}


 




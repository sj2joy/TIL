import UIKit

/*
 - 학점을 입력받아 각각의 등급을 반환해주는 함수 (4.5 = A+,  4.0 = A, 3.5 = B+ ...)
 - 특정 달을 숫자로 입력 받아서 문자열로 반환하는 함수 (1 = "Jan" , 2 = "Feb", ...)
 - 세 수를 입력받아 세 수의 곱이 양수이면 true, 그렇지 않으면 false 를 반환하는 함수
   (switch where clause 를 이용해 풀어볼 수 있으면 해보기)
 */
//1.
func grade(_ score: Double) -> String {
    var grade : String
    if score == 4.5{
        grade = "A"
    }else if score >= 4.0{
        grade = "B"
    }else if score >= 3.5{
        grade = "C"
    }else if score >= 3.0 {
        grade = "D"
    }else {
        grade = "F"
    }
    return grade
}
grade(3.6)
func month(_ selectMonth: Int) -> String{
    switch selectMonth{
    case 1:
        return "Jan"
    case 2:
        return "Feb"
    case 3:
        return "mar"
    case 4:
        return "apr"
    case 5:
        return "may"
    case 6:
        return "jun"
    case 7:
        return "jul"
    case 8:
        return "aug"
    case 9:
        return "sep"
        
    default:
        return "잘못 입력하셨습니다"
    }
}
month(8)
 //- 세 수를 입력받아 세 수의 곱이 양수이면 true, 그렇지 않으면 false 를 반환하는 함수


func multiple(a:Int, b:Int, c:Int ) -> Bool{
   let multipleOfThree = a * b * c
    if multipleOfThree >= 0 {
        return true
    }else {
        return false
    }
}
multiple(a: 3, b: -2, c: 9)
/*:
 ---
 ## Loops
 ---
 */

func factorial(_ selectNum:Int) -> Int{
    var number = 1
    for i in 1...selectNum{
        number *= i
    }
    return number
}
factorial(6)

//- 자연수 두 개를 입력받아 첫 번째 수를 두 번째 수만큼 제곱하여 반환하는 함수
//  (2, 5 를 입력한 경우 결과는 2의 5제곱)
func dmultiple(_ a: Int, _ b: Int) -> Int{
    var selectNum : Int = a
    let index : Int = a
    for _ in 1..<b{
        selectNum = selectNum * index
    }
    return selectNum
}
dmultiple(3, 4)
//- 자연수 하나를 입력받아 각 자리수 숫자들의 합을 반환해주는 함수
//  (1234 인 경우 각 자리 숫자를 합치면 10)
func number3(_ a: Int) -> Int{
    let a = String(a)
    var j : Int = 0
    for i in a{
        j += Int(String(i))!
    }
    return j
}
number3(12445)


//- 자연수 하나를 입력받아 1부터 해당 숫자 사이의 모든 숫자의 합을 구해 반환하는 함수를 만들되,
//  그 합이 2000 을 넘는 순간 더하기를 멈추고 바로 반환하는 함수
func addSomeNum(_ a: Int) -> Int{
    var number = 0
    for i in 1...a{
        number += i
        if number > 2000{
            return number
        }
    }
    return number
}
addSomeNum(100)
//- 1 ~ 50 사이의 숫자 중에서 20 ~ 30 사이의 숫자만 제외하고 그 나머지를 모두 더해 출력하는 함수

func someAdd() {
    var num = 0
    for i in 1...19{
    num += i
        }
    for j in 31...50{
        num += j
    }
    print(num)
}
someAdd()

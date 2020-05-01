import UIKit
//1. 입력받은 숫자의 모든 자리 숫자 합계를 출력하기
//e.g.  123 -> 6 ,  5678 -> 26

func countSum(a: Int) -> Int{
    let a = String(a)
    var j : Int = 0
    for i in a{
        j += Int(String(i))!
    }
    return j
}
countSum(a: 12345)
//2. 하샤드 수 구하기
//- 하샤드 수 : 자연수 N의 각 자릿수 숫자의 합을 구한 뒤, 그 합한 숫자로 자기 자신이 나누어 떨어지는 수
//e.g. 18의 자릿수 합은 1 + 8 = 9 이고, 18은 9로 나누어 떨어지므로 하샤드 수.
func hashad(a: Int) -> Bool {
    var sum : Int = 0
    for i in String(a) {
        sum += Int(String(i))!
    }
    if a % sum == 0 {
        return true
    }else{
        return false
    }
}
hashad(a: 18)


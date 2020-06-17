
import Foundation

struct OrderData {
    private var currentMoney = 70000
    private var currentOrderCost = 0
    private var jjaJangCount   = 0
    private var jjamBbongCount = 0
    private var tangSuYukCount = 0
    
    func getCurrentMoney() -> Int { currentMoney }
    
    func getCurrentOrderCost() -> Int { currentOrderCost }
    mutating func addCurrentChargeCost(_ cost: Int) { currentOrderCost += cost }
    
    func getJjaJangCount() -> Int { jjaJangCount }
    mutating func plusJjaJangCount() { jjaJangCount += 1 }
    
    func getJjamBbongCount() -> Int { jjamBbongCount }
    mutating func plusJjamBbongCount() { jjamBbongCount += 1 }
    
    func getTangSuYukCount() -> Int { tangSuYukCount }
    mutating func plusTangSuYukCount() { tangSuYukCount += 1 }
    
    mutating func initOrderData() {
        currentMoney     = 70000
        currentOrderCost = 0
        jjaJangCount     = 0
        jjamBbongCount   = 0
        tangSuYukCount   = 0
    }
    
    mutating func charge() {
        currentMoney    -= currentOrderCost
        currentOrderCost = 0
        jjaJangCount     = 0
        jjamBbongCount   = 0
        tangSuYukCount   = 0
    }
}

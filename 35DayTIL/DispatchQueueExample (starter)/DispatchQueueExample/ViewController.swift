
//http status code <- 검색해서 훑어 보기
import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var testView: UIView!
    
    @IBAction private func buttonDidTap(_ sender: Any) {
        print("---------- [ Change Color ] ----------\n")
        let r = CGFloat.random(in: 0...1.0)
        let g = CGFloat.random(in: 0...1.0)
        let b = CGFloat.random(in: 0...1.0)
        testView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    func bigTask() {
        print("= Big task start =")
        for _ in 0...5_000_000 { _ = 1 + 1 }
        print("= Big task end =")
    }
    
    @IBAction func bigTaskOnMainThread() {
        //serial queue
        print("start")
        bigTask()//동기방식으로 동작함을 알수잇음(print찍어본걸로) serial queue의 sync방식으로 동작
        //big task on main thread 버튼 누르고 color change 버튼 누르면 big task 모두 처리후에 색깔 변경됨
        print("end")
    }
    
    @IBAction func uiTaskOnBackgroundThread() { // 비동기방식으로 할 때
        //uiTaskOnBackgroundThread 버튼 누르고 color change 버튼 누르면 바로 실행됨
        print("\n---------- [ uiTaskOnBackgroundThread ] ----------\n")
        //비동기방식 ui와 관련된 방법은 main에서 해야함 **
        DispatchQueue.global().async { // concurrent - async
            self.bigTask()
            DispatchQueue.main.async { //여기 main에 ui와 관련된 작업을 넣어야함, serial - async
                self.buttonDidTap(self)
            }
        }
    }
    
    func log(_ str: String) {
        print(str, terminator: " - ")
    }
    
    @IBAction private func serialSyncOrder(_ sender: UIButton) {
        print("\n---------- [ Serial Sync ] ----------\n")
        //실행순서 확인하기 (동기) , 1 - A - 2 - B - 3 - C , 실행한 작업이 종료되어야 다음으로 넘어가기때문에
        let serialQueue = DispatchQueue(label: "kr.giftbot.serialQueue")
        serialQueue.sync { log("1") }//sync로 실행하면 버튼이 누를수 없는상태가 되며 작업이 끝나야 다시 활성화됨
        log("A")//main에서 호출되는 것이므로 그냥 순서대로 호출됨, sync - 호출된 함수가 종료되어야 다음 작업 실행
        serialQueue.sync { log("2") }
        log("B")
        serialQueue.sync { log("3") }
        log("C")
        print()
    }
    
    @IBAction private func serialAsyncOrder(_ sender: UIButton) {
        print("\n---------- [ Serial Async ] ----------\n")
        //실행순서 확인하기 (비동기)
        let serialQueue = DispatchQueue(label: "kr.giftbot.serialQueue")
        serialQueue.async { self.log("1") }//async - self.log("1")을 등록만 해놓고 바로 종료함, 그래서 나중에 다시호출되는건 랜덤
        //async - a,b,c 순서동일 , 1,2,3 순서동일 but - main queue와 serialqueue의 순서는 바뀔 수 있음
        log("A")
        serialQueue.async { self.log("2") }
        log("B")
        serialQueue.async { self.log("3") }
        log("C")
        print()
    }
    
    @IBAction private func concurrentSyncOrder(_ sender: UIButton) {
        print("\n---------- [ Concurrent Sync ] ----------\n")
        let concurrentQueue = DispatchQueue(
            label: "kr.giftbot.concurrentQueue",
            attributes: [.concurrent]
        )
        concurrentQueue.sync { log("1") } //호출한 작업이 끝나야 다음으로 넘어감 sync는 직렬(serial),병렬(concurrent)과 상관없이 순서대로 호출**
        log("A")
        concurrentQueue.sync { log("2") }
        log("B")
        concurrentQueue.sync { log("3") }
        log("C")
        print()
    }
    
    @IBAction private func concurrentAsyncOrder(_ sender: UIButton) {
        print("\n---------- [ Concurrent Async ] ----------\n")
        let concurrentQueue = DispatchQueue(
            label: "kr.giftbot.concurrentQueue",
            attributes: [.concurrent]
        )
        //[1] -> OS
        //[2] -> OS
        //[3] -> OS
        //[4] -> OS
        
        //asyn에 대한 값은 랜덤(자기들 뿐만 아니라 main queue에 사이에서도 랜덤) , main에 대한 값은 순서 고정
        concurrentQueue.async { self.log("1") }
        //concurrentQueue.async(qos: .userInteractive, execute: { self.log("1") }) qos는 작업간 우선순위를 준다고 보면됨 but 같은 queue안에서 우선순위는 결정할 수 없음
        log("A")//main queue
        concurrentQueue.async { self.log("2") }
        log("B")//main queue
        concurrentQueue.async { self.log("3") }
        log("C")//main queue
        concurrentQueue.async { self.log("4") }
        log("D")//main queue
        print()
    }
    
    private func createDispatchWorkItem() -> DispatchWorkItem {
        // 출력 순서
        // 25%, 50% , 75%, 100%
        let workItem = DispatchWorkItem {
            let bigNumber = 8_000_000
            let divideNumber = 2_000_000
            for i in 1...bigNumber {
                guard i % divideNumber == 0 else { continue }
                print(i / divideNumber * 25, "%")
            }
        }
        return workItem
    }
    
    
    @IBAction func waitWorkItem() {
        print("\n---------- [ waitWorkItem ] ----------\n")
        
        let workItem = createDispatchWorkItem()
        let myQueue = DispatchQueue(label: "kr.giftbot.myQueue")
        
        // async vs sync
        myQueue.async(execute: workItem) //async라 아래 프린트작업이 먼저 나오고 후에 이 작업이 나옴
        //         myQueue.sync(execute: workItem) //sync로 하면 이작업후 아래 프린트 찍힘
        
        print("before waiting")
        workItem.wait() //이걸 쓰면 before waiting -> 25% 50%... -> after waiting 호출
        //async를 원하는 시점에 sync처럼 동작하도록 만들어주는것
        // 실행이 완료될 때 까지 대기
        print("after waiting")
    }
    
    
    let inactiveQueue = DispatchQueue(
        label: "kr.giftbot.inactiveQueue",
        attributes: [.initiallyInactive, .concurrent]//concurrent는 생략가능
    )
    
    @IBAction func initiallyInactiveQueue() {
        print("\n---------- [ initiallyInactiveQueue ] ----------\n")
        
        let workItem = createDispatchWorkItem()
        inactiveQueue.async(execute: workItem)
        
        print("= Do Something... =")
        
        // 필요한 타이밍에 activate 메서드를 통해 활성화
        inactiveQueue.activate() // 여러개를 작성해도 한개만 호출 , queue에서 빼와서 작업을 실행하는것이므로
//        inactiveQueue.activate() [task1, task2, task3] 이런식으로 하면 activate 여러번 사용 가능
//        inactiveQueue.activate()
    }
    
    
    @IBAction func groupNotify() {
        print("\n---------- [ groupNotify ] ----------\n")
        
        let queue1 = DispatchQueue(label: "kr.giftbot.example.queue1",
                                   attributes: .concurrent)
        let queue2 = DispatchQueue(label: "kr.giftbot.example.queue2")
        
        func calculate(task: Int, limit: Int) {
            print("Task\(task) 시작")
            for _ in 0...limit { _ = 1 + 1 }
            print("Task\(task) 종료")
        }
        
//        queue1.async { calculate(task: 1, limit: 12_000_000) }
//        queue1.async { calculate(task: 2, limit:  5_000_000) }
//        queue2.async { calculate(task: 3, limit:  2_000_000) }
//        print("The end")

        let group = DispatchGroup() //이렇게 쓰면 순서대로 작업시작후 종료
        queue1.async(group: group) { calculate(task: 1, limit: 12_000_000)}
        queue1.async (group: group) { calculate(task: 2, limit:  5_000_000) }
        queue2.async (group: group) { calculate(task: 3, limit:  2_000_000) }
        group.notify(queue: .main) { print("모든 작업 완료") }
    }
    
    
    var myWorkItem: DispatchWorkItem!
    
    @IBAction func cancelDispatchWorkItem() {
        myWorkItem = DispatchWorkItem {
            let bigNumber = 8_000_000
            let divideNumber = bigNumber / 4
            for i in 1...bigNumber {
                guard i % divideNumber == 0 else { continue }
                guard !self.myWorkItem.isCancelled else { return } //캔슬이 되엇을 때 원하는 시점을 정하는?
                //아래 스위치문만 썼을 때는 timedout후에도 계속 실행됨 ,이것까지 써줘야 timed out됏을때 추가적으로 실행이 안됨 ******
                print(i / divideNumber * 25, "%")
            }
        }
        DispatchQueue.global().async(execute: myWorkItem)
        //10초안에 실행이 되지 않으면 취소 시키고 싶을 때
        let timeLimit = 10.0
        DispatchQueue.global().async {
            let timeoutResult = self.myWorkItem.wait(timeout: .now() + timeLimit)
            switch timeoutResult {
            case .success: print("success within \(timeLimit) seconds")
            case .timedOut:
                self.myWorkItem.cancel() //10초 안에 실행되지않았을 경우 취소시키는
                print("Timed Out")
            }
        }
    }
}

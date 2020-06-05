import UIKit

//[ 과제 ]
//다음 내용을 참고하여 더블 링크드 리스트 구현
/***************************************************
class Node { }
- deinit 메서드 구현할 것
class DoubleLinkedList { }
- 다음의 프로퍼티와 메서드 구현
 [ 프로퍼티 ]
 // private
 private var head: Node?
 private weak var tail: Node?
 // internal
 var isEmpty: Bool - 노드 존재 여부
 var count: Int    - 노드 전체 개수
 var first: Node?  - 첫번째 노드 반환
 var last: Node?   - 마지막 노드 반환
 
 [ 메서드 ]
 scanValues()  - 현재 저장된 모든 노드의 값 출력
 removeAll()   - 모든 노드 제거
 removeNode(by value: String) -> Bool      - 밸류를 이용해 노드 제거 후 성공 여부
 removeNode(at index: Int) -> String?      - 인덱스를 이용해 노드 제거 후 삭제한 노드의 밸류 반환
 node(by value: String) -> Node?           - 지정한 값을 지닌 노드를 찾아 반환
 insert(node newNode: Node, at index: Int) - 특정 위치에 노드 삽입
 append(node: Node)                        - 마지막 부분에 노드 삽입
 ***************************************************/
protocol LinkedListStack {
    var size: Int { get }     // 전체 개수
    var isEmpty: Bool { get } // 노드가 있는지 여부
    func push(node: Node)     // 데이터 삽입
    func pop() -> String?     // 데이터 추출
    func peek() -> String?    // 마지막 데이터 확인
}
final class Node {
    var value: String?
    var next: Node?
    
    init(value: String) {
        self.value = value
    }
}
let node = Node(value: "A")
node.value
node.next
node.next = Node(value: "B")

//head -> "A" 아래방법은 이걸로
//head -> "A" -> "B"
final class SingleLinkedList: LinkedListStack {
    private var head: Node = Node(value: "") //빈값 하나 설정
    var isEmpty: Bool { return head.next == nil}
    var size: Int = 0 { //사이즈 계산
        didSet { size = size < 0 ? 0 : size }
    }
    //head -> A -> B -> C
    //head -> A -> nil
    //head -> nil
    private var lastNode: Node? {
        guard var node = head.next else { return nil }
        while let nextNode = node.next { //값이 있으면 nextNode에 들어가고 없으면 종료, 없을때까지 돌아감
            node = nextNode
        }
        return node
    }
    
    func push(node newNode: Node) {
        size += 1
        guard let node = lastNode else { return head.next = newNode }
        node.next = newNode
    }
    func peek() -> String? {
        //        guard let node = lastNode else { return nil }
        //        return node.value
        
        return lastNode?.value
    }

    func pop() -> String? {
        size -= 1
        guard var node = head.next else { return nil }
        while let nextNode = node.next {
            guard nextNode.next != nil else {
                node.next = nil
                return nextNode.value
            }
            node = nextNode
        }
        head.next = nil
        return node.value
    }
}

//let linkedList = SingleLinkedList()
//linkedList.isEmpty
//
//linkedList.push(node: Node(value: "A"))
//linkedList.push(node: Node(value: "B"))

//Queue
/**
 값추가 - Enqueue or Put , 맨 앞에 인덱스가 한칸 밀리면서 새로운 값이 들어가는 형태
 값꺼내는 - Dequeue or Get, 인덱스의 맨 끝에 새로운 값이 추가되어 들어가는 형태
 Front - Dequeue에 사용되는 Index
 Rear(Back) - Enqueue에 사용되는 Index
 */

//: Playground - noun: a place where people can play

import UIKit
import XCTest

//:# 链表

//:### 定义节点

public class Node {
    
    var value: Int
    var next: Node?
    weak var previous: Node?
    
    public init(_ value: Int) {
        self.value = value
    }
}



//:### 定义链表
public class LinkedList {
    
    fileprivate var head: Node?
    private var tail: Node?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        return tail
    }
    
    public func append(_ value: Int) {
        let newNode = Node(value)
        
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        }
        else {
            head = newNode
        }
        tail = newNode
    }
    
    public func nodeAt(_ index: Int) -> Node? {

        if index >= 0 {
            
            var node = head
            var i = index
            while node != nil {
                if i == 0 {return node}
                i = i - 1
                node = node!.next
            }
        }
        return nil
    }
    
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    public func remove(_ node: Node) -> Int {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        }else {
            //如果删除的是 first
            head = next
        }
        
        next?.previous = prev
        //如果删除的是 last
        if  next == nil {
            tail = prev
        }
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
}



extension LinkedList: CustomStringConvertible {
    
    public var description: String {
                var text = "["
        var node = head
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil { text += " -> " }
        }
        return text + "]"
    }
}

let link1 = LinkedList()
link1.append(1)
link1.append(2)
link1.append(3)
link1.append(4)

print(link1)//1,2,3,4

let node = link1.nodeAt(1)
node?.value

//:### 测试 --------------------------------


func testLinkedListEmpty () {
    let link = LinkedList()
    assert(link.isEmpty, "空链表")
}

testLinkedListEmpty()

func testLinkedListAppend() {
    
    let link = LinkedList()
    link.append(10)
    assert(!link.isEmpty, "非空链表")
    
    assert(link.first?.value == 10, "head 节点为 10")
    assert(link.last?.value == 10, "tail 节点为 10")
    link.append(20)
    assert(link.last?.value == 20, "tail 节点为 20")
    link.append(30)
    assert(link.last?.value == 30, "tail 节点为 30")
    
}

testLinkedListAppend()

func testNodeAt () {
    let link = LinkedList()
    link.append(0)
    link.append(1)
    link.append(2)
    link.append(3)
    
    assert(link.nodeAt(0)?.value == 0, "node[0] = 0")
    assert(link.nodeAt(1)?.value == 1, "node[0] = 0")
    assert(link.nodeAt(3)?.value == 3, "node[3] = 3")
    assert(link.nodeAt(8) == nil , "找不到")
    assert(link.nodeAt(-1) == nil , "找不到")

}

testNodeAt()

func testRemoveAll () {
    
    let link = LinkedList()
    link.append(0)
    link.append(1)
    link.append(2)
    link.append(3)
    
    link.removeAll()
    
    assert(link.isEmpty, "空")
    assert(link.first == nil, "first")
    assert(link.last == nil, "last")
    assert(link.nodeAt(Int(arc4random())) == nil , "anynoe")
    
}

testRemoveAll()

func testRemove () {
    
    let link = LinkedList()
    link.append(0)
    link.append(1)
    link.append(2)
    link.append(3)
    
    let value = link.remove(link.nodeAt(2)!)
    assert(value == 2,"删除")
    assert(link.last?.value == 3,"删除")
    link.remove(link.last!)
    assert(link.last?.value == 1, "删除最后一个node，最后一个node 变为 1")
    link.remove(link.first!)
    assert(link.last?.value == 1, "删除第一个node，第一个node 变为 1")

}

testRemove()


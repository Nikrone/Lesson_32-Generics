//
//  ViewController.swift
//  Lesson_32-Generics
//
//  Created by Evgeniy Nosko on 10.11.21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(sum(firstParam: "123", secondParam: "123"))
        
        let sumClass = SumOfElements<String>(firstParam: "123", secondParam: "123")
        print(sumClass.sum())

    }
    
//        func sum (firstParam: Int, secondParam: Int) -> Int {
//            return firstParam + secondParam
//        }
    
    //    общий тип - <T>
//    func sum() -> T? {
//        if let firstParam = firstParam as? Int, let secondParam = secondParam as? Int {
//            return (firstParam + secondParam) as? T
//        } else if let firstParam = firstParam as? String, let secondParam = secondParam as? String {
//            return (firstParam + secondParam) as? T
//        } else {
//            return nil
//        }
//    }
    
   
    
}


class SumOfElements<T> {
    private var firstParam: T
    private var secondParam: T
    
    init(firstParam: T, secondParam: T) {
        self.firstParam = firstParam
        self.secondParam = secondParam
    }
    
    
    func sum() -> T? {
        if let firstParam = firstParam as? Int, let secondParam = secondParam as? Int {
            return (firstParam + secondParam) as? T
        } else if let firstParam = firstParam as? String, let secondParam = secondParam as? String {
            return (firstParam + secondParam) as? T
        } else {
            return nil
        }
    }
}

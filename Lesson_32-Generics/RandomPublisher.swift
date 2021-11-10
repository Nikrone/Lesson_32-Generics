//
//  RandomPublisher.swift
//  Lesson_32-Generics
//
//  Created by Evgeniy Nosko on 10.11.21.
//

import Foundation
import UIKit
import Combine

class RandomPublisher: Publisher {
    typealias Output = Int
    
    typealias Failure = Never
    
    private let minValue: Output
    private let maxValue: Output
    private let timeInterval:  TimeInterval
    
    init(minValue: Output, maxValue: Output, timeInterval:  TimeInterval) {
        self.minValue = minValue
        self.maxValue = maxValue
        self.timeInterval = timeInterval
        
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Int == S.Input {
        let subscription = Subscription<S>(minValue: minValue, maxValue: maxValue,timeInterval: timeInterval, subcriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
    
}


//MARK: - EXTENSIONS
extension RandomPublisher {
    final class Subscription<S: Subscriber> where S.Input == Output, S.Failure == Failure {
        private var subscriber: S?
        private let minValue: Output
        private let maxValue: Output
        private let timeInterval:  TimeInterval
        
        init(minValue: Output, maxValue: Output, timeInterval:  TimeInterval, subcriber: S?) {
            self.subscriber = subcriber
            self.minValue = minValue
            self.maxValue = maxValue
            self.timeInterval = timeInterval
            
        }
    }
}

//отмена подписки
extension RandomPublisher.Subscription: Cancellable {
    func cancel() {
        subscriber = nil
    }
}

//получаем функцию request (что получит подписчик)
extension RandomPublisher.Subscription: Subscription {
    func request(_ demand: Subscribers.Demand) {
        var demand = demand
        guard let subscriber = subscriber else {
            return
        }
        
        var count = 0
        
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
            count += 1
            if count < 10 {
                let randomNumber = Int.random(in: self.minValue...self.maxValue)
                demand += subscriber.receive(randomNumber)
            }
        }
    }
}

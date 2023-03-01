//
//  ReadWriteLock.swift
//  Mixpanel
//
//  Created by Hairuo Sang on 8/9/17.
//  Copyright © 2017 Mixpanel. All rights reserved.
//
import Foundation

class ReadWriteLock {
    let concurentQueue: DispatchQueue

    init(label: String) {
        self.concurentQueue = DispatchQueue(label: label, qos: .utility, attributes: .concurrent, autoreleaseFrequency: .workItem)
    }

    func read(closure: () -> Void) {
        self.concurentQueue.sync {
            closure()
        }
    }
    func write(closure: () -> Void) {
        self.concurentQueue.sync(flags: .barrier, execute: {
            closure()
        })
    }
}

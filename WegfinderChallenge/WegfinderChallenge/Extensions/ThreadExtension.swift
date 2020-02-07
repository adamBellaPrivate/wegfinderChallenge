//
//  ThreadExtension.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import Foundation

extension Thread {

    static func executeOnMain(execute work: @escaping @convention(block) () -> Void) {
        guard !Thread.isMainThread else {
            work()
            return
        }

        DispatchQueue.main.async {
            work()
        }
    }

    static func executeOnBackground(queue: DispatchQueue = .global(), with block: @escaping @convention(block) () -> Void) {
        guard Thread.isMainThread else {
            block()
            return
        }
        queue.async {
            block()
        }
    }

}

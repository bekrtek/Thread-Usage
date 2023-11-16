//
//  AppDelegate.swift
//  ThreadUsage
//
//  Created by BEKIR TEK on 16.11.2023.
//

import Foundation

extension Thread {
    
    func getThreadName() -> String {
        let finalName: String
        let qosName: String = getQosName()
        
        guard let name = name else { return "name: nilName -- Qos: \(qosName)"}
        
        /// Main thread have `empty name`
        if isMainThread {
            finalName = "Main"
        } else {
            finalName = name.isEmpty ? "unNamed" : name
        }
        
        return "name: \(finalName) -- Qos: \(qosName)"
    }
    
    func getQosName() -> String {
        switch qualityOfService {
        case .userInteractive:
            return "userInteractive"
        case .userInitiated:
            return "userInitiated"
        case .utility:
            return "utility"
        case .background:
            return "background"
        case .default:
            return "default"
        @unknown default:
            return "unspecified"
        }
    }
}

extension Thread {
    convenience init (name: String? ,target: Any, selector: Selector, object: Any?) {
        self.init(target: target, selector: selector, object: object)
        self.name = name
    }
}



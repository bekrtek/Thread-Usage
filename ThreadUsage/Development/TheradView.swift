//
//  AppDelegate.swift
//  ThreadUsage
//
//  Created by BEKIR TEK on 16.11.2023.
//

import UIKit

final class ThreadVİewController: UIViewController {
    
    override internal func viewDidLoad() { super.viewDidLoad() }
    
    @IBAction private func mainAction(_ sender: Any) {
        ThreadInterface.shared.fireMainQueue()
    }
    
    @IBAction private func globalAction(_ sender: Any) {
        ThreadInterface.shared.fireGlobalQueue()
    }
    
    @IBAction private func customSAction(_ sender: Any) {
        ThreadInterface.shared.fireSerialCustomQueue()
    }
    
    @IBAction private func customCAction(_ sender: Any) {
        ThreadInterface.shared.fireConcurentCustomQueue()
    }
    
    @IBAction private func bothAction(_ sender: Any) {
        ThreadInterface.shared.fireSerialCustomQueue()
        ThreadInterface.shared.fireConcurentCustomQueue()
    }
    
    @IBAction private func dataRaceAction(_ sender: Any) {
        ThreadInterface.shared.dateRaceWriteAndRead()
    }
}


final class ThreadInterface {
    
    // MARK: - Properties
    static let shared = ThreadInterface()
    private init() {}
    private var dataRaceArray: [Int] = .init()
    private let serialCustomQueue: DispatchQueue = DispatchQueue(label: "custom_serial_operation_queue",
                                                             qos: .userInteractive,
                                                             attributes: [])
    private let councurentCustomQueue: DispatchQueue = DispatchQueue(label: "custom_concurent_operation_queue",
                                                             qos: .userInteractive,
                                                             attributes: .concurrent)

    func fireMainQueue() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
            Helper.printStartTimeMillis("Main")
            for i in 1...10 {
                sleep(1)
                print("Main is running on --> \(Thread.current.getThreadName()) \(i)\n")
            }
            Helper.printEndTimeMillis("Main")
        }
    }
    
    func fireGlobalQueue() {
        DispatchQueue.global().async {
            Helper.printStartTimeMillis("Global")
            for i in 1...10 {
                sleep(1)
                print("Global is running on --> \(Thread.current.getThreadName()) \(i)\n")
            }
            Helper.printEndTimeMillis("Global")
        }
    }
    
    func fireSerialCustomQueue() {
        serialCustomQueue.async {
            Helper.printStartTimeMillis("Serial Custom")
            for i in 1...10 {
                sleep(1)
                print("Serial Custom is running on --> \(Thread.current.getThreadName()) \(i)\n")
            }
            Helper.printEndTimeMillis("Serial Custom")
        }
    }
    
    func fireConcurentCustomQueue() {
        councurentCustomQueue.async {
            Helper.printStartTimeMillis("Concurent Custom")
            for i in 1...10 {
                sleep(1)
                print("Concurent Custom is running on --> \(Thread.current.getThreadName()) \(i)\n")
            }
            Helper.printEndTimeMillis("Concurent Custom")
        }
    }
    
    /// ``FLAG USAGE`` .barrier example, first loop ends then prints array
    /// Converts concurent queue to serial quene for only 1 execution.
    func dateRaceWriteAndRead() {
        councurentCustomQueue.async(flags: .barrier) {
            for i in 1...1000000 {
                self.dataRaceArray.append(contentsOf: [i])
            }
        }
        councurentCustomQueue.async {
            print(self.dataRaceArray)
        }
    }
}

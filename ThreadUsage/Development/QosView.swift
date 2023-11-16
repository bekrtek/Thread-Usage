//
//  AppDelegate.swift
//  ThreadUsage
//
//  Created by BEKIR TEK on 16.11.2023.
//

import UIKit

final class QosViewController: UIViewController {
    
    override internal func viewDidLoad() { super.viewDidLoad() }
    /// ``User Interactive``
    @IBOutlet private weak var userInteractiveStartLabel: UILabel!
    @IBOutlet private weak var userInteractiveEndLabel: UILabel!
    @IBOutlet private weak var userInteractiveDurationLabel: UILabel!
    /// ``User Initiated``
    @IBOutlet private weak var userInitiatedStartLabel: UILabel!
    @IBOutlet private weak var userInitiatedEndLabel: UILabel!
    @IBOutlet private weak var userInitiatedLabel: UILabel!
    /// ``Default``
    @IBOutlet private weak var defaultStartLabel: UILabel!
    @IBOutlet private weak var defaultEndLabel: UILabel!
    @IBOutlet private weak var defaultDurationLabel: UILabel!
    /// ``Utility``
    @IBOutlet private weak var utilityStartLabel: UILabel!
    @IBOutlet private weak var utilityEndLabel: UILabel!
    @IBOutlet private weak var utilityDurationLabel: UILabel!
    /// ``Background``
    @IBOutlet private weak var backgroundStartLabel: UILabel!
    @IBOutlet private weak var backgroundEndLabel: UILabel!
    @IBOutlet private weak var backgroundDurationLabel: UILabel!
    
    private var selectedOp: QueuneType = .serial
    
    private enum QueuneType: Int {
        case serial = 0
        case concurent = 1
    }
    
    private func takeConfiguredQueue(label: String, qos: DispatchQoS) -> DispatchQueue {
        switch selectedOp {
        case .serial:
            return DispatchQueue.init(label: label, qos: qos)
        case .concurent:
            return DispatchQueue.init(label: label, qos: qos, attributes: .concurrent)
        }
    }
    
    @IBAction private func segmented(_ sender: UISegmentedControl) {
        self.selectedOp = QueuneType(rawValue: sender.selectedSegmentIndex) ?? .serial
    }
    
    
    // MARK: - ACTIONS
    
    /// Kullanıcı arayüzü güncellemeleri, animasyonlar gibi işlemler bu öncelikle çalıştırılmalıdır. `Main`de bu öncelik seviyesindedir.
    
    @IBAction private func userInteractive(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.userInteractiveStartLabel.text = Helper.getCurrentTime()
        }
        
        takeConfiguredQueue(label:"first_queue", qos: .userInteractive).async {
            for i in 1...50_000 {
                print("\(Thread.current.getThreadName()) \(i)\n")
            }
            
            DispatchQueue.main.async {
                self.userInteractiveEndLabel.text = Helper.getCurrentTime()
                self.userInteractiveDurationLabel.text = "Total Duration: " + (Helper.calculateTimeIntervalString(start: self.userInteractiveEndLabel.text,
                                                                                                                  end: self.userInteractiveStartLabel.text) ?? "FAIL")
            }
        }
    }
    
    /// Kullanıcının başlattığı işlemler için yüksek önceliktir.
    
    @IBAction private func userInitiated(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.userInitiatedStartLabel.text = Helper.getCurrentTime()
        }
        takeConfiguredQueue(label:"second_queue", qos: .userInitiated).async {
            for i in 1...50_000 {
                print("\(Thread.current.getThreadName()) \(i)\n")
            }
            DispatchQueue.main.async {
                self.userInitiatedEndLabel.text = Helper.getCurrentTime()
                self.userInitiatedLabel.text = "Total Duration: " + (Helper.calculateTimeIntervalString(start: self.userInitiatedEndLabel.text,
                                                                                                        end: self.userInitiatedStartLabel.text) ?? "FAIL")
            }
        }
    }
    
    /// Genel amaçlı işlemler için varsayılan önceliktir. Bu genellikle önerilen öncelik seviyesidir.
    
    @IBAction private func `default`(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.defaultStartLabel.text = Helper.getCurrentTime()
        }
        takeConfiguredQueue(label:"third_queue", qos: .default).async {
            for i in 1...50_000 {
                print("\(Thread.current.getThreadName()) \(i)\n")
            }
            DispatchQueue.main.async {
                self.defaultEndLabel.text = Helper.getCurrentTime()
                self.defaultDurationLabel.text = "Total Duration: " + (Helper.calculateTimeIntervalString(start: self.defaultEndLabel.text,
                                                                                                          end: self.defaultStartLabel.text) ?? "FAIL")
            }
        }
    }
    
    /// Arka planda çalışan, ancak kullanıcıyı beklemeyen işlemler için orta düzey bir önceliktir.
    
    @IBAction private func utility(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.utilityStartLabel.text = Helper.getCurrentTime()
        }
        takeConfiguredQueue(label:"fourth_queue", qos: .utility).async {
            for i in 1...50_000 {
                print("\(Thread.current.getThreadName()) \(i)\n")
            }
            DispatchQueue.main.async {
                self.utilityEndLabel.text = Helper.getCurrentTime()
                self.utilityDurationLabel.text = "Total Duration: " + (Helper.calculateTimeIntervalString(start: self.utilityEndLabel.text,
                                                                                                          end: self.utilityStartLabel.text) ?? "FAIL")
            }
        }
    }
    
    /// Arka planda çalışan ve kullanıcı tarafından beklenmeyen işlemler için en düşük önceliktir.
    
    @IBAction private func background(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.backgroundStartLabel.text = Helper.getCurrentTime()
        }
        
        takeConfiguredQueue(label: "fifth_queue", qos: .background).async {
            for i in 1...50_000 {
                print("\(Thread.current.getThreadName()) \(i)\n")
            }
            DispatchQueue.main.async {
                self.backgroundEndLabel.text = Helper.getCurrentTime()
                self.backgroundDurationLabel.text = "Total Duration: " + (Helper.calculateTimeIntervalString(start: self.backgroundEndLabel.text,
                                                                                                             end: self.backgroundStartLabel.text) ?? "FAIL")
            }
        }
    }
}



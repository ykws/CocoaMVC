//
//  ViewController.swift
//  CocoaMVC
//
//  Created by KAWASHIMA Yoshiyuki on 2019/04/01.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet var counterView: CounterView!
  
  var counterModel: CounterModel?

  deinit {
    counterModel?.notificationCenter.removeObserver(self)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let model = counterModel else { return }
    
    counterView.label.text = model.count.description
    counterView.minusButton.addTarget(self, action: #selector(onMinusTapped), for: .touchUpInside)
    counterView.plusButton.addTarget(self, action: #selector(onPlusTapped), for: .touchUpInside)
    
    model.notificationCenter.addObserver(forName: .init(rawValue: "count"), object: nil, queue: nil, using: { [unowned self] notification in
      if let count = notification.userInfo?["count"] as? Int {
        self.counterView.label.text = count.description
      }
    })
  }

  @objc func onMinusTapped() { counterModel?.countDown() }
  @objc func onPlusTapped() { counterModel?.countUp() }
}


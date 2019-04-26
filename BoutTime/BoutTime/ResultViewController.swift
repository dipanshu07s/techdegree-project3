//
//  ResultViewController.swift
//  BoutTime
//
//  Created by Dipanshu Sehrawat on 16/04/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import UIKit

protocol ResultViewControllerDelegate: class {
    func playAgain(_ controller: ResultViewController, _ playAgain: Bool)
}

class ResultViewController: UIViewController {
    
    var wins: Int?
    weak var delegate: ResultViewControllerDelegate?
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let wins = wins {
            scoreLabel.text = "\(wins)/6"
        }
        
    }

    @IBAction func playAgain(_ sender: Any) {
        delegate?.playAgain(self, true)
        dismiss(animated: true, completion: nil)
    }
}

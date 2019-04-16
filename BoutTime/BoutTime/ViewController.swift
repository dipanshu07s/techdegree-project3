//
//  ViewController.swift
//  BoutTime
//
//  Created by Dipanshu Sehrawat on 16/04/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet var downButton: [UIButton]!
    @IBOutlet var upButton: [UIButton]!
    @IBOutlet var eventTitles: [UIButton]!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    
    
    var historicalQuiz = HistoricaQuiz()
    var roundEvents = [Event]()
    var timer = Timer()
    var time = 0
    var round = 0
    var correctAnswer = 0
    var correctSound: SystemSoundID = 0
    var incorrectSound: SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCorrectSystemSound()
        loadInCorrectSystemSound()
        newRound()
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            timer.invalidate()
            checkAnswer()
        }
    }
    
    func loadCorrectSystemSound() {
        let path = Bundle.main.path(forResource: "CorrectDing", ofType: "wav")!
        let soundURL = URL(fileURLWithPath: path)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctSound)
    }
    
    func loadInCorrectSystemSound() {
        let path = Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")!
        let soundURL = URL(fileURLWithPath: path)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &incorrectSound)
    }
    
    func playSound(with systemID: SystemSoundID) {
        AudioServicesPlaySystemSound(systemID)
    }
    
    func checkOrder() -> Bool {
        var date = roundEvents[0].year
        for event in roundEvents {
            if event.year >= date {
                date = event.year
            } else {
                return false
            }
        }
        return true
    }
    
    func newRound() {
        round += 1
        if round <= 4 {
            roundEvents = historicalQuiz.randomEvents()
            setEventTitles()
            resultButton.isHidden = true
            timerLabel.isHidden = false
            buttonState(enable: false, for: eventTitles)
            buttonState(enable: true, for: upButton)
            buttonState(enable: true, for: downButton)
            descriptionLabel.text = "Shake to complete"
            time = 60
            timerLabel.text = "0:\(time)"
            startTimer()
        } else {
            performSegue(withIdentifier: "showResult", sender: correctAnswer)
        }
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            guard self.time > 0 else {
                timer.invalidate()
                self.checkAnswer()
                return
            }
            
            self.time -= 1
            if self.time >= 10 {
                self.timerLabel.text = "0:\(self.time)"
            } else {
                self.timerLabel.text = "0:0\(self.time)"
            }
        })
    }
    
    func moveEvent(from currentIndex: Int, to newIndex: Int) {
        let event = roundEvents.remove(at: currentIndex)
        roundEvents.insert(event, at: newIndex)
        setEventTitles()
    }
    
    func setEventTitles() {
        for (index, eventTitle) in eventTitles.enumerated() {
            eventTitle.setTitle(roundEvents[index].title, for: .normal)
        }
    }
    
    @IBAction func moveDown(_ sender: UIButton) {
        var buttonIndex = 0
        for (index, button) in downButton.enumerated() {
            if button === sender {
                buttonIndex = index
            }
        }
        
        moveEvent(from: buttonIndex, to: buttonIndex + 1)
    }
    
    @IBAction func moveUp(_ sender: UIButton) {
        var buttonIndex = 0
        for (index, button) in upButton.enumerated() {
            if button === sender {
                buttonIndex = index
            }
        }
        
        moveEvent(from: buttonIndex + 1, to: buttonIndex)
    }
    
    func checkAnswer() {
        resultButton.isHidden = false
        timerLabel.isHidden = true
        descriptionLabel.text = "Tap events to learn more"
        if checkOrder() {
            playSound(with: correctSound)
            resultButton.setImage(#imageLiteral(resourceName: "next_round_success"), for: .normal)
            correctAnswer += 1
        } else {
            playSound(with: incorrectSound)
            resultButton.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
        }
        buttonState(enable: true, for: eventTitles)
        buttonState(enable: false, for: upButton)
        buttonState(enable: false, for: downButton)
    }
    
    func buttonState(enable: Bool, for buttons: [UIButton]) {
        for button in buttons {
            button.isEnabled = enable
        }
    }
    
    
    @IBAction func nextRound(_ sender: Any) {
        newRound()
    }
    
    @IBAction func eventDetail(_ sender: UIButton) {
        var eventIndex = 0
        for (index, event) in eventTitles.enumerated() {
            if sender === event {
                eventIndex = index
                break
            }
        }
        let eventURL = roundEvents[eventIndex].url
        performSegue(withIdentifier: "eventDetail", sender: eventURL)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            if let destination = segue.destination as? ResultViewController, let wins = sender as? Int {
                destination.wins = wins
            }
        } else if segue.identifier == "eventDetail" {
            if let destination = segue.destination as? EventDetailViewController, let url = sender as? URL {
                destination.url = url
            }
        }
    }
}


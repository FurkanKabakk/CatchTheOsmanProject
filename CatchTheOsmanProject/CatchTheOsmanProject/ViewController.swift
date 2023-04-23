//
//  ViewController.swift
//  CatchTheOsmanProject
//
//  Created by furkan on 5.03.2023.
//

import UIKit

class ViewController: UIViewController {
    var score = 0
    var timer = Timer()
    var counter = 0
    var osmanArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var osman1: UIImageView!
    @IBOutlet weak var osman2: UIImageView!
    @IBOutlet weak var osman3: UIImageView!
    @IBOutlet weak var osman4: UIImageView!
    @IBOutlet weak var osman5: UIImageView!
    @IBOutlet weak var osman6: UIImageView!
    @IBOutlet weak var osman7: UIImageView!
    @IBOutlet weak var osman8: UIImageView!
    @IBOutlet weak var osman9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newHighScore = storedHighScore as? Int {
            highScore = newHighScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
            
    
        osman1.isUserInteractionEnabled = true
        osman2.isUserInteractionEnabled = true
        osman3.isUserInteractionEnabled = true
        osman4.isUserInteractionEnabled = true
        osman5.isUserInteractionEnabled = true
        osman6.isUserInteractionEnabled = true
        osman7.isUserInteractionEnabled = true
        osman8.isUserInteractionEnabled = true
        osman9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        osman1.addGestureRecognizer(recognizer1)
        osman2.addGestureRecognizer(recognizer2)
        osman3.addGestureRecognizer(recognizer3)
        osman4.addGestureRecognizer(recognizer4)
        osman5.addGestureRecognizer(recognizer5)
        osman6.addGestureRecognizer(recognizer6)
        osman7.addGestureRecognizer(recognizer7)
        osman8.addGestureRecognizer(recognizer8)
        osman9.addGestureRecognizer(recognizer9)
        
        osmanArray = [osman1,osman2,osman3,osman4,osman5,osman6,osman7,osman8,osman9]

        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideOsman), userInfo: nil, repeats: true)
        
        hideOsman()
        
    }
    
    @objc func hideOsman(){
        for osman in osmanArray{
            osman.isHidden = true
        }
        
        let random = arc4random_uniform(UInt32(osmanArray.count - 1))
        osmanArray[Int(random)].isHidden = false
        
    }
    
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for osman in osmanArray{
                osman.isHidden = true
            }
            
            
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play game?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self]
                (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideOsman), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
        }
    }
        


}


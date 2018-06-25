//
//  ViewController.swift
//  bullseyeGame
//
//  Created by Adam Moore on 3/9/18.
//  Copyright © 2018 Adam Moore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentSliderValue = 0
    var totalPoints = 0
    var currentRound = 0
    var targetNumber = 0
    var difference = 0
    var pointsEarned = 0
    
    @IBAction func setSliderValue(_ sender: UISlider) {
        currentSliderValue = lroundf(sender.value)
    }
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var goalScore: UILabel!
    @IBOutlet weak var round: UILabel!
    
    @IBAction func startOver(_ sender: UIButton) {
        totalPoints = 0
        currentRound = 0
        startNewRound()
    }
    
    func setTargetNumber () {
        targetNumber = 1 + Int(arc4random_uniform(100))
    }
   
    func startNewRound() {
        currentRound += 1
        setTargetNumber()
        
        scoreLabel.text = String(totalPoints)
        round.text = String(currentRound)
        goalScore.text = String(targetNumber)
    }
    
    func displayHitMeMessageAlert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func hitMe() {
        difference = abs(targetNumber - currentSliderValue)
        pointsEarned = 100 - difference
        
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
            pointsEarned += 100
        } else if difference <= 5 {
            title = "OH, almost!"
        } else if difference <= 10 {
            title = "Pretty close!"
        } else {
            title = "Eh, not even close..."
        }
        
        let message = "Goal: \(targetNumber). You guessed \(currentSliderValue).\nYou were \(difference) points away.\nThis gives you \(pointsEarned) points!"
        
        displayHitMeMessageAlert(title: title, message: message)
        totalPoints += pointsEarned
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentSliderValue = lroundf(slider.value)
        startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


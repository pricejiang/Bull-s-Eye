//
//  ViewController.swift
//  BullsEye
//
//  Created by Minghao Jiang on 12/29/18.
//  Copyright © 2018 Minghao Jiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let roundValue = slider.value.rounded()
        currentValue = Int(roundValue)
        reset()
        
//        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighligheted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighligheted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }
    
    /**
     * This IBAction function that is triggered when Hit-Me is pressed
     * Will calculate how well the player place the Bulls Eye
     * Then, update the score
     * Finally, Start new round
     */
    @IBAction func  showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect"
            points += 100
        } else if difference < 5 {
            if difference == 1 {
                points += 50
            }
            title = "You almost had it! "
        } else if difference < 10 {
            title = "Pretty good! "
        } else {
            title = "Not even close... "
        }
        
        score += points
        
        let message = "You scored \(points)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
//        startNewRound()
    }
    
    /*
     * This IBAction function is connected with slider on the screen.
     * Once slider moved, the currentValue will be updated
     */
    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundValue = slider.value.rounded()
        currentValue = Int(roundValue)
    }
    
    @IBAction func reset() {
        score = 0
        round = 0
        startNewRound()
    }
    
    // Start new round, update the labels, re-initiate the variables
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    // Update target, score, and round labels
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

}


//
//  CommuteDetailsViewController.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-11.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import UIKit

class CommuteDetailsViewController: UIViewController {
    
    var commute: Commute!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureView() {
        let distance = Measurement(value: commute.distance, unit: UnitLength.meters)
        let seconds = Int(commute.duration)
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedDate = FormatDisplay.date(commute.timestamp)
        let formattedTime = FormatDisplay.time(seconds)
        
        distanceLabel.text = "Distance:  \(formattedDistance)"
        dateLabel.text = formattedDate
        timeLabel.text = "Time:  \(formattedTime)"
    }
    

}

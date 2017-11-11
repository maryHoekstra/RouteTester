//
//  NewCommuteViewController.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-09.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import UIKit
import CoreLocation

// view that allows users to log a new commute
class NewCommuteViewController: UIViewController {
    
    @IBOutlet weak var dataStackView: UIStackView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // private instance of commute that can be nil
    private var commute: Commute?
    
    private func startCommute() {
        //launchPromptStackView.isHidden = true
        dataStackView.isHidden = false
        startButton.isHidden = true
        stopButton.isHidden = false
    }
    
    private func stopCommute() {
        //launchPromptStackView.isHidden = false
        dataStackView.isHidden = true
        startButton.isHidden = false
        stopButton.isHidden = true
    }
    
    // tapping the start button starts logging their commute
    @IBAction func startTapped(_ sender: UIButton) {
        startCommute()
    }
    
    // when user taps stop button, they can save or discard their commute
//    @IBAction func stopTapped(_ sender: UIButton) {
//        let alertController = UIAlertController(title: "Finish logging commute?",
//                                                message: "Do you wish to end your commute?",
//                                                preferredStyle: .actionSheet)
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
//            self.stopCommute()
//            self.saveCommmute()
//            self.performSegue(withIdentifier: .details, sender: nil)
//        })
//        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
//            self.stopCommute()
//            _ = self.navigationController?.popToRootViewController(animated: true)
//        })
//
//        present(alertController, animated: true)
//    }
    
    
//    private func saveCommute() {
//        let newCommute = Commute(context: CoreDataStack.context)
//        newCommute.distance = distance.value
//        newCommute.duration = Int16(seconds)
//        newCommute.timestamp = Date()
//
//        for location in locationList {
//            let locationObject = Location(context: CoreDataStack.context)
//            locationObject.timestamp = location.timestamp
//            locationObject.latitude = location.coordinate.latitude
//            locationObject.longitude = location.coordinate.longitude
//            newRun.addToLocations(locationObject)
//        }
//
//        CoreDataStack.saveContext()
//
//        commute = newCommute
//    }
    
    
}

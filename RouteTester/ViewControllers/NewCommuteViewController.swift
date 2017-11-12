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
    
//    @IBOutlet weak var launchPromptStackView: UIStackView!
//    @IBOutlet weak var dataStackView: UIStackView!

    
    private var commute: Commute?
    
    //private let locationManager = LocationManager.shared
    private var seconds = 0
    private var timer: Timer?
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    private var locationList: [CLLocation] = []
    
    private func startCommute() {
        //launchPromptStackView.isHidden = true
        dataStackView.isHidden = false
        startButton.isHidden = true
        stopButton.isHidden = false
        
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        //updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond()
        }
        //startLocationUpdates()
    }
    
    private func stopCommute() {
        //launchPromptStackView.isHidden = false
        dataStackView.isHidden = true
        startButton.isHidden = false
        stopButton.isHidden = true
        
        //locationManager.stopUpdatingLocation()
    }
    
    func eachSecond() {
        seconds += 1
        //updateDisplay()
    }
    
//    private func updateDisplay() {
//        let formattedDistance = FormatDisplay.distance(distance)
//        let formattedTime = FormatDisplay.time(seconds)
//        let formattedPace = FormatDisplay.pace(distance: distance,
//                                               seconds: seconds,
//                                               outputUnit: UnitSpeed.minutesPerMile)
//
//        distanceLabel.text = "Distance:  \(formattedDistance)"
//        timeLabel.text = "Time:  \(formattedTime)"
//        paceLabel.text = "Pace:  \(formattedPace)"
//    }
    
    
    @IBAction func startTapped(_ sender: UIButton) {
        startCommute()
    }
    
    @IBAction func stopTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "End commute?",
                                                message: "Do you wish to finish logging your commute?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            self.stopCommute()
            self.saveCommute()
            self.performSegue(withIdentifier: .details, sender: nil)
        })
        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
            self.stopCommute()
            _ = self.navigationController?.popToRootViewController(animated: true)
        })
        
        present(alertController, animated: true)
    }
    
}

extension NewCommuteViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case details = "CommuteDetailsViewController"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .details:
            let destination = segue.destination as! CommuteDetailsViewController
            destination.commute = commute
        }
    }
    
//    private func startLocationUpdates() {
//        locationManager.delegate = self
//        locationManager.activityType = .fitness
//        locationManager.distanceFilter = 10
//        locationManager.startUpdatingLocation()
//    }
    
    private func saveCommute() {
        let newCommute = Commute(context: CoreDataStack.context)
        newCommute.distance = distance.value
        newCommute.duration = Int16(seconds)
        newCommute.timestamp = Date()
        
        for location in locationList {
            let locationObject = Location(context: CoreDataStack.context)
            locationObject.timestamp = location.timestamp
            locationObject.latitude = location.coordinate.latitude
            locationObject.longitude = location.coordinate.longitude
            newCommute.addToLocations(locationObject)
        }
        
        CoreDataStack.saveContext()
        
        commute = newCommute
    }
}

extension NewCommuteViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            // ensures reading is within 20m of user's actual location
            // ensures reading was collected within the last 10 seconds
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
            }
            
            locationList.append(newLocation)
        }
    }
}


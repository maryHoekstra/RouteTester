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

    private var commute: Commute?
    
    // object to start and stop location services
    private let locationManager = LocationManager.shared
    // tracks duration of commute
    private var seconds = 0
    // timer will fire each second, updating the UI
    private var timer: Timer?
    // distance will hold the cumulative distance of the commute
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    // locationList will hold all location objects collected during commute
    private var locationList: [CLLocation] = []
    
    // hide commute details before start is pressed
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStackView.isHidden = true
    }
    
    // location updates will stop when user navigates away from page
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        locationManager.stopUpdatingLocation()
    }
    
    private func startCommute() {
        //launchPromptStackView.isHidden = true
        dataStackView.isHidden = false
        startButton.isHidden = true
        stopButton.isHidden = false
        // reset all values, start timer, and begin collecting location updates 
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond()
        }
        startLocationUpdates()
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
        updateDisplay()
    }
    
    // update UI
    private func updateDisplay() {
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedTime = FormatDisplay.time(seconds)
        distanceLabel.text = "Distance:  \(formattedDistance)"
        timeLabel.text = "Time:  \(formattedTime)"
    }
    

    @IBAction func start(_ sender: Any) {
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
    
    private func startLocationUpdates() {
        // set NewCommuteViewController as delegate
        locationManager.delegate = self
        //locationManager.activityType = .fitness
        // minimum distance device must move before location is updated
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }
    
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
}

// delegate called each time CoreLocation updates user location
// locations are added to locationList array, where the most recent is the last
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


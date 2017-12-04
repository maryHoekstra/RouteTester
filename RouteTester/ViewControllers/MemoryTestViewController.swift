//
//  MemoryTestViewController.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-26.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import UIKit
import ResearchKit
import GoogleMaps
import CoreData

// Creates memory test and presents MemoryTest task to user
class MemoryTestViewController: UIViewController, ORKTaskViewControllerDelegate, GMSPanoramaViewDelegate {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ImageView1: UIImageView!
    @IBOutlet weak var ImageView2: UIImageView!
    @IBOutlet weak var ImageView3: UIImageView!
    @IBOutlet weak var TestView: UIImageView!
    
    @IBOutlet weak var ContinueButton: UIButton!
    
    var commutes: [Commute]!
    var mostRecent: Commute!
    var locations: NSOrderedSet?
    var numLocations: Int?
    var coordinates: [CLLocationCoordinate2D] = []
//    var coordinates: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 44.230251, longitude: -76.492082), CLLocationCoordinate2D(latitude: 44.230126, longitude: -76.491231),CLLocationCoordinate2D(latitude: 44.229375, longitude: -76.486359)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ContinueButton.isEnabled = false
        
        commutes = getCommutes()
        //let mostRecent = commutes.last
        coordinates = getCoordinates(mostRecentCommute: commutes.last!)
        
        let panoView = GMSPanoramaView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

        panoView.delegate = self
        panoView.setAllGesturesEnabled(false)
        self.ImageView.addSubview(panoView)

        var delay: Double = 0
        // for each coordinate, move near coordinate
        for coordinate in coordinates {
            // increase delay on each iteration, so all views have the chance to be presented
            self.delayWithSeconds(delay) {
                panoView.moveNearCoordinate(coordinate)
                // wait for view to load before taking a snapshot
                self.delayWithSeconds(2) {
                    let streetViewImage = self.ImageView.snapshot
                    self.TestView.image = streetViewImage
                    Test.images.append(streetViewImage!)
                    if Test.images.count == self.coordinates.count {
                        //make continue button available
                        self.ContinueButton.isEnabled = true
                    }
                }
            }
            delay = delay + 2
        }
        
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    func panoramaView(_ view: GMSPanoramaView, didMoveTo panorama: GMSPanorama?) {

    }
    
    @IBAction func LoadPressed(_ sender: UIButton) {
//        self.ImageView1.image = self.images[0]
//        self.ImageView2.image = self.images[1]
//        self.ImageView3.image = self.images[2]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // when continue is tapped, present memory test 
    @IBAction func Continue(_ sender: UIButton) {
        let MemoryTestTaskViewController = ORKTaskViewController(task: MemoryTest, taskRun: nil)
        MemoryTestTaskViewController.delegate = self
        present(MemoryTestTaskViewController, animated: true, completion: nil)
        
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: {
            // mark commute as tested
            
            // navigate back to home screen
            let svc = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.present(svc, animated: true, completion: nil)
        })
    }
    
    // get list of all commutes from CoreData, sorted by recency
    private func getCommutes() -> [Commute] {
        let fetchRequest: NSFetchRequest<Commute> = Commute.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Commute.timestamp), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    // gets 2D coordinates from commute object
    private func getCoordinates(mostRecentCommute: Commute) -> [CLLocationCoordinate2D] {
        locations = mostRecentCommute.locations
        numLocations = locations?.count
        print(numLocations as Int!)
        // for each location, extract longtitude and longitude
        for element in locations! {
            let location = element as! Location
            print(location.latitude)
            print(location.longitude)
            // store in array
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            coordinates.append(coordinate)
        }
        return coordinates
    }
}

extension UIView {
    var snapshot: UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, true, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

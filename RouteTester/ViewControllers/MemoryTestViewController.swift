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
    
    lazy var geocoder = CLGeocoder()
    
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
    //var coordinates: [CLLocationCoordinate2D] = []
    //CLLocationCoordinate2D(latitude: 44.230251, longitude: -76.492082),
    //,CLLocationCoordinate2D(latitude: 44.229375, longitude: -76.486359)
    // biosc:
    //CLLocationCoordinate2D(latitude: 44.226428, longitude: -76.491251)
    
    var coordinates: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 44.229781, longitude: -76.491155)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ContinueButton.isEnabled = false
        //var computedHeading: CLLocationDirection = 0
        commutes = getCommutes()
        //let mostRecent = commutes.last
        //coordinates = getCoordinates(mostRecentCommute: commutes.last!)
        
        let panoView = GMSPanoramaView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

        panoView.delegate = self
        panoView.setAllGesturesEnabled(false)
        self.ImageView.addSubview(panoView)

        var delay: Double = 0
        // for each coordinate, move near coordinate
        // clear images array in Test struct in case user keeps app open
        Test.images = []
        for coordinate in coordinates {
    
            // increase delay on each iteration, so all views have the chance to be presented
            self.delayWithSeconds(delay) {
                
                // this will be within delay code
                
                //             compute heading so that image faces building
                //             get desired address from original gps coordinates by geocoding
                //             get actual gps coordintates of address
                //             compute heading between these two sets of coordinates
                //             load street view image using original gps coordinates with heading
                
                self.computeHeading(coordinate: coordinate) { (heading) in
                    print("!!!!!!")
                    print(heading)
                    panoView.camera = GMSPanoramaCamera(heading: heading, pitch: -10, zoom: 1)
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
            }
            delay = delay + 2
        }
        
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
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
            //self.commutes.last?.tested = true
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
    
    // compute heading so pano faces a building, not the road
    private func computeHeading(coordinate: CLLocationCoordinate2D, completion: @escaping (_ heading: CLLocationDirection)->()) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        var computedHeading: CLLocationDirection = 0
        // if there's an error in either reverse geocoding or forward geocoding, just use coordinate as is
        // Get address of closest building
        self.geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // Process Response
            if let error = error {
                print("Unable to Reverse Geocode Location (\(error))")
                //computedHeading = 0
            }
            else {
                let address = self.getAddress(placemarks: placemarks)
                print(address!)
                // get coordinates from address by forward geocoding
                self.geocoder.geocodeAddressString(address!) { (placemarks, error) in
                    if let error = error {
                        print("Unable to Forward Geocode Address (\(error))")
                        completion(computedHeading)
                    }
                    else {
                        let geocodedCoordinate = self.getCoordinateFromAddress(placemarks: placemarks)
                        print(geocodedCoordinate)
                        computedHeading = GMSGeometryHeading(coordinate, geocodedCoordinate)
                        print("heading....")
                        print(computedHeading)
                        completion(computedHeading)
                    }
                }
            }
        }
    }
    
    private func getAddress(placemarks: [CLPlacemark]?) -> String? {
        let placemarks = placemarks
        let placemark = placemarks?.first
        let address = placemark?.compactAddress
        return address
    }
    
    private func getCoordinateFromAddress(placemarks: [CLPlacemark]?) -> CLLocationCoordinate2D {
        var location: CLLocation?
        //var coordinate2D: CLLocationCoordinate2D?
        location = placemarks?.first?.location
        let coordinate = location?.coordinate
        //print("\(String(describing: coordinate?.latitude)), \(String(describing: coordinate?.longitude))")
        return CLLocationCoordinate2D(latitude: (coordinate?.latitude)!,longitude: (coordinate?.longitude)!)
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

extension CLPlacemark {

    var compactAddress: String? {
        if let name = name {
            var result = name

            if let street = thoroughfare {
                result += ", \(street)"
            }

            if let city = locality {
                result += ", \(city)"
            }

            if let country = country {
                result += ", \(country)"
            }

            return result
        }

        return nil
    }

}


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
    var allCoordinates: [CLLocationCoordinate2D] = []
    var coordinates: [CLLocationCoordinate2D] = []
    //var coordinates: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 44.229781, longitude: -76.491155)]
    //CLLocationCoordinate2D(latitude: 44.230251, longitude: -76.492082),
    //,CLLocationCoordinate2D(latitude: 44.229375, longitude: -76.486359)
    // biosc:
    //CLLocationCoordinate2D(latitude: 44.226428, longitude: -76.491251)
    // 230 barrie st. : CLLocationCoordinate2D(latitude: 44.229781, longitude: -76.491155)
    
    //var allCoordinates: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 44.230251, longitude: -76.492082),CLLocationCoordinate2D(latitude: 44.229375, longitude: -76.486359),CLLocationCoordinate2D(latitude: 44.229781, longitude: -76.491155)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ContinueButton.isEnabled = false
        commutes = getCommutes()
        allCoordinates = getCoordinates(mostRecentCommute: commutes.last!)
        coordinates = allCoordinates
        
        // take random subset of coordinates
        allCoordinates.shuffle()
        coordinates = Array(allCoordinates.prefix(3))
        
        let panoView = GMSPanoramaView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

        panoView.delegate = self
        panoView.setAllGesturesEnabled(false)
        self.ImageView.addSubview(panoView)

        // for each coordinate, move near coordinate
        // clear images array in Test struct in case user keeps app open
        Test.images = []
        Test.imageIdentifiers = []
        
        // generate lures and add them to coordinates array
        let seedCoordinate = coordinates.first!
        // set random seed
        let time = UInt32(NSDate().timeIntervalSinceReferenceDate)
        srand48(Int(time))
        for _ in 0 ..< coordinates.count {
            let randomCoordinate = self.getRandomCoordinate(longitude: seedCoordinate.longitude, latitude: seedCoordinate.latitude, radius: 500)
            print("random coordinate: ", randomCoordinate)
            coordinates.append(randomCoordinate)
        }

        // shuffle array of coordinates so that images will be in random order
        coordinates.shuffle()
        
        var delay: Double = 0
        for coordinate in coordinates {
    
            // increase delay on each iteration, so all views have the chance to be presented
            self.delayWithSeconds(delay) {
                
                // compute heading returns the proper heading for the pano, or 0 if there's an error in geocoding 
                self.computeHeading(coordinate: coordinate) { (heading) in
                    print("heading: ",heading)
                    panoView.camera = GMSPanoramaCamera(heading: heading, pitch: -10, zoom: 1.5)
                    panoView.moveNearCoordinate(coordinate)
                    panoView.streetNamesHidden = true
                    // wait for view to load before taking a snapshot
                    self.delayWithSeconds(4) {
                        let streetViewImage = self.ImageView.snapshot
                        self.TestView.image = streetViewImage
                        Test.images.append(streetViewImage!)
                        Test.imageIdentifiers.append(String(describing: coordinate))
                        if Test.images.count == self.coordinates.count {
                            //make continue button available
                            self.ContinueButton.isEnabled = true
                        }
                    }
                }
            }
            delay = delay + 4
        }
        
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    @IBAction func LoadPressed(_ sender: UIButton) {
        self.ImageView1.image = Test.images[0]
        self.ImageView2.image = Test.images[1]
        self.ImageView3.image = Test.images[2]
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
        self.geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Unable to Reverse Geocode Location (\(error))")
            }
            else {
                let address = self.getAddress(placemarks: placemarks)
                print("address: ", address!)
                // get coordinates from address by forward geocoding
                self.geocoder.geocodeAddressString(address!) { (placemarks, error) in
                    if let error = error {
                        print("Unable to Forward Geocode Address (\(error))")
                        completion(computedHeading)
                    }
                    else {
                        let geocodedCoordinate = self.getCoordinateFromAddress(placemarks: placemarks)
                        computedHeading = GMSGeometryHeading(coordinate, geocodedCoordinate)
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
        location = placemarks?.first?.location
        let coordinate = location?.coordinate
        return CLLocationCoordinate2D(latitude: (coordinate?.latitude)!,longitude: (coordinate?.longitude)!)
    }
    
    // get random coordinate within a specified radius of a latitude and longitude
    private func getRandomCoordinate(longitude: CLLocationDegrees,latitude: CLLocationDegrees,radius: Double) -> CLLocationCoordinate2D {
        // convert radius to degrees
        let newRadius = radius/111000
        let u = drand48()
        let v = drand48()
        let w = newRadius * sqrt(u)
        let t = 2 * Double.pi * v
        let x = w * cos(t)
        let y = w * sin(t)
        let newX = x/cos((latitude / 180 * Double.pi))
        let newLongitude = newX + longitude
        let newLatitude = y + latitude
        let randomCoordinate = CLLocationCoordinate2D(latitude: newLatitude,longitude: newLongitude)
        return randomCoordinate
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

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}


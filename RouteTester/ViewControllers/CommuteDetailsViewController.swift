//
//  CommuteDetailsViewController.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-11.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import UIKit
import MapKit
import ResearchKit

class CommuteDetailsViewController: UIViewController, ORKTaskViewControllerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var continueButton: ORKContinueButton!
    
    var commute: Commute!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // when continue is tapped, present navigation report
    @IBAction func Continue(_ sender: UIButton) {
        let NavReportViewController = ORKTaskViewController(task: NavigationReport, taskRun: nil)
        NavReportViewController.delegate = self
        present(NavReportViewController, animated: true, completion: nil)
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // when user finishes report, dismiss task and go back to home
        taskViewController.dismiss(animated: true, completion: {
            let svc = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.present(svc, animated: true, completion: nil)
        })
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
        
        //loadMap()
    }
    
//    // set region for map
//    private func mapRegion() -> MKCoordinateRegion? {
//        guard
//            let locations = commute.locations,
//            locations.count > 0
//            else {
//                return nil
//        }
//
//        let latitudes = locations.map { location -> Double in
//            let location = location as! Location
//            return location.latitude
//        }
//
//        let longitudes = locations.map { location -> Double in
//            let location = location as! Location
//            return location.longitude
//        }
//
//        let maxLat = latitudes.max()!
//        let minLat = latitudes.min()!
//        let maxLong = longitudes.max()!
//        let minLong = longitudes.min()!
//
//        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2,
//                                            longitude: (minLong + maxLong) / 2)
//        let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.3,
//                                    longitudeDelta: (maxLong - minLong) * 1.3)
//        return MKCoordinateRegion(center: center, span: span)
//    }
//
//    // create overlay
//    // convert locations from commute into objects used by MKPolyline
//    private func polyLine() -> MKPolyline {
//        guard let locations = commute.locations else {
//            return MKPolyline()
//        }
//
//        let coords: [CLLocationCoordinate2D] = locations.map { location in
//            let location = location as! Location
//            return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
//        }
//        return MKPolyline(coordinates: coords, count: coords.count)
//    }
//
//    // ensure there are locations in commute object, then create overlay and display
//    private func loadMap() {
//        guard
//            let locations = commute.locations,
//            locations.count > 0,
//            let region = mapRegion()
//            else {
//                let alert = UIAlertController(title: "Error",
//                                              message: "Sorry, this commute has no locations saved",
//                                              preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
//                present(alert, animated: true)
//                return
//        }
//
//        mapView.setRegion(region, animated: true)
//        mapView.add(polyLine())
//    }
//
//
//
//}
//// delegate method to display map overlay
//extension CommuteDetailsViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        guard let polyline = overlay as? MKPolyline else {
//            return MKOverlayRenderer(overlay: overlay)
//        }
//        let renderer = MKPolylineRenderer(polyline: polyline)
//        renderer.strokeColor = .black
//        renderer.lineWidth = 3
//        return renderer
//    }
}

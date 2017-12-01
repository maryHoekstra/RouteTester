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


// Creates memory test and presents it to the user.
class MemoryTestViewController: UIViewController, ORKTaskViewControllerDelegate, GMSPanoramaViewDelegate {
    
    @IBOutlet weak var ImageView: UIImageView!

    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var TestView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // create memory test
        // load panoview from coordinate
        let panoView = GMSPanoramaView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        panoView.delegate = self
        panoView.setAllGesturesEnabled(false)
        
        panoView.moveNearCoordinate(CLLocationCoordinate2D(latitude: 44.230251, longitude: -76.492082))
        //self.ImageView.addSubview(panoView)
        
    }
    
    func panoramaView(_ view: GMSPanoramaView, didMoveTo panorama: GMSPanorama?) {

        //self.ImageView.addSubview(view)
        //let SnapshotView = view.snapshotView(afterScreenUpdates: true)
        //self.ImageView.addSubview(view.snapshotView(afterScreenUpdates: true)!)
        // can I add the pano to the heirarchy and then take a screenshot?
        self.ImageView.addSubview(view)
        self.ActivityIndicator.startAnimating()
        //ImageView.isHidden = true
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.TestView.image = self.ImageView.snapshot
            self.ActivityIndicator.stopAnimating()
        }
    }
    
    @IBAction func LoadPressed(_ sender: UIButton) {
        self.TestView.image = ImageView.snapshot
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
            let svc = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.present(svc, animated: true, completion: nil)
        })
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

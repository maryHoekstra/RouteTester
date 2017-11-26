//
//  DemographicsViewController.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-26.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import UIKit
import ResearchKit

// Task to present demographics survey
class DemographicsViewController: UIViewController, ORKTaskViewControllerDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // when continue is tapped, present demographics survey
    @IBAction func Continue(_ sender: UIButton) {
        let DemographicsTaskViewController = ORKTaskViewController(task: DemographicsSurvey, taskRun: nil)
        DemographicsTaskViewController.delegate = self
        present(DemographicsTaskViewController, animated: true, completion: nil)
    }
    
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // dismiss survery and go to home page
        taskViewController.dismiss(animated: true, completion: {
            let svc = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.present(svc, animated: true, completion: nil)
        })
    }

}

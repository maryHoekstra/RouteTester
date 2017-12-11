//
//  OnboardingViewController.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-20.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import UIKit
import ResearchKit

class OnboardingViewController: UIViewController, ORKTaskViewControllerDelegate {
    
    @IBOutlet weak var joinStudy: ORKBorderedButton!
    
    // present consent task when join button is pressed
    @IBAction func Join(_ sender: UIButton) {
        let ConsentTaskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        ConsentTaskViewController.delegate = self
        present(ConsentTaskViewController, animated: true, completion: nil)
    }
    
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //print("Task run UUID: \(taskViewController.taskRunUUID.UUIDString)")
        
        switch reason {
        case .completed:
            let result = taskViewController.result
            if let stepResult = result.stepResult(forStepIdentifier: "ConsentReviewStep"),
                let signatureResult = stepResult.results?.first as? ORKConsentSignatureResult {
                    // store results of consenst step in User Defaults
                    UserDefaults.standard.set(signatureResult.consented,forKey: "UserConsented")
                    print(signatureResult.consented)
                    // dismiss taskViewController and present home view controller 
                    taskViewController.dismiss(animated: true, completion: {
                        let svc = self.storyboard!.instantiateViewController(withIdentifier: "DemographicsViewController") as! DemographicsViewController
                        self.present(svc, animated: true, completion: nil)
                    })
            }
        case .discarded, .failed, .saved:
            taskViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

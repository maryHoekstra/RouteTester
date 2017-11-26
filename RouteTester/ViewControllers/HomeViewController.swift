//
//  ViewController.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-08.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import UIKit
import ResearchKit

class HomeViewController: UIViewController, ORKTaskViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    // Present pre-test survey task
    // When user presses Take Test button, the Task View Controller is called
    @IBAction func TakeTest(_ sender: UIButton) {
        // present pre-test survery
        let PreTestTaskViewController = ORKTaskViewController(task: PreTestSurvey, taskRun: nil)
        PreTestTaskViewController.delegate = self
        present(PreTestTaskViewController, animated: true, completion: nil)
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //Handle results with taskViewController.result
        // dismiss pre-test survery and present memory test
        taskViewController.dismiss(animated: true, completion: {
            let svc = self.storyboard!.instantiateViewController(withIdentifier: "MemoryTestViewController") as! MemoryTestViewController
            self.present(svc, animated: true, completion: nil)
        })
    }
    
    
    @IBAction func Memory(_ sender: UIButton) {
        let MemoryTestTaskViewController = ORKTaskViewController(task: MemoryTest, taskRun: nil)
        MemoryTestTaskViewController.delegate = self
        present(MemoryTestTaskViewController, animated: true, completion: nil)
    }
    
}



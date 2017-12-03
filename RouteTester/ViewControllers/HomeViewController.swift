//
//  ViewController.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-08.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import UIKit
import ResearchKit
import CoreData

class HomeViewController: UIViewController, ORKTaskViewControllerDelegate {
    
    var commutes: [Commute]!
    var mostRecent: Commute!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Present pre-test survey task
    // When user presses Take Test button, the Task View Controller is called
    @IBAction func TakeTest(_ sender: UIButton) {
        // present pre-test survey if a commute is available
        // else, show pop up
        commutes = getCommutes()
        let mostRecent = commutes.last
        if mostRecent != nil && mostRecent?.tested == false {
            print("found an un-tested commute")
            let PreTestTaskViewController = ORKTaskViewController(task: PreTestSurvey, taskRun: nil)
            PreTestTaskViewController.delegate = self
            present(PreTestTaskViewController, animated: true, completion: nil)
        }
        else {
            print("no commutes")
            let alertController = UIAlertController(title: "No tests!",
                                                    message: "No tests available. Please log a commute.",
                                                    preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Okay", style: .cancel))           
            present(alertController, animated: true)
        }
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //Handle results with taskViewController.result
        // dismiss pre-test survery and present memory test
        taskViewController.dismiss(animated: true, completion: {
            let svc = self.storyboard!.instantiateViewController(withIdentifier: "MemoryTestViewController") as! MemoryTestViewController
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
    
}



//
//  ConsentTask.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-20.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import Foundation
import ResearchKit

public var ConsentTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    let consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    
    let signature = consentDocument.signatures!.first as! ORKConsentSignature
    
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
    
    reviewConsentStep.text = "Review"
    reviewConsentStep.reasonForConsent = "Consent to join study"
    
    steps += [reviewConsentStep]
    
    let completionStep = ORKCompletionStep(identifier: "CompletionStep")
    completionStep.title = NSLocalizedString("Welcome aboard.", comment: "")
    completionStep.text = NSLocalizedString("Thank you for joining this study.", comment: "")
    
    steps += [completionStep]
    

    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}

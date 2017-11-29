//
//  MemoryTest.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-08.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import ResearchKit

// Task to present Memory Test
public var MemoryTest: ORKOrderedTask {
    
    
    var steps = [ORKStep]()
    var testImages: [UIImage] = []
    // populate image array
    testImages += [UIImage(named: "Cat1")!,UIImage(named: "Cat2")!,UIImage(named: "Cat3")!]
    var stepIdentifiers: [String] = ["Step1", "Step2", "Step3"]
    var imageIdentifiers: [String] = ["Img1","Img2","Img3"]
    var responseIdentifiers: [String] = ["Response1","Response2","Response3"]
    
    // instructions
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Memory Test"
    instructionStep.text = "For each of the following images, rate your recollection of the scene on a scale of 1 to 5."
    steps += [instructionStep]
    
    // try looping through images
    
    //let questionText = "Rate your recollection on a scale of 1 to 5."
    for i in 0 ..< imageIdentifiers.count {
        let sampleStep = ORKFormStep(identifier: stepIdentifiers[i], title: nil, text: nil)
        sampleStep.isOptional = false
    
        //let image = UIImage(named: "Cat")!
        let imageText = NSLocalizedString("Cat", comment: "")
    
        let imageChoices = [
            ORKImageChoice(normalImage: testImages[i], selectedImage: nil, text: nil, value: imageText as NSCoding & NSCopying & NSObjectProtocol)
        ]
    
        // A first field, for displaying your image.
        //let formItem01Text = NSLocalizedString("Your Image", comment: "")
        let formItem01 = ORKFormItem(identifier: imageIdentifiers[i], text: nil, answerFormat: ORKAnswerFormat.choiceAnswerFormat(with: imageChoices))
    
        // A second field, for the scale.
        //let formItem02Text = NSLocalizedString("Your Scale", comment: "")
        let formItem02 = ORKFormItem(identifier: responseIdentifiers[i], text: nil, answerFormat: ORKAnswerFormat.scale(withMaximumValue: 5, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: nil, minimumValueDescription: nil))
    
        sampleStep.formItems = [
            formItem01,
            formItem02
        ]
        steps += [sampleStep]
    }
    
    // summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Test Complete"
    summaryStep.text = "Your responses have been recorded."
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "MemoryTest", steps: steps)
}

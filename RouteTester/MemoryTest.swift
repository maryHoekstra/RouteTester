//
//  MemoryTest.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-08.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import Foundation
import ResearchKit

public var MemoryTest: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    // instructions
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Memory Test"
    instructionStep.text = "For each of the following images, rate your recollection of the scene on a scale of 1 to 5."
    steps += [instructionStep]
    
    //let questionText = "Rate your recollection on a scale of 1 to 5."
    let sampleStep = ORKFormStep(identifier: "sample", title: nil, text: nil)
    sampleStep.isOptional = false
    
    let image = UIImage(named: "Cat")!
    let imageText = NSLocalizedString("Cat", comment: "")
    
    let imageChoices = [
        ORKImageChoice(normalImage: image, selectedImage: nil, text: nil, value: imageText as NSCoding & NSCopying & NSObjectProtocol)
    ]
    
    // A first field, for displaying your image.
    //let formItem01Text = NSLocalizedString("Your Image", comment: "")
    let formItem01 = ORKFormItem(identifier: "image", text: nil, answerFormat: ORKAnswerFormat.choiceAnswerFormat(with: imageChoices))
    
    // A second field, for the scale.
    //let formItem02Text = NSLocalizedString("Your Scale", comment: "")
    let formItem02 = ORKFormItem(identifier: "string", text: nil, answerFormat: ORKAnswerFormat.scale(withMaximumValue: 5, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: nil, minimumValueDescription: nil))
    
    sampleStep.formItems = [
        formItem01,
        formItem02
    ]
    steps += [sampleStep]
    
    // summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Test Complete"
    summaryStep.text = "Your responses have been recorded."
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "MemoryTest", steps: steps)
}

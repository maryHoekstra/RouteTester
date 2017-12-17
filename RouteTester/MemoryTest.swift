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
    
    // instructions
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Memory Test"
    instructionStep.text = "For each of the following images, rate your recollection of the scene on a scale of 1 to 5. A rating of 1 means 'This scene was not on my route' and a rating of 5 means 'This scene was definitely on my route'."
    steps += [instructionStep]
    
    for i in 0 ..< Test.images.count {
        let sampleStep = ORKFormStep(identifier: "step" + String(i), title: nil, text: nil)
        sampleStep.isOptional = false
    
        let imageText = NSLocalizedString("Street View Image", comment: "")
    
        let imageChoices = [
            ORKImageChoice(normalImage: Test.images[i], selectedImage: nil, text: nil, value: imageText as NSCoding & NSCopying & NSObjectProtocol)
        ]
    
        // a first field, for displaying the image
        let formItem01 = ORKFormItem(identifier: Test.imageIdentifiers[i], text: nil, answerFormat: ORKAnswerFormat.choiceAnswerFormat(with: imageChoices))
    
        // a second field, for the scale
        let formItem02 = ORKFormItem(identifier: "scaleResponse" + String(i), text: "Rate your memory of this scene:", answerFormat: ORKAnswerFormat.scale(withMaximumValue: 5, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: nil, minimumValueDescription: nil))
    
        // a third field for rating the success of the trial
        let iconTuples = [
            (UIImage(named: "ImageDidNotLoad")!, "Image didn't load"),
            (UIImage(named: "NotAHouse")!, "Not a building"),
            (UIImage(named: "AllGood")!, "Clear image of building"),
        ]
        let iconChoices : [ORKImageChoice] = iconTuples.map {
            return ORKImageChoice(normalImage: $0.0, selectedImage: nil, text: $0.1, value: $0.1 as NSCoding & NSCopying & NSObjectProtocol)
        }
        let iconAnswerFormat: ORKImageChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: iconChoices)
        let formItem03 = ORKFormItem(identifier: "iconResponse" + String(i), text: "Rate the quality of the image:", answerFormat: iconAnswerFormat)
        
        
        sampleStep.formItems = [
            formItem01,
            formItem02,
            formItem03
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

//
//  MemoryTest.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-08.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import Foundation
import ResearchKit

// Task to present memory test
public var MemoryTest: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    // instructions
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Memory Test"
    instructionStep.text = "For each of the following images, rate your recollection of the scene on a scale of 1 to 5."
    steps += [instructionStep]
    
    // questions
    
   
    
    // summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Test Complete"
    summaryStep.text = "Your responses have been recorded."
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "MemoryTest", steps: steps)
    
}

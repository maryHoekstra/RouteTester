//
//  PreTestSurvey.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-08.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import ResearchKit

// Task to present pre-test survery
public var PreTestSurvey: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Pre-Test Questionnaire"
    instructionStep.text = "Before taking the test, please fill out this 4-item questionnare."
    instructionStep.image = UIImage(named: "Cat")!
    steps += [instructionStep]
    
//    // How many hours of sleep did you get last night?;{'~isnan(num) & num>=0','must be a positive number'};{};[];{}
//    let restedAnswerFormat = ORKNumericAnswerFormat(style: ORKNumericAnswerStyle.decimal, unit: "hours", minimum: 0, maximum: 24)
//    let restedQuestionStepTitle = "How many hours of sleep did you get last night?"
//    let restedQuestionStep = ORKQuestionStep(identifier: "restedQuestionStep",title: restedQuestionStepTitle, answer: restedAnswerFormat)
//    steps += [restedQuestionStep]
//
//    // How healthy are you today?;{'Normal','Somewhat sick','Very sick'}
//    let healthyQuestionStepTitle = "How healthy are you today?"
//    let healthyChoices = [
//        ORKTextChoice(text: "Normal", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Somewhat sick", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Very sick", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let healthyAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: healthyChoices)
//    let healthyQuestionStep = ORKQuestionStep(identifier: "healthyQuestionStep", title: healthyQuestionStepTitle, answer: healthyAnswerFormat)
//
//    steps += [healthyQuestionStep]
//
//    // What is your current alertness?;{'Very sleepy','Somewhat sleepy','Neither alert nor sleepy','Somewhat alert','Very alert'}
//    let alertnessQuestionStepTitle = "What is your current alertness?"
//    let alertnessChoices = [
//        ORKTextChoice(text: "Very sleepy", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Somewhat sleepy", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither alert nor sleepy", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Somewhat alert", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Very alert", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let alertnessAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: alertnessChoices)
//    let alertnessQuestionStep = ORKQuestionStep(identifier: "alertnessQuestionStep", title: alertnessQuestionStepTitle, answer: alertnessAnswerFormat)
//    steps += [alertnessQuestionStep]
    
    // How happy do you feel right now?;{'Very','Happy','Neutral','A little low','Very sad'}
    let moodQuestionStepTitle = "How happy do you feel right now?"
    let moodChoices = [
        ORKTextChoice(text: "Very", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Happy", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Neutral", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "A little low", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Very sad", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let moodAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: moodChoices)
    
    let moodQuestionStep = ORKQuestionStep(identifier: "moodQuestionStep", title: moodQuestionStepTitle, answer: moodAnswerFormat)
    steps += [moodQuestionStep]
    
    // summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Questionnare Complete"
    summaryStep.text = "You are ready to start the test."
    steps += [summaryStep]

    
    
    return ORKOrderedTask(identifier: "PreTestSurvey", steps: steps)
    
}


//
//  NavigationReport.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-26.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import ResearchKit

// Task to present pre-test survery
public var NavigationReport: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Navigation Report"
    instructionStep.text = "Please fill out this 10-item questionnare."
    //instructionStep.image = UIImage(named: "Cat1")!
    steps += [instructionStep]
    
//    // How are you carrying your phone today? (mounted to belt, in a backpack, by hand, in a hand-held bag/briefcase/clutch purse, in a shoulder-mounted bag / briefcase / shoulder purse, pants pocket (waist), pants pocket (leg), shirt pocket (chest), coat/jacket pocket (waist), coat/jacket pocket (chest), other).
//    let phoneQuestionStepTitle = "How are you carrying your phone today?"
//    let phoneChoices = [
//        ORKTextChoice(text: "Mounted to belt", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "In a backpack", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "By hand", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "In a hand-held bag / briefcase / clutch purse", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "In a shoulder-mounted bag / briefcase / shoulder purse", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Pants pocket (waist)", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Pants pocket (leg)", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Shirt pocket (chest)", value: 7 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Coat/jacket pocket (waist)", value: 8 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Coat/jacket pocket (chest)", value: 9 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Other", value: 10 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let phoneAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: phoneChoices)
//    let phoneQuestionStep = ORKQuestionStep(identifier: "phoneQuestionStep", title: phoneQuestionStepTitle, answer: phoneAnswerFormat)
//    steps += [phoneQuestionStep]
//
//    // How were you traveling? (walking, running, skateboard, scooter, bicycle, motor vehicle, public transit, other)
//    let travelQuestionStepTitle = "How were you traveling?"
//    let travelChoices = [
//        ORKTextChoice(text: "Walking", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Running", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Skateboard", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Scooter", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Bicyle", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Motor vehicle", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Public transit", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Other", value: 7 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let travelAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: travelChoices)
//    let travelQuestionStep = ORKQuestionStep(identifier: "travelQuestionStep", title: travelQuestionStepTitle, answer: travelAnswerFormat)
//    steps += [travelQuestionStep]
//
//    // Were you travelling alone? (alone, with one person, with a group)
//    let travelCompanionQuestionStepTitle = "Were you travelling alone?"
//    let travelCompanionChoices = [
//        ORKTextChoice(text: "Alone", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "With one person", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "With a group", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ]
//    let travelCompanionAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: travelCompanionChoices)
//    let travelCompanionQuestionStep = ORKQuestionStep(identifier: "travelCompanionQuestionStep", title: travelCompanionQuestionStepTitle, answer: travelCompanionAnswerFormat)
//    steps += [travelCompanionQuestionStep]
//
//    // What was your pace of travel like? (very slow, leisurely, moderate, brisk, rushed)
//    let travelPaceQuestionStepTitle = "What was your pace of travel like?"
//    let travelPaceChoices = [
//        ORKTextChoice(text: "Very slow", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Leisurely", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Moderate", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Brisk", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Rushed", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ]
//    let travelPaceAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: travelPaceChoices)
//    let travelPaceQuestionStep = ORKQuestionStep(identifier: "travelPaceQuestionStep", title: travelPaceQuestionStepTitle, answer: travelPaceAnswerFormat)
//    steps += [travelPaceQuestionStep]
//
//    // How relaxed were you? (very relaxed, somewhat relaxed, neither relaxed nor tense, somewhat tense, very tense)
//    let relaxedQuestionStepTitle = "How relaxed were you?"
//    let relaxedChoices = [
//        ORKTextChoice(text: "Very relaxed", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Somewhat relaxed", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither relaxed nor tense", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Somewhat tense", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Very tense", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ]
//    let relaxedAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: relaxedChoices)
//    let relaxedQuestionStep = ORKQuestionStep(identifier: "relaxedQuestionStep", title: relaxedQuestionStepTitle, answer: relaxedAnswerFormat)
//    steps += [relaxedQuestionStep]
//
//    // How pleasant was your trip? (very unpleasant, somewhat unpleasant, neither pleasant nor unpleasant, somewhat pleasant, very pleasant)
//    let pleasantQuestionStepTitle = "How pleasant was your trip?"
//    let pleasantChoices = [
//        ORKTextChoice(text: "Very unpleasant", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Somewhat unpleasant", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither pleasant nor unpleasant", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Somewhat pleasant", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Very pleasant", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ]
//    let pleasantAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: pleasantChoices)
//    let pleasantQuestionStep = ORKQuestionStep(identifier: "pleasantQuestionStep", title: pleasantQuestionStepTitle, answer: pleasantAnswerFormat)
//    steps += [pleasantQuestionStep]
//
//    // How confident were you? (very confident, somewhat confident, neither confident nor fearful, somewhat fearful, very fearful)
//    let confidentQuestionStepTitle = "How confident were you?"
//    let confidentChoices = [
//        ORKTextChoice(text: "Very confident", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Somewhat confident", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither confident nor fearful", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Somewhat fearful", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Very fearful", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ]
//    let confidentAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: confidentChoices)
//    let confidentQuestionStep = ORKQuestionStep(identifier: "confidentQuestionStep", title: confidentQuestionStepTitle, answer: confidentAnswerFormat)
//    steps += [confidentQuestionStep]
//
//    // How "caffeinated" are you?;{'Not at all','Somewhat','Very'};[];{}
//    let caffeinatedQuestionStepTitle = "How 'caffeinated' are you?"
//    let caffeinatedChoices = [
//        ORKTextChoice(text: "Not at all", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Somewhat", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Very", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let caffeinatedAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: caffeinatedChoices)
//    let caffeinatedQuestionStep = ORKQuestionStep(identifier: "caffeinatedQuestionStep", title: caffeinatedQuestionStepTitle, answer: caffeinatedAnswerFormat)
//    steps += [caffeinatedQuestionStep]
//
//    // How drunk were you?;{'Not at all','Somewhat','Very'}
//    let drunkQuestionStepTitle = "How drunk were you?"
//    let drunkChoices = [
//        ORKTextChoice(text: "Not at all", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Somewhat", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Very", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let drunkAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: drunkChoices)
//    let drunkQuestionStep = ORKQuestionStep(identifier: "drunkQuestionStep", title: drunkQuestionStepTitle, answer: drunkAnswerFormat)
//    steps += [drunkQuestionStep]
    
    // How stoned or "high" were you?;{'Not at all','Somewhat','Very'}
    let stonedQuestionStepTitle = "How stoned or 'high' were you?"
    let stonedChoices = [
        ORKTextChoice(text: "Not at all", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Somewhat", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Very", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let stonedAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: stonedChoices)
    let stonedQuestionStep = ORKQuestionStep(identifier: "stonedQuestionStep", title: stonedQuestionStepTitle, answer: stonedAnswerFormat)
    steps += [stonedQuestionStep]
    
    // summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Questionnare Complete"
    summaryStep.text = "Thank you!"
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "NavigationReport", steps: steps)
    
}



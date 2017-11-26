//
//  DemographicsSurvey.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-26.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import ResearchKit

// Task to present demographics survey
public var DemographicsSurvey: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Demographics Survey"
    instructionStep.text = "Before using this app, please fill out this 5-minute, 30-item questionnare."
    instructionStep.image = UIImage(named: "Cat")!
    steps += [instructionStep]
    
    // What is your age (in years)? enforce number 18-130
    let ageAnswerFormat = ORKNumericAnswerFormat(style: ORKNumericAnswerStyle.integer, unit: "years", minimum: 18, maximum: 130)
    let ageQuestionStepTitle = "What is your age?"
    let ageQuestionStep = ORKQuestionStep(identifier: "ageQuestionStep",title: ageQuestionStepTitle, answer: ageAnswerFormat)
    steps += [ageQuestionStep]
    
//    // What is your sex?{'Female','Male','Other'}
//    let sexQuestionStepTitle = "What is your sex?"
//    let sexChoices = [
//        ORKTextChoice(text: "Male", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Female", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Other", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let sexAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: sexChoices)
//    let sexQuestionStep = ORKQuestionStep(identifier: "sexQuestionStep", title: sexQuestionStepTitle, answer: sexAnswerFormat)
//    steps += [sexQuestionStep]
//
//    // What is your height (option to specify in inches or cm)?
//    // What is your weight (option to specify in lbs or kg)?
//
//    // Which hand do you normally use to write a letter?;{'Always left','Usually left','No preference','Usually right','Always right'};
//    let handQuestionStepTitle = "Which hand you normally use to write a letter?"
//    let handChoices = [
//        ORKTextChoice(text: "Always left", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Usually left", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "No preference", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Usually right", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Always right", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let handAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: handChoices)
//    let handQuestionStep = ORKQuestionStep(identifier: "handQuestionStep", title: handQuestionStepTitle, answer: handAnswerFormat)
//    steps += [handQuestionStep]
//
//    // Which foot do you normally use to kick a ball?;{'Always left','Usually left','No preference','Usually right','Always right'}
//    let footQuestionStepTitle = "Which foot do you normally use to kick a ball?"
//    let footChoices = [
//        ORKTextChoice(text: "Always left", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Usually left", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "No preference", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Usually right", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Always right", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let footAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: footChoices)
//    let footQuestionStep = ORKQuestionStep(identifier: "footQuestionStep", title: footQuestionStepTitle, answer: footAnswerFormat)
//    steps += [footQuestionStep]
//
//    // How well do you speak English?;{'No English','Beginner','Intermediate','Fluent (ESL)','Fluent (native-speaker)
//    let languageQuestionStepTitle = "How well do you speak English?"
//    let languageChoices = [
//        ORKTextChoice(text: "No English", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Beginner", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Intermediate", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Fluent (ESL)", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Fluent (native-speaker)", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let languageAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: languageChoices)
//    let languageQuestionStep = ORKQuestionStep(identifier: "languageQuestionStep", title: languageQuestionStepTitle, answer: languageAnswerFormat)
//    steps += [languageQuestionStep]
//
//    // Counting from grade 1, how many years of formal education have you completed?
//    let educationAnswerFormat = ORKNumericAnswerFormat(style: ORKNumericAnswerStyle.integer, unit: "years", minimum: 0, maximum: 50)
//    let educationQuestionStepTitle = "Counting from grade 1, how many years of formal education have you completed?"
//    let educationQuestionStep = ORKQuestionStep(identifier: "educationQuestionStep",title: educationQuestionStepTitle, answer: educationAnswerFormat)
//    steps += [educationQuestionStep]
//
//    // Are there any psychological or neurological issues for which you have received a diagnosis or sought professional help (e.g., depression, epilepsy)? If so, what are they?
//
//    // Are you suffering from any serious medical issues that are NOT neurological / mental-health related (e.g., broken arm, arthritis)? If so, what are they?
//
//    // Are you currently pregnant? {'No','Unsure','Yes, first trimester','Yes, second trimester','Yes, third trimester' }
//    let pregnancyQuestionStepTitle = "Are you currently pregnant?"
//    let pregnancyChoices = [
//        ORKTextChoice(text: "No", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Unsure", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Yes, first trimester", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Yes, second trimester", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Yes, third trimester", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let pregnancyAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: pregnancyChoices)
//    let pregnancyQuestionStep = ORKQuestionStep(identifier: "pregnancyQuestionStep", title: pregnancyQuestionStepTitle, answer: pregnancyAnswerFormat)
//    steps += [pregnancyQuestionStep]
//
//    // In general, what is your physical health like?;{'Excellent','Very good','Good','Fair','Poor'}
//    let healthQuestionStepTitle = "In general, what is your physical health like?"
//    let healthChoices = [
//        ORKTextChoice(text: "Excellent", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Very good", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Good", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Fair", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Poor", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let healthAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: healthChoices)
//    let healthQuestionStep = ORKQuestionStep(identifier: "healthQuestionStep", title: healthQuestionStepTitle, answer: healthAnswerFormat)
//    steps += [healthQuestionStep]
//
//    // What is your occupational status?{'Employed full-time','Employed part-time','Retired','Student','Student employed part-time','Full-time parenting','On disability','On Employment Insurance (EI)','On Social Assistance','Unemployed','Other'
//    let occupationStatusQuestionStepTitle = "What is your occupational status?"
//    let occupationStatusChoices = [
//        ORKTextChoice(text: "Employed full-time", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Employed part-time", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Retired", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Student", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Student employed part-time", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Full-time parenting", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "On disability", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "On Employment Insurance (EI)", value: 7 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "On Social Assistance", value: 8 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Unemployed", value: 9 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Other", value: 10 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let occupationStatusAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: occupationStatusChoices)
//    let occupationStatusQuestionStep = ORKQuestionStep(identifier: "occupationStatusQuestionStep", title: occupationStatusQuestionStepTitle, answer: occupationStatusAnswerFormat)
//    steps += [occupationStatusQuestionStep]
//
//    // In what job would you imagine "you at your best", based on your interests and aptitudes?
//    let dreamJobAnswerFormat = ORKTextAnswerFormat(maximumLength: 100)
//    let dreamJobQuestionStepTitle = "In what job would you imagine 'you at your best', based on your interests and aptitudes?"
//    let dreamJobQuestionStep = ORKQuestionStep(identifier: "dreamJobQuestionStep", title: dreamJobQuestionStepTitle, answer: dreamJobAnswerFormat)
//    steps += [dreamJobQuestionStep]
//
//    // How many hours of sleep do you normally get on a weeknight?;{'~isnan(num) & num>=-1 & num<=24','must be a number 0-24.'};{};[];{}
//    let sleepAnswerFormat = ORKNumericAnswerFormat(style: ORKNumericAnswerStyle.decimal, unit: "hours", minimum: 0, maximum: 24)
//    let sleepQuestionStepTitle = "How many hours of sleep do you normally get on a weeknight?"
//    let sleepQuestionStep = ORKQuestionStep(identifier: "sleepQuestionStep",title: sleepQuestionStepTitle, answer: sleepAnswerFormat)
//    steps += [sleepQuestionStep]
//
//    // How many hours of sleep do you normally get on a weekend?;{'~isnan(num) & num>=-1 & num<=24','must be a number 0-24.'};{};[];{}
//    let sleepWeekendAnswerFormat = ORKNumericAnswerFormat(style: ORKNumericAnswerStyle.decimal, unit: "hours", minimum: 0, maximum: 24)
//    let sleepWeekendQuestionStepTitle = "How many hours of sleep do you normally get on a weekend?"
//    let sleepWeekendQuestionStep = ORKQuestionStep(identifier: "sleepWeekendQuestionStep",title: sleepWeekendQuestionStepTitle, answer: sleepWeekendAnswerFormat)
//    steps += [sleepWeekendQuestionStep]
//
//    // Please describe your normal daytime sleepiness on a scale from 0 (struggle to stay awake all day) to 10 (fully alert all day).;{'~isnan(num) & num>=-1 & num<=10','must be a number 0-10.'};{};[];{}
//
//
//    // In the past month, has your home been a stressful or pleasant environment?
//    let homeAnswerFormat = ORKTextAnswerFormat(maximumLength: 100)
//    let homeQuestionStepTitle = "In the past month, has your home been a stressful or pleasant environment?"
//    let homeQuestionStep = ORKQuestionStep(identifier: "homeQuestionStep", title: homeQuestionStepTitle, answer: homeAnswerFormat)
//    steps += [homeQuestionStep]
//
//    // In the past month, has school / your workplace been a stressful or pleasant environment?
//    let workplaceAnswerFormat = ORKTextAnswerFormat(maximumLength: 100)
//    let workplaceQuestionStepTitle = "In the past month, has school / your workplace been a stressful or pleasant environment?"
//    let workplaceQuestionStep = ORKQuestionStep(identifier: "workplaceQuestionStep", title: workplaceQuestionStepTitle, answer: workplaceAnswerFormat)
//    steps += [workplaceQuestionStep]
//
//    // "I would characterize myself as someone who:";{'never daydreams','very rarely engages in daydreaming','tends towards occasional daydreaming','tends towards moderate daydreaming','is a habitual daydreamer'}
//    let daydreamQuestionStepTitle = "I would characterize myself as someone who:"
//    let daydreamChoices = [
//        ORKTextChoice(text: "never daydreams", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "very rarely engages in daydreaming", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "tends toward occasional daydreaming", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "tends toward moderate daydreaming", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "is a habitual daydreamer", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let daydreamAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: daydreamChoices)
//    let daydreamQuestionStep = ORKQuestionStep(identifier: "daydreamQuestionStep", title: daydreamQuestionStepTitle, answer: daydreamAnswerFormat)
//    steps += [daydreamQuestionStep]
//
//    // "I see myself as: extraverted, enthusiastic.";{'Disagree strongly','Disagree moderately','Disagree a little','Neither agree nor disagree','Agree a little','Agree moderately','Agree strongly'}
//    let extravertQuestionStepTitle = "I see myself as: extraverted, enthusiastic."
//    let extravertChoices = [
//        ORKTextChoice(text: "Disagree strongly", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree moderately", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree a little", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither agree nor disagree", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree a little", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree moderately", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree strongly", value: 6 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let extravertAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: extravertChoices)
//    let extravertQuestionStep = ORKQuestionStep(identifier: "extravertQuestionStep", title: extravertQuestionStepTitle, answer: extravertAnswerFormat)
//    steps += [extravertQuestionStep]
//
//    // "I see myself as: critical, quarrelsome.";{'Disagree strongly','Disagree moderately','Disagree a little','Neither agree nor disagree','Agree a little','Agree moderately','Agree strongly'}
//    let criticalQuestionStepTitle = "I see myself as: critical, quarrelsome."
//    let criticalChoices = [
//        ORKTextChoice(text: "Disagree strongly", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree moderately", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree a little", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither agree nor disagree", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree a little", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree moderately", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree strongly", value: 6 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let criticalAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: criticalChoices)
//    let criticalQuestionStep = ORKQuestionStep(identifier: "criticalQuestionStep", title: criticalQuestionStepTitle, answer: criticalAnswerFormat)
//    steps += [criticalQuestionStep]
//
//    // "I see myself as: dependable, self-disciplined.";{'Disagree strongly','Disagree moderately','Disagree a little','Neither agree nor disagree','Agree a little','Agree moderately','Agree strongly'}
//    let dependableQuestionStepTitle = "I see myself as: dependable, self-disciplined."
//    let dependableChoices = [
//        ORKTextChoice(text: "Disagree strongly", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree moderately", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree a little", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither agree nor disagree", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree a little", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree moderately", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree strongly", value: 6 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let dependableAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: dependableChoices)
//    let dependableQuestionStep = ORKQuestionStep(identifier: "dependableQuestionStep", title: dependableQuestionStepTitle, answer: dependableAnswerFormat)
//    steps += [dependableQuestionStep]
//
//    // "I see myself as: anxious, easily upset.";{'Disagree strongly','Disagree moderately','Disagree a little','Neither agree nor disagree','Agree a little','Agree moderately','Agree strongly'}
//    let anxiousQuestionStepTitle = "I see myself as: anxious, easily upset."
//    let anxiousChoices = [
//        ORKTextChoice(text: "Disagree strongly", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree moderately", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree a little", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither agree nor disagree", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree a little", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree moderately", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree strongly", value: 6 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let anxiousAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: anxiousChoices)
//    let anxiousQuestionStep = ORKQuestionStep(identifier: "anxiousQuestionStep", title: anxiousQuestionStepTitle, answer: anxiousAnswerFormat)
//    steps += [anxiousQuestionStep]
//
//    // "I see myself as: open to new experiences, complex.";{'Disagree strongly','Disagree moderately','Disagree a little','Neither agree nor disagree','Agree a little','Agree moderately','Agree strongly'};
//    let openQuestionStepTitle = "I see myself as: open to new experience, complex."
//    let openChoices = [
//        ORKTextChoice(text: "Disagree strongly", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree moderately", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree a little", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither agree nor disagree", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree a little", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree moderately", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree strongly", value: 6 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let openAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: openChoices)
//    let openQuestionStep = ORKQuestionStep(identifier: "openQuestionStep", title: openQuestionStepTitle, answer: openAnswerFormat)
//    steps += [openQuestionStep]
//
//    // "I see myself as: reserved, quiet.";{'Disagree strongly','Disagree moderately','Disagree a little','Neither agree nor disagree','Agree a little','Agree moderately','Agree strongly'}
//    let reservedQuestionStepTitle = "I see myself as: reserved, quiet."
//    let reservedChoices = [
//        ORKTextChoice(text: "Disagree strongly", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree moderately", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree a little", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither agree nor disagree", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree a little", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree moderately", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree strongly", value: 6 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let reservedAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: reservedChoices)
//    let reservedQuestionStep = ORKQuestionStep(identifier: "reservedQuestionStep", title: reservedQuestionStepTitle, answer: reservedAnswerFormat)
//    steps += [reservedQuestionStep]
//
//    // "I see myself as: sympathetic, warm.";{'Disagree strongly','Disagree moderately','Disagree a little','Neither agree nor disagree','Agree a little','Agree moderately','Agree strongly'}
//    let sympatheticQuestionStepTitle = "I see myself as: sympathetic, warm."
//    let sympatheticChoices = [
//        ORKTextChoice(text: "Disagree strongly", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree moderately", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree a little", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither agree nor disagree", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree a little", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree moderately", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree strongly", value: 6 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let sympatheticAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: sympatheticChoices)
//    let sympatheticQuestionStep = ORKQuestionStep(identifier: "sympatheticQuestionStep", title: sympatheticQuestionStepTitle, answer: sympatheticAnswerFormat)
//    steps += [sympatheticQuestionStep]
//
//    // "I see myself as: disorganized, careless.";{'Disagree strongly','Disagree moderately','Disagree a little','Neither agree nor disagree','Agree a little','Agree moderately','Agree strongly'}
//    let disorganizedQuestionStepTitle = "I see myself as: disorganized, careless."
//    let disorganizedChoices = [
//        ORKTextChoice(text: "Disagree strongly", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree moderately", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree a little", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither agree nor disagree", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree a little", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree moderately", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree strongly", value: 6 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let disorganizedAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: disorganizedChoices)
//    let disorganizedQuestionStep = ORKQuestionStep(identifier: "disorganizedQuestionStep", title: disorganizedQuestionStepTitle, answer: disorganizedAnswerFormat)
//    steps += [disorganizedQuestionStep]
//
//    // "I see myself as: calm, emotionally stable.";{'Disagree strongly','Disagree moderately','Disagree a little','Neither agree nor disagree','Agree a little','Agree moderately','Agree strongly'}
//    let calmQuestionStepTitle = "I see myself as: calm, emotionally stable."
//    let calmChoices = [
//        ORKTextChoice(text: "Disagree strongly", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree moderately", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree a little", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither agree nor disagree", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree a little", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree moderately", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree strongly", value: 6 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let calmAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: calmChoices)
//    let calmQuestionStep = ORKQuestionStep(identifier: "calmQuestionStep", title: calmQuestionStepTitle, answer: calmAnswerFormat)
//    steps += [calmQuestionStep]
//
//    // "I see myself as: conventional, uncreative.";{'Disagree strongly','Disagree moderately','Disagree a little','Neither agree nor disagree','Agree a little','Agree moderately','Agree strongly'}
//    let conventionalQuestionStepTitle = "I see myself as: conventional, uncreative."
//    let conventionalChoices = [
//        ORKTextChoice(text: "Disagree strongly", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree moderately", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Disagree a little", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Neither agree nor disagree", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree a little", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree moderately", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
//        ORKTextChoice(text: "Agree strongly", value: 6 as NSCoding & NSCopying & NSObjectProtocol)
//    ]
//    let conventionalAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: conventionalChoices)
//    let conventionalQuestionStep = ORKQuestionStep(identifier: "conventionalQuestionStep", title: conventionalQuestionStepTitle, answer: conventionalAnswerFormat)
//    steps += [conventionalQuestionStep]
    
    // summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Questionnare Complete"
    summaryStep.text = "You are ready to use the app."
    steps += [summaryStep]
    
    
    
    return ORKOrderedTask(identifier: "DemographicsSurvey", steps: steps)
    
}

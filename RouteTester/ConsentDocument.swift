//
//  ConsentDocument.swift
//  RouteTester
//
//  Created by Mary Hoekstra on 2017-11-20.
//  Copyright © 2017 Mary Hoekstra. All rights reserved.
//

import Foundation
import ResearchKit

public var ConsentDocument: ORKConsentDocument {
    
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Consent Document"
    
    let consentSectionTypes: [ORKConsentSectionType] = [
        .overview,
        //.dataGathering,
        //.privacy,
        //.dataUse,
        //.timeCommitment,
        //.studySurvey,
        //.studyTasks,
        .withdrawing
    ]
    
    let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        consentSection.summary = "If you wish to complete this study..."
        consentSection.content = "In this study, you will be given a custom test based on your logged commute."
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}

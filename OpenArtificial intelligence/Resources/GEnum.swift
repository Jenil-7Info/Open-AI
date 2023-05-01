//
//  GEnum.swift
//  OpenArtificial intelligence
//
//  Created by SevenInfosystem on 13/01/23.
//

import Foundation

//MARK: - OpenAI Link
enum OpenAILink: String {
    case APIKey = "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"
    case organization = "Iosdev37"
}

//MARK: - Message Owner
enum MessageOwner: String, Codable {
    case me
    case gpt
}

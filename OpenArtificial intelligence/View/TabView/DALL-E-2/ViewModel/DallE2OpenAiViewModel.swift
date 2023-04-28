//
//  DallE2OpenAiViewModel.swift
//  OpenArtificial intelligence
//
//  Created by SevenInfosystem on 13/01/23.
//

import Foundation
import OpenAIKit
import UIKit

final class DallE2OpenAiViewModel: ObservableObject {
    
    private var openAI: OpenAI?
    
    func setUpOpenAI() {
        openAI = OpenAI(Configuration(organization: OpenAILink.organization.rawValue, apiKey: OpenAILink.APIKey.rawValue))
    }
    
    func genrateImage(promate: String) async -> UIImage? {
        guard let openAI = openAI else {
            return nil
        }
        do {
            let paramter = ImageParameters(
                prompt: promate,
                resolution: .medium,
                responseFormat: .base64Json
            )
            let result = try await openAI.createImage(parameters: paramter)
            let data = result.data[0].image
            let image = try openAI.decodeBase64Image(data)
            
            return image
        }
        catch {
            return nil
        }
    }
}

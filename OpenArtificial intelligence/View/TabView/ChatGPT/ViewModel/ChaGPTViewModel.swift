//
//  ChaGPTViewModel.swift
//  OpenArtificial intelligence
//
//  Created by SevenInfosystem on 28/04/23.
//

import Foundation
import ChatGPTSwift

@MainActor
class ChaGPTViewModel : ObservableObject {
    
    private let api = ChatGPTAPI(apiKey: OpenAILink.APIKey.rawValue)
    
    @Published var message: String = ""
    @Published var chatMessage: [ChatMessageModel] = []

    
    func sendMessage() async throws {
        let meMessage = ChatMessageModel(messOwner: .me, text: message)
        chatMessage.append(meMessage)
        
        let gptMessage = ChatMessageModel(messOwner: .gpt, text: "")
        chatMessage.append(gptMessage)
        
        let strme = try await api.sendMessageStream(text: message)
        
        for try await line in strme {
            if let lastMessage = chatMessage.last{
                let newMessage = ChatMessageModel(messOwner: .gpt, text: lastMessage.text + line)
                chatMessage[chatMessage.count - 1] = newMessage
            }
        }
    }
}

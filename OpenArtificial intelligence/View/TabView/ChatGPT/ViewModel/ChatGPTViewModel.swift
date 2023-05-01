//
//  ChaGPTViewModel.swift
//  OpenArtificial intelligence
//
//  Created by SevenInfosystem on 28/04/23.
//

import ChatGPTSwift
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

@MainActor
class ChatGPTViewModel : ObservableObject {

    @Published var message: String = ""
    @Published var chatMessage: [ChatMessageModel] = []
    private var firebaseVM = firebaseViewModel()
    private let api = ChatGPTAPI(apiKey: OpenAILink.APIKey.rawValue)
    
    func sendMessage() async throws {
        let meMessage = ChatMessageModel(messOwner: .me, text: message, timeStamp: Date())
        chatMessage.append(meMessage)
        
        let gptMessage = ChatMessageModel(messOwner: .gpt, text: "", timeStamp: Date())
        chatMessage.append(gptMessage)
    
        
        let strme = try await api.sendMessageStream(text: message)
        
        var messageGroup = [String]()
        
        for try await line in strme {
            
            if let lastMessage = chatMessage.last{
                
                let newMessage = ChatMessageModel(messOwner: .gpt, text: lastMessage.text + line, timeStamp: Date())
                chatMessage[chatMessage.count - 1] = newMessage
                
                messageGroup.append(lastMessage.text)
            }
        }
        
        firebaseVM.addData(message: messageGroup.last ?? "Sorry, no message appened.", messOwner: .gpt)
    }
}

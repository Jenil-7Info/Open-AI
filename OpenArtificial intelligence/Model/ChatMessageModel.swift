//
//  ChatMessageModel.swift
//  OpenArtificial intelligence
//
//  Created by SevenInfosystem on 28/04/23.
//

import SwiftUI
import FirebaseFirestoreSwift

//MARK: - Chat-Message Model
struct ChatMessageModel: Identifiable ,Codable {
    var id : UUID = UUID()
    var messOwner : MessageOwner
    var text : String
    var timeStamp: Date
    
    init(messOwner: MessageOwner, text: String, timeStamp: Date) {
        self.messOwner = messOwner
        self.text = text
        self.timeStamp = timeStamp
    }
}

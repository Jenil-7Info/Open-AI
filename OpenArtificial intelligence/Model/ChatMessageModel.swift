//
//  ChatMessageModel.swift
//  OpenArtificial intelligence
//
//  Created by SevenInfosystem on 28/04/23.
//

import SwiftUI

struct ChatMessageModel: Identifiable {
    
    var id: UUID
    var messOwner : MessageOwner
    var text : String
    
    init(id: UUID = UUID(), messOwner: MessageOwner, text: String) {
        self.id = id
        self.messOwner = messOwner
        self.text = text
    }
}

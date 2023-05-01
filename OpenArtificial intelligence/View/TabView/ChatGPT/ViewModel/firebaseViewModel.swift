//
//  firebaseViewModel.swift
//  OpenArtificial intelligence
//
//  Created by SevenInfosystem on 01/05/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class firebaseViewModel: ObservableObject {
    
    @AppStorage("errMessage") var errMessage: String = ""
    @Published var chatModel = [ChatMessageModel]()
    var db = Firestore.firestore().collection("messages")
    
    func addData(message: String, messOwner: MessageOwner) {
        db.addDocument(data: ["message": message, "messOwner": messOwner.rawValue, "timeStamp": Date()])
    }
    
    func fetchData() {
        db.addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                self.errMessage = error.localizedDescription
                debugPrint("ERROR:= \(error.localizedDescription)")
            }
            
            guard let query = querySnapshot?.documents else {
                self.errMessage = "No Documents"
                debugPrint("ERROR:- No Documents")
                return
            }
            
            self.chatModel = query.compactMap({ queryDocumentSnapshot -> ChatMessageModel in
                
                let data = queryDocumentSnapshot.data()
                let message = data["message"] as! String
                let messOwner = data["messOwner"] as! String
                
                return ChatMessageModel(messOwner: MessageOwner(rawValue: messOwner) ?? .me , text: message, timeStamp: Date())
            })
            
            
            self.chatModel.sort { $0.timeStamp < $1.timeStamp }
        }
    }
    
}

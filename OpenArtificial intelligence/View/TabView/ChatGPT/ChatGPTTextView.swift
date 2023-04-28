//
//  ChatGPTTextView.swift
//  OpenArtificial intelligence
//
//  Created by SevenInfosystem on 28/04/23.
//

import SwiftUI

struct ChatGPTTextView: View {
    
    @StateObject var viewModel = ChaGPTViewModel()
    
    var body: some View {
        VStack {
            
            //MARK: - Heading
            HStack {
                Image("artificial-intelligence")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 10)
                Text("Chat GPT")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding([.top, .leading])
            
            //ScrollView Effect
            ScrollView {
                ForEach(viewModel.chatMessage) { message in
                    messageView(message)
                }
                .rotationEffect(.degrees(180))
            }
            .scrollIndicators(.never)
            .rotationEffect(.degrees(180))
            
            //MARK: - TextFiled
            HStack {
                TextField("Type Here...", text: $viewModel.message)
                    .padding(.horizontal)
                    .autocorrectionDisabled(true)
                    .onSubmit {
                        withAnimation(.spring()) {
                            sendMessage()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                                withAnimation {
                                    viewModel.message = ""
                                }
                            }
                        }
                    }
                
                if viewModel.message.isEmpty {
                    
                    //MARK: - Suggestiong Button
                    Button {
                        viewModel.message = suggsesOfSearchSentances.randomElement() ?? "AI"
                    } label: {
                        Text("Suggestion")
                            .foregroundColor(.red)
                            .padding(.trailing)
                    }
                }
                else {
                    
                    //MARK: - Send Button
                    Button {
                        sendMessage()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                            withAnimation {
                                viewModel.message = ""
                            }
                        }
                    } label: {
                        Text("Send")
                            .padding(.trailing)
                    }
                }
            }
            .frame(width: 360, height: 60)
            .background(.black.opacity(0.05))
            .cornerRadius(25)
            .padding()
        }
    }
    
    //MARK: - Message View function
    func messageView(_ message: ChatMessageModel) -> some View {
        
        HStack {
            
            if message.messOwner == .me {
                withAnimation {
                    Spacer()
                }
            }
         
            if !message.text.isEmpty {
                withAnimation(.spring()) {
                    Text(message.text)
                        .foregroundColor(message.messOwner == .me ? .white : .black)
                        .padding(12)
                        .background(message.messOwner == .me ? .blue : .gray.opacity(0.15))
                        .cornerRadius(15)
                }
            }
            
            if message.messOwner == .gpt {
                withAnimation {
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
    }
    
    //MARK: - Send Message
    func sendMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Task {
                do {
                    try await viewModel.sendMessage()
                }
                catch {
                    debugPrint("ERROR:- \(error.localizedDescription)")
                }
            }
        }
    }
}

struct ChatGPTTextView_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPTTextView()
    }
}
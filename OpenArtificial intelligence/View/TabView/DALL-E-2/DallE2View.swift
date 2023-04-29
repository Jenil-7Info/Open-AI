//
//  DallE2View.swift
//  OpenArtificial intelligence
//
//  Created by SevenInfosystem on 13/01/23.
//

import SwiftUI

struct DallE2View: View {
    
    @State private var text = ""
    @State private var image = UIImage()
    @StateObject var vm = DallE2OpenAiViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HStack {
                    Image("ai")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.trailing, 10)
                    Text("DALL.E.2")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding([.top, .leading])
                
                Spacer()
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                
                Spacer()
                
                HStack {
                    TextField("Type Here...", text: $text)
                        .padding(.horizontal)
                        .autocorrectionDisabled(true)
                        .onSubmit {
                            Task {
                                let result = await vm.genrateImage(promate: text)
                                if result == nil {
                                    print("failed Image!!!")
                                }
                                self.image = result ?? UIImage(systemName: "person.crop.circle")!
                                text = ""
                            }
                        }
                    
                    if text.isEmpty {
                        Button {
                            
                            //NOTE: - Added The Suggestion sentances And Fetch the Array And Assign the text Variables....
                            
                            text = suggsesOfSearchImage.randomElement() ?? "AI"
                        } label: {
                            Text("Suggestion")
                                .foregroundColor(.red)
                                .padding(.trailing)
                        }
                    }
                    else {
                        Button {
                            
                            if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                                Task {
                                    let result = await vm.genrateImage(promate: text)
                                    if result == nil {
                                        print("failed Image!!!")
                                    }
                                    self.image = result ?? UIImage(systemName: "person.crop.circle")!
                                    text = ""
                                }
                            }
                            else {
                                debugPrint("Please try again!!!")
                            }
                            
                        } label: {
                            Text("Send")
                        }
                        .padding(.trailing, 20)
                    }
                }
                .frame(width: 360, height: 60)
                .background(.black.opacity(0.05))
                .cornerRadius(25)
                .padding()
            }
            .onAppear {
                vm.setUpOpenAI()
            }
        }
    }
}

struct DallE2View_Previews: PreviewProvider {
    static var previews: some View {
        DallE2View()
    }
}

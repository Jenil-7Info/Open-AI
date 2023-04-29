//
//  MainView.swift
//  OpenArtificial intelligence
//
//  Created by SevenInfosystem on 13/01/23.
//

import SwiftUI

struct OpenAIRootView: View {
    var body: some View {
        NavigationStack {
            TabView {
                ChatGPTTextView()
                    .tabItem {
                        Text("CHATGPT")
                            .bold()
                            .font(.title)
                    }
                    .tag(0)
                
                DallE2View()
                    .tabItem {
                        Text("DALL.E.2")
                            .bold()
                            .font(.title3)
                    }
                    .tag(1)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        OpenAIRootView()
    }
}

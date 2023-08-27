//
//  ContentView.swift
//  toEPUB
//
//  Created by 虻川景 on 2023/08/27.
//

import SwiftUI

struct Genre: Identifiable {
let id = UUID().uuidString
let name: String
}
final class ViewModel: ObservableObject {
init(genres: [Genre] = ViewModel.defaultGenres) {
self.genres = genres
self.selectedId = genres[0].id
  }
@Published var genres: [Genre]
@Published var selectedId: String?
static let defaultGenres: [Genre] = ["マンガ", "小説"].map({ Genre(name: $0) })
}


struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var name = ""
    @State private var author = ""
    @State private var resolution = ""
    @State private var toc = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.genres) { item in
                    NavigationLink(item.name, tag: item.id, selection: $viewModel.selectedId) {
                        VStack(spacing: 4) {
                            
                            TextField("タイトル", text: $name)
                                .font(.title)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.vertical, 2)
                            TextField("著者", text:  $author)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.vertical, 2)
                            TextField("解像度", text:  $resolution)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.vertical, 2)
                            Button("表紙") {
                                let openPanel = NSOpenPanel()
                                openPanel.prompt = "画像を選択"
                                openPanel.allowsMultipleSelection = false
                                openPanel.canChooseDirectories = false
                                openPanel.canCreateDirectories = false
                                openPanel.canChooseFiles = true
                                openPanel.allowedFileTypes = ["png","jpg","jpeg"]
                                openPanel.begin { (result) -> Void in
                                if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                                        let selectedPath = openPanel.url!.path
                                        print(selectedPath)
                                        }
                                    }
                                }
                            .buttonStyle(PlainButtonStyle())
                                .frame(maxWidth: .infinity,alignment: .leading)
                            
                            Button("画像") {
                                let openPanel = NSOpenPanel()
                                openPanel.prompt = "画像を選択"
                                openPanel.allowsMultipleSelection = true
                                openPanel.canChooseDirectories = false
                                openPanel.canCreateDirectories = false
                                openPanel.canChooseFiles = true
                                openPanel.allowedFileTypes = ["png","jpg","jpeg"]
                                openPanel.begin { (result) -> Void in
                                if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                                        let selectedPath = openPanel.url!.path
                                        print(selectedPath)
                                        }
                                    }
                                }
                            .buttonStyle(PlainButtonStyle())
                                .frame(maxWidth: .infinity,alignment: .leading)
                            DisclosureGroup(
                                content: {
                                    Text("追加する")
                                    .background(Color.blue)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    },
                                    label: {
                                        Text("目次")
                                    }
                                )
                            
                            Spacer()
                        }
                        .padding(.all, 20)
                        
                        .navigationTitle(item.name)
                    }
                }
            }
            .listStyle(.sidebar)
            Text("選択していません")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  ParseCSV
//
//  Created by Allen Norskog on 10/30/23.
//

import SwiftUI

struct ContentView: View {
    @State var image: UIImage?
    let fileName = "slope100"

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            Button {
                let data = CSV.parse(fileName: fileName)
                image = UIImage.colorize(data: data)
            } label: {
                Text("Parse File").padding()
            }
            if image != nil {
                Button {
                    if let data = image?.pngData() {
                        let tmpDir = NSTemporaryDirectory()
                        let fullFileName = "\(tmpDir)moonImage.png"
                        let url = URL(fileURLWithPath: fullFileName)
                        print("file:\(fullFileName)")
                        do {
                            try data.write(to: url, options: .atomic)
                        } catch {
                            print("image file NOT written")
                        }
                    }
                } label: {
                    Text("Save Image").padding()
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/09/27.
//

import SwiftUI

struct ContentView: View {
    
    //scantag here
    @State private var showScannerSheet = false
    @State private var texts:[ScanTag] = []
    
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                
            }
            .navigationTitle("Scan Tag")
            .navigationBarItems(trailing: Button(action: {
                self.showScannerSheet = true
            }, label: {
                Image(systemName: "doc.text.viewfinder")
                    .font(.title)
            })
                .sheet(isPresented: $showScannerSheet, content: {
                    makeScannerView()
                })
            )
        }
    }
    
    private func makeScannerView()-> ScannerView{
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines){
                let newScanData = ScanTag(content: outputText)
                self.texts.append(newScanData)
            }
            self.showScannerSheet = false
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

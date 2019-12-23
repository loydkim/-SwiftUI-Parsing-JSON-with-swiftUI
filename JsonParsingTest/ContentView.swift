//
//  ContentView.swift
//  JsonParsingTest
//
//  Created by YOUNGSIC KIM on 2019-12-20.
//  Copyright © 2019 YOUNGSIC KIM. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @State var dataList: [Simple] = []
    @ObservedObject var userDataLoader:DataLoader = DataLoader(urlString:urlString)
    
    var body: some View {
        VStack {
            Button(action: { self.userDataLoader.getDataFromURL(urlString: urlString) }) {
                Text("Add User List")
                    .font(.largeTitle)
                    .bold()
            }
            List(dataList) { data in
                ContentRow(data: data)
            }.onReceive(userDataLoader.didChange) { data in
                self.dataList.append(userDataToView(data: data))
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dataList: simpleDataList)
    }
}

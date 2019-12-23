//
//  Data.swift
//  JsonParsingTest
//
//  Created by YOUNGSIC KIM on 2019-12-20.
//  Copyright © 2019 YOUNGSIC KIM. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

let urlString = "http://api.randomuser.me/"

func userDataToView(data:Data) -> Simple {
    var addData: Simple = Simple(name: "", thumbnail: "", email: "")
    do {
        // JSON Data to NSDictionary
        let json = try JSONSerialization.jsonObject(with: data) as! NSDictionary
        // Get the result array
        if let resultsArray = json.object(forKey: "results") as? NSArray {
            let resultDictionary: NSDictionary = resultsArray[0] as! NSDictionary
            let loginDictionary: NSDictionary = resultDictionary["login"] as! NSDictionary
            let pictureDictionary: NSDictionary = resultDictionary["picture"] as! NSDictionary
            
            // Now we can get a value from dictionary
            addData.name = (loginDictionary["username"] ?? "Username") as! String
            addData.thumbnail = (pictureDictionary["thumbnail"] ?? "thumbnail") as! String
            addData.email = (resultDictionary["email"] ?? "email") as! String
        }
    } catch {
        fatalError("Couldn't get data error is \(error) ")
    }
    
    return addData
}

struct ImageView: View {
    @ObservedObject var imageLoader:DataLoader
    @State var image:UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = DataLoader(urlString:url)
    }

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:50, height:50)
        }.onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}

class DataLoader: ObservableObject {
    @Published var didChange = PassthroughSubject<Data, Never>()
    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        getDataFromURL(urlString: urlString)
    }
    
    func getDataFromURL(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}


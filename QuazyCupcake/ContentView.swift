//
//  ContentView.swift
//  QuazyCupcake
//
//  Created by PRABALJIT WALIA     on 23/10/20.
//

import SwiftUI

struct Response:Codable{
    var results:[Result]
}
struct Result:Codable{
    var trackId:Int
    var trackName:String
    var collectionName:String
    
}
struct ContentView: View {
    @State private var results = [Result]()
    var body: some View {
        NavigationView{
        List(results,id: \.trackId){item in
            VStack(alignment:.leading){
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
        .navigationTitle("One Direction")
    }
}
    func loadData(){
        //create the url we want to read
        guard let url = URL(string: "https://itunes.apple.com/search?term=one+direction&entity=song") else{
            print("invalid url")
            return
        }
        //create a request with the URL
        let request = URLRequest(url: url)
        
        //create and start a networking task
        URLSession.shared.dataTask(with: request){data,response,error in
            
            //check if we got some data from the api
            if let data = data {
                //decode the data that we have received
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                    //we have good data so, go back to main thread
                    DispatchQueue.main.async {
                        //update our UI
                        self.results = decodedResponse.results
                    }
                    //everything is working so we can exit
                    return
                }
            }
            //if we're here means that their was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  HotelNetworkService.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/15/21.
//

import Foundation

class HotelNetworkService {
            
    func searchHotels(_ item: BucKitItem, adults: String, checkinDate: String, checkoutDate: String, completion: @escaping (Result<[HotelResult], Error>) -> Void) {
        let baseURL = "https://hotels-com-provider.p.rapidapi.com/v1/hotels/nearby"
        guard var urlComp = URLComponents(string: baseURL) else {return}
        let lat = String(item.latitude)
        let long = String(item.longitude)
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "locale", value: "en_US"),
            URLQueryItem(name: "adults_number", value: adults),
            URLQueryItem(name: "sort_order", value: "STAR_RATING_HIGHEST_FIRST"),
            URLQueryItem(name: "checkin_date", value: checkinDate),
            URLQueryItem(name: "checkout_date", value: checkoutDate),
            URLQueryItem(name: "longitude", value: long),
            URLQueryItem(name: "latitude", value: lat),
            URLQueryItem(name: "currency", value: "USD")
        ]
        urlComp.queryItems = queryItems
        let session = URLSession.shared.dataTask(with: urlComp.url!) { (data, response, error) in
            if let error = error {
                print(error)
                completion(.failure(error))
            } else if let data = data {
                let decoder = JSONDecoder()
                let results = try? decoder.decode(SearchResults.self, from: data)
                completion(.success(results?.results.hotels ?? []))
            }
        }
        session.resume()
    }
}

//
//  HotelNetworkService.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/15/21.
//

import Foundation

class HotelNetworkService {
            
    func searchHotels(_ item: BucKitItem, adults: String, checkinDate: Date, checkoutDate: Date, completion: @escaping (Result<[HotelResult], Error>) -> Void) {
        let baseURL = "https://hotels-com-provider.p.rapidapi.com/v1/hotels/nearby"
        let checkinDate = stringDate(date: checkinDate)
        let checkoutDate = stringDate(date: checkoutDate)
        let headerKey = "x-rapidapi-key"
        let key = "ae38a128fbmsh272f961ad7e71ecp1fa023jsn85d8c8ca253b"
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
        
        var request = URLRequest(url: urlComp.url!)
        request.addValue(key, forHTTPHeaderField: headerKey)
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                completion(.failure(error))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let results = try decoder.decode(SearchResults.self, from: data)
                    completion(.success(results.searchResults.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        session.resume()
    }
    
    func stringDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
}

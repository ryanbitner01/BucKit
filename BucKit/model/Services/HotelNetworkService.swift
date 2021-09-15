//
//  HotelNetworkService.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/15/21.
//

import Foundation

class HotelNetworkService {
    func searchHotels(_ item: BucKitItem, completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared.dataTask(with: <#T##URL#>)
    }
}

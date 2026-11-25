//
//  StationList.swift
//  TravelShedule
//
//  Created by Антон on 25.11.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias AllStationsResponse = Components.Schemas.AllStationsResponse

protocol StationsListServiceProtocol {
    func getAllStations() async throws -> AllStationsResponse
}

final class StationsListService: StationsListServiceProtocol {

    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getAllStations() async throws -> AllStationsResponse {
        let response = try await client.getAllStations(query: .init(
            apikey: apikey
        ))

        let responseBody = try response.ok.body.text_html_charset_utf_hyphen_8

        let limit = 50 * 1024 * 1024
        let fullData = try await Data(collecting: responseBody, upTo: limit)

        let allStations = try JSONDecoder().decode(
            AllStationsResponse.self,
            from: fullData
        )

        return allStations
    }
}

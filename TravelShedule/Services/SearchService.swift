//
//  SearchService.swift
//  TravelShedule
//
//  Created by Антон on 25.11.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Segments = Components.Schemas.Segments

protocol SearchServiceProtocol {
    func getSegments(from: String, to: String) async throws -> Segments
}

final class SearchService: SearchServiceProtocol {

    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getSegments(from: String, to: String) async throws -> Segments {
        let response = try await client.getSchedualBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to
        ))

        return try response.ok.body.json
    }
}


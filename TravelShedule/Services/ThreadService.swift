//
//  ThreadService.swift
//  TravelShedule
//
//  Created by Антон on 25.11.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias ThreadStationsResponse = Components.Schemas.ThreadStationsResponse

protocol ThreadServiceProtocol {
    func getRouteStations(uid: String) async throws -> ThreadStationsResponse
}

final class ThreadService: ThreadServiceProtocol {

    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getRouteStations(uid: String) async throws -> ThreadStationsResponse {
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: uid
        ))

        return try response.ok.body.json
    }
}

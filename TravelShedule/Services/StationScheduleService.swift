//
//  StationScheduleService.swift
//  TravelShedule
//
//  Created by Антон on 25.11.2026.
//


import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleResponse = Components.Schemas.ScheduleResponse

protocol StationScheduleServiceProtocol {
    func getStationSchedule(station: String) async throws -> ScheduleResponse
}

final class StationScheduleService: StationScheduleServiceProtocol {

    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getStationSchedule(station: String) async throws -> ScheduleResponse {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station
        ))

        return try response.ok.body.json
    }
}

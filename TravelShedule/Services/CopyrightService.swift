//
//  CopyrightService.swift
//  TravelShedule
//
//  Created by Антон on 25.11.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.CopyrightResponse
protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let api: String
    
    init(client: Client, api: String){
        self.api = api
        self.client = client
    }
    
    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyright(query: .init(
            apikey: api
        ))
        return try response.ok.body.json
    }
}

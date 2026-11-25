//
//  NearestStationsService.swift
//  TravelShedule
//
//  Created by Антон on 25.11.2026.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestStations = Components.Schemas.Stations

protocol NearestStationsServiceProtocol {
    /// Функция для получения станций, асинхронная и может выбросить ошибку
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

final class NearestStationsService: NearestStationsServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,    
            lat: lat,
            lng: lng,
            distance: distance
        ))
        /// response.ok: Доступ к успешному ответу
        /// .body: Получаем тело ответа
        /// .json: Получаем объект из JSON в ожидаемом типе NearestStations
        return try response.ok.body.json
    }
}

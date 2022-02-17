//
//  SoftwareModel.swift
//  ibm
//
//  Created by Amit Jain on 2/14/22.
//

import Foundation

// MARK: - Result
struct Result : Decodable  {
    let resultCount: Int
    let results: [SoftwareModel]
}

// MARK: - SoftwareModel
struct SoftwareModel: Decodable {
    let ipadScreenshotUrls: [String]
    let appletvScreenshotUrls: [String?]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let artistViewURL: String?
    let screenshotUrls: [String]
    let features, supportedDevices: [String]
    let advisories: [String?]
    let isGameCenterEnabled: Bool
    let kind, minimumOSVersion, trackCensoredName: String?
    let languageCodesISO2A: [String]
    let fileSizeBytes: String?
    let sellerURL: String?
    let formattedPrice, contentAdvisoryRating: String?
    let averageUserRatingForCurrentVersion: Double
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Double
    let trackViewURL: String?
    let trackContentRating: String
    let releaseDate: Date?
    let bundleId, primaryGenreName: String
    let genreIds: [String]
    let trackId: Int
    let trackName: String
    let isVppDeviceBasedLicensingEnabled: Bool
    let currentVersionReleaseDate: Date?
    let sellerName, releaseNotes: String?
    let primaryGenreId: Int
    let currency, resultDescription: String?
    let artistId: Int
    let artistName: String
    let genres: [String]
    let price: Double?
    let version, wrapperType: String
    let userRatingCount: Int
}

//jul 9 15.06
import Foundation


struct Meeting: Codable, Identifiable {
    var id: String
    var title: String
    var location: String
    var date: Date
    var managerId: String
    var driverId: String
    var notes: String
    
}

/*
 example JSON
"id": "1",
"title": "Günlük Stand-up",
"location": "Merkez Ofis",
"date": "2024-07-08T09:00:00Z",
"managerId": "1",
"driverId": "2",
"notes": "Günlük takım toplantısı"
*/

import Foundation
//jul 9 15.06
let mockMeetingsJSON = """
{
  "meetings": [
    {
      "id": "1",
      "title": "Günlük Stand-up",
      "location": "Merkez Ofis",
      "date": "2024-07-08T09:00:00Z",
      "managerId": "1",
      "driverId": "2",
      "notes": "Günlük takım toplantısı"
    },
    {
      "id": "2",
      "title": "Müşteri Toplantısı",
      "location": "Dış Lokasyon",
      "date": "2024-07-08T11:00:00Z",
      "managerId": "1",
      "driverId": "2",
      "notes": "Müşteriyle proje görüşmesi"
    }
  ]
}
""".data(using: .utf8)


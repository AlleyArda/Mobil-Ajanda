import Foundation

let mockMeetingsJSON = """
{
  "meetings": [
    {
      "id": "1",
      "title": "Günlük Stand-up",
      "location": "Merkez Ofis",
      "date": "2024-07-12T09:00:00Z",
      "managerId": "1",
      "driverId": "2",
      "notes": "Günlük takım toplantısı",
      "latitude": 41.015137,
      "longitude": 28.979530
    },
    {
      "id": "2",
      "title": "Müşteri Toplantısı",
      "location": "Dış Lokasyon",
      "date": "2024-07-13T11:00:00Z",
      "managerId": "1",
      "driverId": "2",
      "notes": "Müşteriyle proje görüşmesi",
      "latitude": 40.712776,
      "longitude": -74.005974
    },
    {
      "id": "3",
      "title": "Proje Planlama",
      "location": "Merkez Ofis",
      "date": "2024-07-12T10:00:00Z",
      "managerId": "1",
      "driverId": "5",
      "notes": "Yeni proje planlama toplantısı",
      "latitude": 41.015137,
      "longitude": 28.979530
    },
    {
      "id": "4",
      "title": "Güvenlik Eğitimi",
      "location": "Eğitim Salonu",
      "date": "2024-07-15T13:00:00Z",
      "managerId": "1",
      "driverId": "2",
      "notes": "Güvenlik personeli eğitimi",
      "latitude": 41.008237,
      "longitude": 28.978358
    },
    {
      "id": "5",
      "title": "Yıllık Değerlendirme",
      "location": "Toplantı Odası 2",
      "date": "2024-07-15T15:00:00Z",
      "managerId": "1",
      "driverId": "8",
      "notes": "Yılın değerlendirilmesi",
      "latitude": 41.013843,
      "longitude": 28.950274
    },
    {
      "id": "6",
      "title": "Strateji Toplantısı",
      "location": "Merkez Ofis",
      "date": "2024-07-16T09:00:00Z",
      "managerId": "1",
      "driverId": "2",
      "notes": "Şirket stratejisi belirleme",
      "latitude": 41.015137,
      "longitude": 28.979530
    },
    {
      "id": "7",
      "title": "Tedarikçi Görüşmesi",
      "location": "Dış Lokasyon",
      "date": "2024-07-17T11:00:00Z",
      "managerId": "1",
      "driverId": "2",
      "notes": "Yeni tedarikçi görüşmesi",
      "latitude": 40.730610,
      "longitude": -73.935242
    },
    {
      "id": "8",
      "title": "Takım Toplantısı",
      "location": "Merkez Ofis",
      "date": "2024-07-14T10:00:00Z",
      "managerId": "1",
      "driverId": "5",
      "notes": "Takım üyeleriyle aylık toplantı",
      "latitude": 41.015137,
      "longitude": 28.979530
    },
    {
      "id": "9",
      "title": "Proje Sunumu",
      "location": "Toplantı Odası 1",
      "date": "2024-07-15T13:00:00Z",
      "managerId": "7",
      "driverId": "8",
      "notes": "Proje ilerleme sunumu",
      "latitude": 41.012751,
      "longitude": 28.977196
    },
    {
      "id": "10",
      "title": "Personel Toplantısı",
      "location": "Eğitim Salonu",
      "date": "2024-07-16T15:00:00Z",
      "managerId": "10",
      "driverId": "2",
      "notes": "Personel sorunları ve öneriler",
      "latitude": 41.008237,
      "longitude": 28.978358
    }
  ]
}
""".data(using: .utf8)

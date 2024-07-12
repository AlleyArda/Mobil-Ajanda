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
      "notes": "Günlük takım toplantısı"
    },
    {
      "id": "2",
      "title": "Müşteri Toplantısı",
      "location": "Dış Lokasyon",
      "date": "2024-07-13T11:00:00Z",
      "managerId": "1",
      "driverId": "2",
      "notes": "Müşteriyle proje görüşmesi"
    },
    {
      "id": "3",
      "title": "Proje Planlama",
      "location": "Merkez Ofis",
      "date": "2024-07-12T10:00:00Z",
      "managerId": "1",
      "driverId": "5",
      "notes": "Yeni proje planlama toplantısı"
    },
    {
      "id": "4",
      "title": "Güvenlik Eğitimi",
      "location": "Eğitim Salonu",
      "date": "2024-07-15T13:00:00Z",
      "managerId": "1",
      "driverId": "2",
      "notes": "Güvenlik personeli eğitimi"
    },
    {
      "id": "5",
      "title": "Yıllık Değerlendirme",
      "location": "Toplantı Odası 2",
      "date": "2024-07-15T15:00:00Z",
      "managerId": "1",
      "driverId": "8",
      "notes": "Yılın değerlendirilmesi"
    },
    {
      "id": "6",
      "title": "Strateji Toplantısı",
      "location": "Merkez Ofis",
      "date": "2024-07-16T09:00:00Z",
      "managerId": "1",
      "driverId": "2",
      "notes": "Şirket stratejisi belirleme"
    },
    {
      "id": "7",
      "title": "Tedarikçi Görüşmesi",
      "location": "Dış Lokasyon",
      "date": "2024-07-15T11:00:00Z",
      "managerId": "1",
      "driverId": "2",
      "notes": "Yeni tedarikçi görüşmesi"
    },
    {
      "id": "8",
      "title": "Takım Toplantısı",
      "location": "Merkez Ofis",
      "date": "2024-07-14T10:00:00Z",
      "managerId": "1",
      "driverId": "5",
      "notes": "Takım üyeleriyle aylık toplantı"
    },
    {
      "id": "9",
      "title": "Proje Sunumu",
      "location": "Toplantı Odası 1",
      "date": "2024-07-15T13:00:00Z",
      "managerId": "7",
      "driverId": "8",
      "notes": "Proje ilerleme sunumu"
    },
    {
      "id": "10",
      "title": "Personel Toplantısı",
      "location": "Eğitim Salonu",
      "date": "2024-07-16T15:00:00Z",
      "managerId": "10",
      "driverId": "2",
      "notes": "Personel sorunları ve öneriler"
    }
  ]
}
""".data(using: .utf8)

import Foundation
//jul 9 15.06
let mockUsersJSON = """
{
  "users": [
    {
      "id": "1",
      "name": "Ali Arda Kulaksız",
      "email": "arda.kulaksiz@tedas.gov.tr",
      "password": "123456",
      "role": "manager"
    },
    {
      "id": "2",
      "name": "Mehmet Kaya",
      "email": "mehmet.kaya@tedas.gov.tr",
      "password": "1",
      "role": "driver"
    },
    {
      "id": "3",
      "name": "Ayşe Demir",
      "email": "ayse.demir@example.com",
      "password": "password123",
      "role": "securityChief"
    }
  ]
}
""".data(using: .utf8)!



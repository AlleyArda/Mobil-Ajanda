import Foundation


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
    },
    {
      "id": "4",
      "name": "Fatma Yılmaz",
      "email": "fatma.yilmaz@tedas.gov.tr",
      "password": "qwerty",
      "role": "manager"
    },
    {
      "id": "5",
      "name": "Ahmet Çelik",
      "email": "ahmet.celik@tedas.gov.tr",
      "password": "password",
      "role": "driver"
    },
    {
      "id": "6",
      "name": "Emine Şahin",
      "email": "emine.sahin@tedas.gov.tr",
      "password": "987654",
      "role": "securityChief"
    },
    {
      "id": "7",
      "name": "Mustafa Aydın",
      "email": "mustafa.aydin@tedas.gov.tr",
      "password": "aydin123",
      "role": "manager"
    },
    {
      "id": "8",
      "name": "Zeynep Kılıç",
      "email": "zeynep.kilic@tedas.gov.tr",
      "password": "kilic987",
      "role": "driver"
    },
    {
      "id": "9",
      "name": "Hüseyin Demirtaş",
      "email": "huseyin.demirtas@tedas.gov.tr",
      "password": "demirtas321",
      "role": "securityChief"
    },
    {
      "id": "10",
      "name": "Elif Özdemir",
      "email": "elif.ozdemir@tedas.gov.tr",
      "password": "ozdemir456",
      "role": "manager"
    }
  ]
}
""".data(using: .utf8)!

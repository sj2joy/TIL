import UIKit

struct Dog: Codable{
    let name: String
    let age: Int
}

//let jsonData = """
//{
//    "person":[
//             {
//               "name": "Bob",
//               "age": "16",
//               "employed": "No"
//             },
//             {
//               "name": "Vinny",
//               "age": "56",
//               "employed": "Yes"
//          ]
//        }
//""".data(using: .utf8)!
let jsonData = """
  {
    "name": "Tory",
    "age": 3,
  }
  """.data(using: .utf8)!
print(jsonData)

extension Dog {
    init?(from json: [String:Any]) {
        guard let name = json["name"] as? String,
            let age = json["age"] as? Int
            else { return nil }
        self.name = name
        self.age = age
    }
}
if let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
    if let dog = Dog(from: jsonObject) {
        print("Serialization :", dog)
    }
}
if let dog = try? JSONDecoder().decode(Dog.self, from: jsonData) {
    print("Decoder: ", dog)
}
let jsonArrData = """
[
  { "name": "Tory", "age": 3 },
  { "name": "Tory", "age": 3 },
]
""".data(using: .utf8)!
if let dogs = try? JSONDecoder().decode([Dog].self, from: jsonArrData) {
    dogs.forEach {
        print("Json Arr Decoder: ", $0)
    }
}
//MARK: - 2ndPractice

let jsonData2 = """
{
  "user_name": "James",
  "user_email": "abc@xyz.com",
  "gender": "male",
  "age" : 5,
}
""".data(using: .utf8)!


struct User: Codable { //_가 들어가서 이름이 달라짐, user_name , let name 차이
    let name: String
    let email: String
    let gender: String
    let age : Int
    
    private enum CodingKeys: String, CodingKey { //age 처럼 다른타입이 와도 ㄱㅊ(age자체는 string으로 같으므로)
        case name = "user_name" //이름이 다르기때문에 여기서 한번더 바꿔줌
        case email = "user_email"
        case gender
        case age
    }
}
print(jsonData2)
let decoder = JSONDecoder()
let user = try decoder.decode(User.self, from: jsonData2)
print(user)

//MARK: - 3rd Practice

let jsonData3 = """
{
  "message": "success",
  "number": 3,
  "people": [
    { "craft": "ISS", "name": "Anton Shkaplerov" },
    { "craft": "ISS", "name": "Scott Tingle" },
    { "craft": "ISS", "name": "Norishige Kanai" },
  ]
}
""".data(using: .utf8)!

struct Astronauts: Codable {
    let message: String
    let number: Int
    let people: [Person]
    
    struct Person: Codable{
        let name: String
    }
}

do {
    let astronauts = try JSONDecoder().decode(Astronauts.self, from: jsonData3)
    astronauts.people.forEach {
        print($0)
    }
} catch {
    print(error.localizedDescription)
}

//MARK: - 4th Practice
let jsonData4 = """
[
{
  "latitude": 30.0,
  "longitude": 40.0,
  "additionalInfo": {
    "elevation": 50.0,
  }
},
{
  "latitude": 60.0,
  "longitude": 120.0,
  "additionalInfo": {
    "elevation": 20.0
  }
}
]
""".data(using: .utf8)!

struct Coordinate {
    var latitude: Double
    var longitude: Double
    var elevation: Double
    
    enum CodingKeys: String, CodingKey {
      case latitude
      case longitude
      case additionalInfo
    }
    
    enum AdditionalInfoKeys: String, CodingKey {
        case elevation
    }
}

extension Coordinate: Decodable {
  init(from decoder: Decoder) throws {
    //throws가 사용된 경우 try만 써도 됨, 없을 경우 do catch사용해서 try써야함
    let values = try decoder.container(keyedBy: CodingKeys.self)
    latitude = try values.decode(Double.self, forKey: .latitude)
    longitude = try values.decode(Double.self, forKey: .longitude)

    let additionalInfo = try values.nestedContainer(
      keyedBy: AdditionalInfoKeys.self,
      forKey: .additionalInfo
    )
    elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
  }
}

extension Coordinate: Encodable {
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(latitude, forKey: .latitude)
    try container.encode(longitude, forKey: .longitude)

    var additionalInfo = container.nestedContainer(
      keyedBy: AdditionalInfoKeys.self,
      forKey: .additionalInfo
    )
    try additionalInfo.encode(elevation, forKey: .elevation)
  }
}


do {
  let coordinates = try JSONDecoder().decode([Coordinate].self, from: jsonData4)
  coordinates.forEach { print($0) }
} catch {
  print(error.localizedDescription)
}

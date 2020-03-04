/// 사람의 주소 정보 표현 설계
class Room{
    var number: Int
    
    init(number: Int){
        self.number = number
    }
}

class Building{
    var name: String
    var room: Room?
    
    init(name: String){
        self.name = name
    }
}

struct Address{
    var province: String
    var city: String
    var street: String
    var building: Building?
    var detailAddress: String?
}

class Person{
    var name: String
    var address: Address?
    
    init(name: String) {
        self.name = name
    }
}


/// 옵셔널 체이닝 문법
//let wimes: Person = Person(name: "wimes")
//let wimesRoomViaOptionalChaning: Int? = wimes.address?.building?.room?.number // nil
//let wimesRoomViaOptionalUnwraping: Int = wimes.address!.building!.room!.number // error


///옵셔널 바인딩의 사용
let wimes: Person = Person(name: "wimes")

if let roomNumber: Int = wimes.address?.building?.room?.number{
    print(roomNumber)
}else{
    print("can not find room number")
}


///옵셔널 체이닝을 통한 서브스크립트 호출
let optionalArray: [Int]? = [1,2,3]
print(optionalArray?[1]) //Optional(2)

var optionalDictionary: [String: [Int]]? = [String: [Int]]()
optionalDictionary?["numberArray"] = optionalArray
print(optionalDictionary?["numberArray"]?[2]) //Optional(3)


///guard구문의 옵션널 바인딩 활용
func greet(_ person: [String: String]){
    guard let name: String = person["name"] else {
        return
    }
    
    print("Hello \(name)")
    
    guard let location: String = person["location"] else {
        print("I hope the weather is nice near you")
        return
    }
    
    print("I hope the weather is nice in \(location)")
}

var personInfo: [String: String] = [String: String]()
personInfo["name"] = "Jenny"

greet(personInfo)
//Hello Jenny
//I hope the weather is nice near you

personInfo["location"] = "Korea"

greet(personInfo)
//Hello Jenny
//I hope the weather is nice in Korea


///guard구문에 구체적인 조건을 추가
func enterClub(name: String?, age: Int?){
    guard let name: String = name, let age: Int = age, age > 19, name.isEmpty == false else {
        print("You are too young to enter the club.")
        return
    }
    
    print("Welcome \(name)!")
}

enterClub(name: "wimes", age: 10) //You are too young to enter the club.
enterClub(name: "wimes", age: 20) //Welcome wimes!

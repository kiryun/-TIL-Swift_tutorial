//var person: (String, Int, Double) = ("wimes", 100, 182.5)
//
//person.1 = 99


var person: (name: String, age: Int, height: Double) = ("wimes", 100, 182.5)

person.age = 99
person.2 = 178.5


typealias PersonTuple = (name: String, age: Int, heigth: Double)

let wimes: PersonTuple = ("wimes", 100, 175.6)
let eric: PersonTuple = ("eric", 150, 183.5)


typealias StringIntDictionary = [String: Int]

var numberForName: Dictionary<String, Int> = Dictionary<String, Int>()


///Coffee 클래스와 Coffee클래스를 상속받은 Latte와 Americano  클래스
class Coffee{
    let name: String
    let shot: Int
    
    var description: String{
        return "\(shot) shot(s) \(name)"
    }
    
    init(shot: Int) {
        self.shot = shot
        self.name = "coffee"
    }
}

class Latte: Coffee{
    var flavor: String
    
    override var description: String{
        return "\(shot) shot(s) \(flavor) latte"
    }
    
    init(flavor: String, shot: Int) {
        self.flavor = flavor
        super.init(shot: shot)
    }
}

class Americcano: Coffee{
    let iced: Bool
    
    override var description: String{
        return "\(shot) shot(s) \(iced ? "iced" : "hot") americano"
    }
    
    init(shot: Int, iced: Bool) {
        self.iced = iced
        super.init(shot: shot)
    }
    
}


/// 데이터 타입확인
let coffee: Coffee = Coffee(shot: 1)
print(coffee.description) // 1 shot(s) coffee

let myCoffee: Americcano = Americcano(shot: 2, iced: false)
print(myCoffee.description) // 2 shot(s) hot americano

let yourCoffee: Latte = Latte(flavor: "green tea", shot: 3)
print(yourCoffee.description) // 3 shot(s) green tea latte

print(coffee is Coffee) // true
print(coffee is Americcano) // false
print(coffee is Latte) // false

print(myCoffee is Coffee) // true
print(yourCoffee is Coffee) // true

print(myCoffee is Latte) // false
print(yourCoffee is Latte) // true


///Latte타입의 인스턴스를 참조하는 Coffee타입 actingConstant 상수
let actingConstant: Coffee = Latte(flavor: "vanilla", shot: 2)
print(actingConstant.description) // 2 shot(s) vanilla latte

 
///다운캐스팅
if let actingOne: Americcano = coffee as? Americcano{
    print("This is Americano")
}else{
    print(coffee.description)
}
// 1 shot(s) coffee

if let actingOne: Latte = coffee as? Latte{
    print("This is Latte")
}else{
    print(coffee.description)
}
// 1 shot(s) coffee

if let actingOne: Coffee = coffee as? Coffee{
    print("This is just Coffee")
}else{
    print(coffee.description)
}
// This is just Coffee

if let actingOne: Americcano = myCoffee as? Americcano{
    print("This is Americano")
}else{
    print(coffee.description)
}
// This is Americano

if let actingOne: Latte = myCoffee as? Latte{
    print("This is Latte")
}else{
    print(coffee.description)
}
// 1 shot(s) coffee

if let actingOne: Coffee = myCoffee as? Coffee{
    print("This is just coffee")
}else{
    print(coffee.description)
}
// This is just coffee

//let castedCoffee: Coffee = yourCoffee as! Coffee
//let castedAmericano: Americcano = coffee as! Americcano // error!


/// 항상 성공하는 다운캐스팅
let castedCoffee: Coffee = yourCoffee as Coffee


///AnyObejct의 타입캐스팅
func castTypeToAppropriate(item: AnyObject){
    if let castedItem: Latte = item as? Latte{
        print(castedItem.description)
    }else if let castedItem: Americcano = item as? Americcano{
        print(castedItem.description)
    }else if let castedItem: Coffee = item as? Coffee{
        print(castedItem.description)
    }else{
        print("Inknown Type")
    }
}

castTypeToAppropriate(item: coffee) // 1 shot(s) coffee
castTypeToAppropriate(item: myCoffee) // 2 shot(s) hot americano
castTypeToAppropriate(item: yourCoffee) // 3 shot(s) green tea latte
castTypeToAppropriate(item: actingConstant) // 2 shot(s) vanilla latte


///Any의 타입캐스팅
func checkAnyType(of item: Any){
    switch item {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let latte as Latte:
        print(latte.description)
    case let stringConverter as (String) -> String:
        print(stringConverter("wimes"))
    default:
        print("something else: \(type(of: item))")
    }
}

checkAnyType(of: 0) // zero as an Int
checkAnyType(of: 0.0) // zero as a Double
checkAnyType(of: 42) // an integer value of 42
checkAnyType(of: 3.14159) // a positive double value of 3.14159
checkAnyType(of: -0.25) // some other double value that I don't want to print
checkAnyType(of: "hello") // a string value of "hello"
checkAnyType(of: (3.0, 5.0)) // an (x, y) point at 3.0, 5.0
checkAnyType(of: yourCoffee) // 3 shot(s) green tea latte
checkAnyType(of: coffee) // something else: Coffee
checkAnyType(of: { (name: String) -> String in
    "Hello, \(name)"
}) // Hello, wimes

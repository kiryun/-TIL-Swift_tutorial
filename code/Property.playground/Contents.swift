///저장 프로퍼티의 선언 및 인스턴스 생성
//struct CoordinatePoint{
//    var x: Int // 저장 프로퍼티
//    var y: Int // 저장 프로퍼티
//}
//
//// 구조체에는 기본저긍로 저장 프로퍼티를 매개변수로 갖는 이니셜라이저가 있습니다.
//let wimesPoint: CoordinatePoint = CoordinatePoint(x: 10, y: 5)
//
//// 사람의 위치 정보
//class Position{
//    var point: CoordinatePoint
//    // 저장 프로퍼티(변수) - 위치(point)는 변경될 수 있음을 뜻합니다.
//    let name: String
//    // 저장 프로퍼티(상수)
//
//    init(name: String, currentPoint: CoordinatePoint) {
//        self.name = name
//        self.point = currentPoint
//    }
//}
//
//// 사용자 정의 이니셜라이절르 호출해야만 합니다
//// 그렇지 않으면 프로퍼티 초기값을 할당할 수 없기때문에 인스턴스 생성이 불가능합니다.
//let wimesPosition: Position = Position(name: "wimes", currentPoint: wimesPoint)


///옵셔널 저장 프로퍼티
////좌표
//struct CoordinatePoint{
//    // 위치는 x,y값이 모두 있어야 하므로 옵셔널이면 안 됩니다.
//    var x: Int
//    var y: Int
//}
//
//// 사람의 위치 정보
//class Position{
//    // 현재 사람의 위치를 모를 수도 있습니다. - 옵셔널
//    var point: CoordinatePoint?
//
//    let name: String
//
//    init(name: String) {
//        self.name = name
//    }
//}
//
//// 이름은 필수지만 위치는 모를수 있습니다.
//let wimesPosition: Position = Position(name: "wimes")
//
//// 위치를 알게되면 그 때 위치 값을 할당해 줍니다.
//wimesPosition.point = CoordinatePoint(x: 20, y: 10)


///지연 저장 프로퍼티
//struct CoordinatePoint{
//    var x: Int = 0
//    var y: Int = 0
//}
//
//class Position{
//    lazy var point: CoordinatePoint = CoordinatePoint()
//    let name: String
//
//    init(name: String) {
//        self.name = name
//    }
//}
//
//let wimesPosistion: Position = Position(name: "wimes")
//
//// 이 코드를 통해 point 프로퍼티로 처음 접근할 때
//// point 프로퍼티의 CoordinatePoint가 생성됩니다.
//print(wimesPosistion.point) // CoordinatePoint(x: 0, y: 0)


///연산 프로퍼티의 정의와 사용
struct CoordinatePoint{
    var x: Int
    var y: Int
    
    // 대칭 좌표
    var oppositePoint: CoordinatePoint{
        // 접근자
        get{
            return CoordinatePoint(x: -x, y: -y)
        }
        set(opposite){
            x = -opposite.x
            y = -opposite.y
        }
        // 위의 set(opposite)와 같은 내용 관용적으로 매개변수를 생략하고 newValue를 사용가능
//        set{
//            x = -newValue.x
//            y = -newValue.y
//        }
    }
}

var wimesPosition: CoordinatePoint = CoordinatePoint(x: 10, y: 20)

// 현재 좌표
print(wimesPosition) // CoordinatePoint(x: 10, y: 20)

// 대칭 좌표
print(wimesPosition.oppositePoint) // CoordinatePoint(x: -10, y: -20)

// 대칭 좌표를 (14, 10)으로 설정하면
wimesPosition.oppositePoint = CoordinatePoint(x: 14, y: 10)

// 현재 좌표는 -14, -10으로 설정됩니다.
print(wimesPosition) // CoordinatePoint(x: -14, y: -10)


///프로퍼티 감시자
//class Account{
//    var credit: Int = 0{
//        willSet{
//            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
//        }
//        didSet{
//            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
//        }
//    }
//}
//
//let myAccount: Account = Account()
//
//// 잔액이 0원에서 1000원으로 변경될 예정입니다.
//myAccount.credit = 1000
//// 잔액이 0원에서 1000원으로 변경되었습니다.


///상속받은 연산 프로퍼티의 프로퍼티 감시자 구현
class Account{
    var credit: Int = 0{
        willSet{
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        didSet{
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
        }
    }
    
    var dollarValue: Double{
        get{
            return Double(credit) / 1000.0
        }
        set{
            credit = Int(newValue * 1000)
            print("잔액을 \(newValue)달러로 변경 중입니다.")
        }
    }
}

// 상속
class ForeignAccount: Account{
    override var dollarValue: Double{
        willSet{
            print("잔액이 \(dollarValue)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        
        didSet{
            print("잔액이 \(oldValue)원에서 \(dollarValue)원으로 변경되었습니다.")
        }
    }
}

let myAccount: ForeignAccount = ForeignAccount()

// 잔액이 0원에서 1000원으로 변경될 예정입니다. Account.credit.willSet
myAccount.credit = 1000
// 잔액이 0원에서 1000원으로 변경되었습니다. Account.credit.didSet

// 잔액이 1.0원에서 2.0원으로 변경될 예정입니다.
// 잔액이 1000원에서 2000원으로 변경될 예정입니다.
// 잔액이 1000원에서 2000원으로 변경되었습니다.
// 잔액을 2.0달러로 변경 중입니다.
myAccount.dollarValue = 2
// 잔액이 1.0원에서 2.0원으로 변경되었습니다.


///타입 프로퍼티와 인스턴스 프로퍼티
//class AClass{
//    //저장 타입 프로퍼티
//    static var typeProperty: Int = 0
//
//    // 저장 인스턴스 프로퍼티
//    var instanceProperty: Int = 0{
//        didSet{
//            //Self.typeProperty는
//            //AClass.typeProperty와 같은 표현입니다.
//            Self.typeProperty = instanceProperty + 100
//        }
//    }
//
//    // 연산 타입 프로퍼티
//    static var typeComputedProperty: Int{
//        get{
//            return typeProperty
//        }
//
//        set{
//            typeProperty = newValue
//        }
//    }
//}
//
//AClass.typeProperty = 123
//
//let classInstance: AClass = AClass()
//classInstance.instanceProperty = 100
//
//print(AClass.typeProperty) // 200
//print(AClass.typeComputedProperty) // 200


///키 경로 타입의 타입 확인
//class Person{
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//}
//
//struct Stuff{
//    var name: String
//    var owner: Person
//}

//print(type(of: \Person.name)) // ReferenceWritableKeyPath<Person, String>
//print(type(of: \Stuff.name)) // WritableKeyPath<Stuff, String>
//
//let keyPath = \Stuff.owner
//let nameKeyPath = keyPath.appending(path: \.name)


///keyPath 서브스크립트와 키 경로 활용
class Person{
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Stuff{
    var name: String
    var owner: Person
}

let wimes = Person(name: "wimes")
let hana = Person(name: "hana")
let macbook = Stuff(name: "MacBook Pro", owner: wimes)
var iMac = Stuff(name: "iMac", owner: wimes)
let iPhone = Stuff(name: "iPhone", owner: hana)

let stuffNameKeyPath = \Stuff.name
let ownerKeyPath = \Stuff.owner

// \Stuff.owner.name과 같은 표현
let ownerNameKeyPath = ownerKeyPath.appending(path: \.name)

// 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 가져옵니다.
print(macbook[keyPath: stuffNameKeyPath]) // MacBook Pro
print(iMac[keyPath: stuffNameKeyPath]) // iMac
print(iPhone[keyPath: stuffNameKeyPath]) // iPhone

print(macbook[keyPath: ownerNameKeyPath]) // wimes
print(iMac[keyPath: ownerNameKeyPath]) // wimes
print(iPhone[keyPath: ownerNameKeyPath]) // hana

// 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 변경
iMac[keyPath: stuffNameKeyPath] = "iMac Pro"
iMac[keyPath: ownerKeyPath] = hana

print(iMac[keyPath: stuffNameKeyPath]) // iMac Pro
print(iMac[keyPath: ownerNameKeyPath]) // hana

// 상수로 지정한 값 타입과 읽기 전용 프로퍼티는ㄴ 키 경로 서브스크립트로도 값을 바꿔줄 수 없습니다.
//macbook[keyPath: stuffNameKeyPath] = "macbook pro touch bar" // 오류 발생
//wimes[keyPath: \Person.name] = "bear" // 오류 발생


///mutating 키워드의 사용
//struct LevelStrut{
//    var level: Int = 0{
//        didSet{
//            print("Level \(level)")
//        }
//    }
//
//    mutating func levelUp(){
//        print("Level Up!")
//        level += 1
//    }
//
//    mutating func levelDown(){
//        print("Level Down")
//        level -= 1
//        if level < 0 {
//            reset()
//        }
//    }
//
//    mutating func jumpLevel(to: Int){
//        print("Jump to \(to)")
//        level = to
//    }
//
//    mutating func reset(){
//        print("Reset!")
//        level = 0
//    }
//}
//
//var levelStructInstance: LevelStrut = LevelStrut()
//levelStructInstance.levelUp() // Level Up!
//// Level 1
//
//levelStructInstance.levelDown() // Level Down
//// Level 0
//
//levelStructInstance.levelDown() // Level Down
//// Level -1
//// Reset!
//// evel 0
//
//levelStructInstance.jumpLevel(to: 3) // Jump to 3
//// Level 3


///self 프로퍼티와 mutating 키워드
//class LevelClass{
//    var level: Int = 0
//
//    func reset(){
//        //오류! self 프로퍼티 참조 변경 불가
//        self = LevelClass()
//    }
//}

struct LevelStrut{
    var level: Int = 0
    
    mutating func levelUp(){
        print("Level Up!")
        level += 1
    }
    
    ///self와 mutating
    mutating func reset(){
        print("Reset!")
        self = LevelStrut()
    }
}

var levelStructInstance: LevelStrut = LevelStrut()
levelStructInstance.levelUp() // Level Up!
print(levelStructInstance.level) // 1

levelStructInstance.reset() // Reset!
print(levelStructInstance.level) // 0

///self와 mutating
enum OnOffSwitch{
    case on, off
    mutating func nextState(){
        self = self == .on ? .off : .on
    }
}

var toggle: OnOffSwitch = OnOffSwitch.off
toggle.nextState()
print(toggle) //on


///클래스의 타입메서드
class AClass{
    static func staticTypeMethod(){
        print("AClass staticTypeMethod")
    }
    
    class func classTypeMethod(){
        print("Aclass classTypeMethods")
    }
}

class BCalss: AClass{
    /*
     // 오류 발생! 재정의 불가
     override sstatic func staticTypeMethod(){
     
     }
     */
    override class func classTypeMethod(){
        print("BClass classTypeMethod")
    }
}

AClass.staticTypeMethod() // AClass staticTypeMethod
AClass.classTypeMethod() // Aclass classTypeMethods
BCalss.classTypeMethod() // BClass classTypeMethod


///타입 프로퍼티와 타입메서드의 사용
// 시스템 용량은 한 기기에서 유일한 값이어야 합니다.
struct SystemVolume{
    // 타입 프로퍼티를 사용하면 언제나 유일한 값이 됩니다.
    static var volume: Int = 5
    
    // 타입 프로퍼티를 제어하기 위해 타입 메서드를 사용합니다.
    static func mute(){
        self.volume = 0// SystemVolume.volume = 0 과 같은 표현
                    // Self.volume = 0과도 같은 표현
    }
}

// 네비게이션 역할은 여러 인스턴스가 수행가능
class Navigation{
    // 네비게이션 인스턴스마다 음량을 따로 설정 가능
    var volume: Int = 5
    
    // 길 안내 음성 재생
    func guideWay(){
        // 네비게이션 외 다른 재생원 음소거
        SystemVolume.mute()
    }
    
    // 길 안내 음성 종료
    func finishGuideWay(){
        // 기존 재생원 음량 복구
        SystemVolume.volume = self.volume
    }
}

SystemVolume.volume = 10

let myNavi: Navigation = Navigation()

myNavi.guideWay()
print(SystemVolume.volume) // 0

myNavi.finishGuideWay()
print(SystemVolume.volume) // 5

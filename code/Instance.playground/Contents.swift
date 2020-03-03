///클래스, 구조체, 열거형의 기본적인 형태의 이니셜라이저
class SomeClass{
    init(){
        // 초기화할 때 필요한 코드
    }
}

struct SomeStruct{
    init(){
        // 초기화할 때 필요한 코드
    }
}

enum SomeEnum{
    case someCase
    
    init(){
        // 열거형은 초기화할 때 반드시 case중 하나가 되어야 합니다.
        self = .someCase
        // 초기화할 때 필요한 코드
    }
}


///실패 가능한 이니셜라이저
class Person{
    let name: String
    var age: Int?
    
    init?(name: String){
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
    
    init?(name: String, age: Int){
        if name.isEmpty || age < 0 {
            return nil
        }
        self.name = name
        self.age = age
    }
}

let wimes: Person? = Person(name: "wimes", age: 28)

if let person: Person = wimes{
    print(person.name)
}else{
    print("Person wasn't initialized")
}
// wimes

let eric: Person? = Person(name: "", age: 30)

if let person: Person = eric {
    print(person.name)
}else{
    print("Person wasn't initialized")
}
// Person wasn't initialized


///열거형의 실패 가능한 이니셜라이저
//enum Student: String {
//    case elementary = "초등학생", middle = "중학생", high = "고등학생"
//
//    init?(koreanAge: Int){
//        switch koreanAge {
//        case 8 ... 13:
//            self = .elementary
//        case 14 ... 16:
//            self = .middle
//        case 17 ... 19:
//            self = .high
//        default:
//            return nil
//        }
//    }
//
//    init?(bornAt: Int, currentYear: Int) {
//        self.init(koreanAge: currentYear - bornAt + 1)
//    }
//}
//
//var younger: Student? = Student(koreanAge: 16)
//print(younger) // Optional(__lldb_expr_1.Student.middle)
//
//younger = Student(bornAt: 2020, currentYear: 2016)
//print(younger) // nil
//
//younger = Student(rawValue: "대학생")
//print(younger) // nil
//
//younger = Student(rawValue: "고등학생")
//print(younger) // Optional(__lldb_expr_1.Student.high)


///클로저를 통한 student 프로퍼티 기본값 설정
struct Student {
    var name: String?
    var number: Int?
}

class SchoolClass {
    var students: [Student] = {
        // 새로운 인스턴스를 생성하고 사용자 정의 연산을 통한 후 반환해줍니다.
        // 반환되는 값의 타입은 [Student] 타입이어야 합니다.
        var arr: [Student] = [Student]()
        
        for num in 1 ... 15 {
            var student: Student = Student(name: nil, number: num)
            arr.append(student)
        }
        
        return arr
    }()
}

let myClass: SchoolClass = SchoolClass()
print(myClass.students.count) // 15


///FileManager클래스의 디이니셜라저 활용
class FileManager{
    var fileName: String
    
    init(fileName: String){
        self.fileName = fileName
    }
    
    func openFile(){
        print("Open File: \(self.fileName)")
    }
    
    func modifyFile(){
        print("Modify File: \(self.fileName)")
    }
    
    func writeFile(){
        print("Write File: \(self.fileName)")
    }
    
    func closeFile(){
        print("Close File: \(self.fileName)")
    }
    
    deinit {
        print("Deinit instance")
        self.writeFile()
        self.closeFile()
    }
}

var fileManager: FileManager? = FileManager(fileName: "abc.txt")

if let manager: FileManager = fileManager{
    manager.openFile() // Open File: abc.txt
    manager.modifyFile() // Modify File: abc.txt
}

fileManager = nil
// Deinit instance
// Write File: abc.txt
// Close File: abc.txt

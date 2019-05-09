import UIKit

//function is special type of closure
//self inside function is weak referenc by default
//when function is assigned to some variable, it hold strong reference to the owner class. regardless the self is called or not
//when closure want to make reference to owner class, it has to declare manually

class HtmlElement {
    var name: String
    var text: String
    var constant = 1
    
    init(_ name: String, _ text: String) {
        self.name = name
        self.text = text
    }
    
    lazy var description: (() -> Void)? = {
        [weak self] in
        print("closure name: \(String(describing: self?.name))")
    }
    
    func funcDescription() -> Void {
        print("func name: ")
    }
    
    func addSomeNumber(_ num:Int) -> (Int) -> Void {
        return { [weak self] (toBeadded) in
            print("closure inside function \(num + toBeadded + (self?.constant ?? 0))")
        }
    }
    
    deinit {
        print("Object HtmlElement \(self.name) is being deinitialized")
    }
}

//object element being created
var element: HtmlElement? = HtmlElement("p", "some paragraph")

//closure description being created
//element make reference to closure desctipion
//element?.description?()
//element?.description?()

//remove reference from element to closure
//element?.description = nil

var cDesc = element?.description

//remove reference to element
element = nil

cDesc?()

element = HtmlElement("div", "Some div")

var fDesc = element?.funcDescription

element = nil

fDesc?()

fDesc = nil

element = HtmlElement("span", "Some div")

var newFunc = element?.addSomeNumber(2)

element = nil

for _ in 0...10 {
    DispatchQueue.global().async {
        sleep(1)
        newFunc?(3)
    }
    
}


//closure is pass by reference

func independentFunct(_ name: inout String) -> Void {
    name = "alex"
    print(name)
}

var independentClosure: (inout String) -> Void = { (name) in
    name = "yahoo"
    print(name)
}

var theName = "google"

independentClosure(&theName)

print(theName)

independentFunct(&theName)

print(theName)






